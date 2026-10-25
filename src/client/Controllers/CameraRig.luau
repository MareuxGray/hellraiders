--!strict
-- Controller CameraRig: camera CFrame and FOV owner; every effect via CameraRig.request (ported).
-- Owning blueprint file: 04 §4.11. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local CameraRig = {}

CameraRig.Name = "CameraRig"

function CameraRig.init()
	-- Wired in S1.
end

function CameraRig.start()
	-- Started in S1.
end

return CameraRig
