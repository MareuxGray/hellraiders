--!nolint
-- Headless test runner for Lune (`lune run tests/lune/run`). It mirrors the Rojo tree as a virtual DataModel so
-- the real modules load unchanged (`require(script.Parent.Config)`, `game:GetService("ReplicatedStorage")`), and
-- it provides a TestEZ-compatible describe/it/expect so tests/unit/*.spec.luau run here and in Studio alike.
-- Exit code 1 on any failure. Roblox-only globals (Instance, Players…) are absent on purpose: modules must guard them.

local fs = require("@lune/fs")
local luau = require("@lune/luau")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

local ROOT = process.cwd
if not fs.isDir(`{ROOT}/src`) then
	error("run from the repo root: lune run tests/lune/run")
end

-- ---------------------------------------------------------------- Virtual instance tree

local Node = {}
Node.__index = function(self, key)
	local raw = rawget(Node, key)
	if raw ~= nil then
		return raw
	end
	local child = rawget(self, "_children")[key]
	if child ~= nil then
		return child
	end
	error(`{rawget(self, "Name")} has no child {tostring(key)}`, 2)
end

local function newNode(name, className, parent, filePath)
	local node = setmetatable({
		Name = name,
		ClassName = className,
		Parent = parent,
		_children = {},
		_order = {},
		_file = filePath,
	}, Node)
	if parent then
		parent._children[name] = node
		table.insert(parent._order, node)
	end
	return node
end

function Node.FindFirstChild(self, name)
	return self._children[name]
end
Node.WaitForChild = Node.FindFirstChild
function Node.GetChildren(self)
	return table.clone(self._order)
end
function Node.IsA(self, className)
	return self.ClassName == className
end
function Node.GetFullName(self)
	local parts = {}
	local n = self
	while n do
		table.insert(parts, 1, n.Name)
		n = n.Parent
	end
	return table.concat(parts, ".")
end
function Node.GetAttribute()
	return nil
end
function Node.SetAttribute() end

local function mount(dirPath, parent)
	for _, entry in fs.readDir(dirPath) do
		local full = `{dirPath}/{entry}`
		if fs.isDir(full) then
			local init = if fs.isFile(`{full}/init.luau`)
				then `{full}/init.luau`
				elseif fs.isFile(`{full}/init.lua`) then `{full}/init.lua`
				else nil
			local node = newNode(entry, if init then "ModuleScript" else "Folder", parent, init)
			mount(full, node)
		else
			local base, ext = string.match(entry, "^(.+)%.(luau?)$")
			if base and base ~= "init" then
				local name = base
				local className = "ModuleScript"
				local scriptKind = string.match(base, "%.(server)$") or string.match(base, "%.(client)$")
				if scriptKind then
					name = string.gsub(base, "%.server$", "")
					name = string.gsub(name, "%.client$", "")
					className = if scriptKind == "server" then "Script" else "LocalScript"
				end
				newNode(name, className, parent, full)
			end
		end
	end
end

local game = newNode("game", "DataModel", nil, nil)
local services = {}
local function service(name)
	local n = newNode(name, name, game, nil)
	services[name] = n
	return n
end
local ReplicatedStorage = service("ReplicatedStorage")
local ServerScriptService = service("ServerScriptService")
service("Players")
service("RunService")
local Shared = newNode("Shared", "Folder", ReplicatedStorage, nil)
mount(`{ROOT}/src/shared`, Shared)
local Packages = newNode("Packages", "Folder", ReplicatedStorage, nil)
if fs.isDir(`{ROOT}/Packages`) then
	mount(`{ROOT}/Packages`, Packages)
end
local Server = newNode("Server", "Folder", ServerScriptService, nil)
mount(`{ROOT}/src/server`, Server)
local Tests = newNode("Tests", "Folder", ServerScriptService, nil)
local Unit = newNode("unit", "Folder", Tests, nil)
mount(`{ROOT}/tests/unit`, Unit)

function game.GetService(_, name)
	return services[name] or error(`fake game has no service {name}`)
end
game.PlaceId = 0
game.JobId = "lune"

-- ---------------------------------------------------------------- Module loader

local cache = {}
local loading = {}
local testGlobals -- filled below
local fakeRequire

local function loadModule(node)
	if cache[node] ~= nil then
		return cache[node]
	end
	if loading[node] then
		error(`circular require at {node:GetFullName()}`)
	end
	local path = node._file
	if not path then
		error(`{node:GetFullName()} is not a ModuleScript`)
	end
	loading[node] = true
	local source = fs.readFile(path)
	-- luau.load copies the environment table, so test globals are set directly rather than via a metatable.
	local env = {}
	for k, v in testGlobals do
		env[k] = v
	end
	env.script = node
	env.require = fakeRequire
	env.game = game
	local chunk =
		luau.load(source, { debugName = string.gsub(path, ROOT .. "/", ""), environment = env, injectGlobals = true })
	local result = chunk()
	loading[node] = nil
	cache[node] = if result == nil then true else result
	return result
end

fakeRequire = function(target)
	if typeof(target) == "table" and getmetatable(target) == Node then
		return loadModule(target)
	end
	if typeof(target) == "string" then
		return require(target)
	end
	error(`require: unsupported target {tostring(target)}`)
end

-- ---------------------------------------------------------------- TestEZ-compatible harness

local results = { passed = 0, failed = 0, failures = {} }
local stack = {}

local function describe(name, fn)
	table.insert(stack, name)
	local ok, err = pcall(fn)
	if not ok then
		results.failed += 1
		table.insert(results.failures, `{table.concat(stack, " › ")}: describe body errored: {err}`)
	end
	table.remove(stack)
end

local function it(name, fn)
	local label = `{table.concat(stack, " › ")} › {name}`
	local ok, err = pcall(fn)
	if ok then
		results.passed += 1
	else
		results.failed += 1
		table.insert(results.failures, `{label}\n      {tostring(err)}`)
	end
end

local function expectation(value)
	local self = { value = value, negate = false }
	local function check(cond, msg)
		if self.negate then
			cond = not cond
			msg = "NOT " .. msg
		end
		if not cond then
			error(msg, 3)
		end
		return self
	end
	self.to = self
	self.be = self
	self.been = self
	self.a = function(typeName)
		return check(
			typeof(self.value) == typeName,
			`expected a {typeName}, got {typeof(self.value)} ({tostring(self.value)})`
		)
	end
	self.an = self.a
	self.equal = function(other)
		return check(self.value == other, `expected {tostring(other)}, got {tostring(self.value)}`)
	end
	self.ok = function()
		return check(self.value ~= nil, `expected a value, got nil`)
	end
	self.near = function(other, eps)
		eps = eps or 1e-7
		return check(
			typeof(self.value) == "number" and math.abs(self.value - other) <= eps,
			`expected {other} ± {eps}, got {tostring(self.value)}`
		)
	end
	self.throw = function(pattern)
		local ok, err = pcall(self.value)
		local matched = not ok and (pattern == nil or string.find(tostring(err), pattern, 1, true) ~= nil)
		return check(
			matched,
			if ok then "expected an error" else `error did not match {tostring(pattern)}: {tostring(err)}`
		)
	end
	return setmetatable(self, {
		__index = function(t, k)
			if k == "never" then
				t.negate = not t.negate
				return t
			end
			return nil
		end,
	})
end

testGlobals = {
	describe = describe,
	it = it,
	expect = expectation,
	beforeEach = function() end,
	afterEach = function() end,
	beforeAll = function(fn)
		fn()
	end,
	afterAll = function() end,
	FOCUS = function() end,
	SKIP = function() end,
}

-- ---------------------------------------------------------------- Run

local specs = {}
local function collect(node)
	for _, child in node:GetChildren() do
		if child._file and string.match(child._file, "%.spec%.luau$") then
			table.insert(specs, child)
		end
		collect(child)
	end
end
collect(Unit)
table.sort(specs, function(a, b)
	return a._file < b._file
end)

local t0 = os.clock()
for _, spec in specs do
	local ok, err = pcall(function()
		local body = loadModule(spec)
		if typeof(body) == "function" then
			body()
		end
	end)
	if not ok then
		results.failed += 1
		table.insert(results.failures, `{spec.Name}: {tostring(err)}`)
	end
end

local ms = math.floor((os.clock() - t0) * 1000)
for _, f in results.failures do
	stdio.ewrite(`FAIL {f}\n`)
end
print(`TESTS passed {results.passed} failed {results.failed} ({#specs} spec files, {ms} ms)`)
if results.failed > 0 then
	process.exit(1)
end
