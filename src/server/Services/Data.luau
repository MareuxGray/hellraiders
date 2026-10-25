--!strict
-- Service Data: ProfileStore wrapper, save/release, receipts list.
-- Owning blueprint file: 25 §25.5. Built in step S3. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Data = {}

Data.Name = "Data"

function Data.init()
	-- Wired in S3.
end

function Data.start()
	-- Started in S3.
end

return Data
