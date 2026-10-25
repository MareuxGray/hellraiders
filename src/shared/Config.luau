--!strict
-- HellRaiders shared configuration. Every number in the game lives here, copied from the blueprint.
-- blueprint/02-shared-values.md wins for the shared values; each system's owning file supplies the rest.
-- Section comments name the source. Units: studs, seconds, studs/s, kg, degrees, Mall Cash unless marked Robux.
-- tools/check_numbers.py --config src/shared/Config.luau verifies the 02 keys verbatim: keep the leaf names and
-- inline table order exactly as written in 02 (e.g. `Aim = { Fwd = 8, Side = 6, Back = 4.8 }`).
-- Placeholder values that Mareux must fill are marked PLACEHOLDER and listed in Handoff.md.

local Config = {}

-- ---------------------------------------------------------------- Places and universe (25 §25.1, §25.2, 02 §2.1)
-- PLACEHOLDER: PlaceIds are 0 until the HellRaiders-Dev universe exists (S0 step 2, Mareux). Bootstrap matches
-- game.PlaceId against Dev and Live; 0 never matches, so Studio falls back to Config.Places.StudioDefault.
Config.Places = {
	Arrival = { Dev = 0, Live = 0, MaxPlayers = 50 },
	Tower = { Dev = 0, Live = 0, MaxPlayers = 50 },
	Mall = { Dev = 0, Live = 0, MaxPlayers = 12 },
	StudioDefault = "Mall", -- which place a Studio session with an unknown PlaceId boots as
}

-- ---------------------------------------------------------------- Players, squads, servers (02 §2.1)
Config.Squad = { Max = 3 }
Config.Queue = { Pools = { "Solo", "Duo", "Trio" }, MaxWait = 45 }
Config.Raid = {
	MaxPlayers = { Solo = 10, Duo = 12, Trio = 12 },
	MinPlayers = 4,
	ReconnectWindow = 120,
	-- 02 §2.2 raid timing
	Length = 1200,
	SpawnProtect = 20,
	MaxLength = 1305, -- 1020 + 120 + 45 + 90 + 30; no raid lasts past this (02 §2.2 rule)
	-- 03 §3.2 server states
	LoadingCap = 30,
	DeployTime = 6,
	SealedTime = 3,
	ResultsTime = 8,
	-- 03 §3.3 spawning
	GateOrder = { "A", "D", "B", "C" },
	SoloGateSplit = { 3, 3, 2, 2 },
	SpawnProtectZombieIdleRadius = 40,
	-- 03 §3.4 clock events
	FailsafeWarnAt = 960,
	-- 25 §25.5 crash rule: pendingRaid is stale after MaxLength + this grace
	PendingRaidGrace = 300,
}
Config.Tower = { Flats = { Bunk = 32, Executive = 24, Penthouse = 8 }, AnnexAt = 46 }

-- ---------------------------------------------------------------- Evac and The Janitor (02 §2.2, 10)
Config.Janitor = {
	EnterAt = 480,
	-- 08 §8.7
	PatrolSpeed = 8,
	ChaseSpeed = 18,
	HearingMult = 1.5,
	Sight = 30,
	NoiseMemory = 20,
	GrabRange = 4,
	GrabWindUp = 0.6,
	GrabDamage = 60,
	GrabThrow = 8,
	GrabCooldown = 6,
	StunTime = 6,
	StunRange = 10,
	StaggerDamage = 120,
	StaggerWindow = 5,
	StaggerTime = 1.5,
	BarricadeBreak = 2,
	ShutterBash = 3,
	CartAudible = 60,
	BreathAudible = 20,
	SilentBeforeGrab = 3,
	Scale = 1.4,
}
Config.Evac = {
	TerminalsUnlockAt = 600,
	AutoStartAt = 1020,
	ActivateHold = 5,
	Countdown = 120,
	OpenWindow = 45,
	EarlyDepartHold = 3,
	Lockdown = 90,
	ReopenWindow = 30,
	HordeSpeedMult = 2,
	-- 10
	Exits = { "Helipad", "Garage" },
	ActivateNoise = 60,
	ActivateMoveCancel = 2,
	ExtraWalkersOnRedAlert = 10,
	TransformTime = 2.5,
	CinematicTime = 4,
	MutateNowFrom = 300, -- 09 §9.13
}

-- ---------------------------------------------------------------- Movement (02 §2.3, 04)
Config.Move = {
	Walk = 12,
	Sprint = 22,
	Crouch = 6,
	Aim = { Fwd = 8, Side = 6, Back = 4.8 },
	Back = 7.2,
	JumpEnabled = false,
	InputBuffer = 0.15,
	EdgeGrace = 0.12,
	Prone = { Speed = 3, Height = 2, Sight = 0.4, Hold = 0.5, Down = 0.6, Up = 0.7 },
	-- 04 §4.2
	IdleAfter = 5,
	BoredAfter = 25,
	Accel = 60,
	Decel = 80,
	FootMatchWalk = 2.0,
	FootMatchRun = 2.4,
	AutoSprintStick = 0.9,
	LowHealthSpeedMult = 0.9,
	LowHealthBelow = 25,
	StandHeadroom = 6,
	LowCoverCeiling = 4.5,
	CrawlCeiling = 2.5,
	DownedCrawl = 2,
}
Config.Body = { FreeLookCone = 60, LeanMax = 8, GroundMax = 1.2 } -- 04 §4.3
Config.AM = {
	Step = { Min = 1.0, Max = 2.5 },
	Ledge = { Min = 4.5, Max = 7.5, Time = 1.4, Stamina = 15 },
	-- 04 §4.6
	StepSpeedMult = 0.85,
	StepSpeedTime = 0.3,
	Mantle = { Min = 2.5, Max = 4.5, Time = 0.9, Stamina = 10, WalkableTop = 2, Headroom = 6 },
	Vault = { Time = 0.55, KeepSpeed = 0.8, Stamina = 10 },
	Hang = { DropOver = 6, CatchBelow = 1 },
	HangMove = { ClimbTime = 0.9, HopDistance = 2.5 },
	EdgeDrop = { Min = 8, Max = 14 },
	Ladder = { Speed = 6, Noise = 12 },
	Window = { SillMin = 2, SillMax = 4.5, Time = 1.1, Stamina = 10 },
	MaxClimb = 7.5,
	LandingNoise = 18,
	LedgeNoise = 18,
	Budget = 0.0003, -- seconds per frame
	ClipTarget = 0.2,
}
Config.Roll = { Time = 0.6, Distance = 9, Cooldown = 1.0, Stamina = 20, Noise = 20 } -- 04 §4.4
Config.Slide = {
	SpeedMult = 1.2,
	TimeWalk = 0.8,
	TimeSprint = 1.6,
	EndSpeedMin = 5,
	EndSpeedMax = 10,
	Cooldown = 1.8,
	Stamina = 15,
	Noise = 25,
	ExitHold = 0.35,
	Tackle = { PlayerRagdoll = 1.5, WalkerDown = 2.0, Immunity = 2.0 },
	Camera = { DropMin = 0.7, DropMax = 1.4, PullIn = 0.8, FOV = 8, RollMult = 0.7, LeanMax = 10, RollClamp = 22 },
} -- 04 §4.5
Config.Fall = {
	RollWindow = 0.2,
	RollCut = 0.5,
	-- 02 §2.3 / 04 §4.7 bands: { from, to, damage, legFractureChance }
	Bands = {
		{ From = 12, To = 20, Damage = 20, Fracture = 0.3 },
		{ From = 20, To = 30, Damage = 45, Fracture = 1.0 },
	},
	DeathAbove = 30,
	SoftLandFrom = 6,
	HardLandFrom = 12,
	HardLandNoControl = 0.4,
	RagdollFrom = 20,
	RagdollTime = 1.2,
	NoiseSoft = 18,
	NoiseHard = 30,
}
Config.Ragdoll = { GetUpTime = 0.9, CorpseAnchorAfter = 3, MaxSimulatedPerClient = 8 } -- 04 §4.8, 25 §25.7
Config.Pose = { RateHz = 20, MaxBytesPerSecond = 1536 } -- 04 §4.10

-- ---------------------------------------------------------------- Camera (04 §4.11)
Config.Cam = {
	Dist = { Default = 9, Sprint = 10, Aim = 4.8 },
	Shoulder = { X = 2.2, Y = 1.6 },
	FOV = { Default = 70, Sprint = 78, Aim = 50 },
	Lag = 12,
	AimLookScale = 0.65,
	Pitch = { Min = -70, Max = 60 },
	Wall = { Radius = 0.6, EaseOut = 6 },
	SwapTime = 0.25,
	AimBlur = 8,
	Effects = {
		BreathSwayRest = 0.05,
		BreathSwayMax = 0.35,
		FearShakeFrom = 40,
		FearShakeMax = 0.6,
		HitPunch = 2,
		HitPunchTime = 0.15,
		TackleDist = 3.5,
		TackleTilt = 8,
		BiteFlash = 0.4,
		BiteRoll = 4,
		BiteLowPass = 1,
		EventShake = 0.8,
		EventShakeTime = 0.3,
		EventRadius = 15,
		ScreechBlur = 2,
		LockdownShake = 1.5,
		LockdownShakeTime = 0.6,
		RagdollLag = 0.3,
		DownedHeight = 1.5,
		DownedDesaturate = 0.5,
		ReduceMotionScale = 0.25,
	},
	Mutant = { StalkerDist = 7, StalkerFOV = 80, SuperDist = 11, SuperFOV = 85, SurfaceBlend = 0.3, GhostDist = 10 },
}

-- ---------------------------------------------------------------- Attributes and stats (02 §2.4, 05)
Config.Attr = {
	Pool = 25,
	Min = 3,
	Max = 7,
	Neutral = 5,
	Names = { "Endurance", "Strength", "Composure", "Marksmanship", "Stealth" },
	-- 05 §5.2 curves indexed by value 3..7 (index 1 = value 3)
	Endurance = { MaxStamina = { 0.80, 0.90, 1.00, 1.12, 1.25 }, Regen = { 0.85, 0.92, 1.00, 1.10, 1.20 } },
	Strength = { BaseCarry = { 10, 12, 14, 16, 18 } },
	Composure = { FearGain = { 1.00, 0.93, 0.85, 0.78, 0.70 }, Incubation = { 0.90, 0.95, 1.00, 1.05, 1.10 } },
	Marksmanship = { Sway = { 1.25, 1.12, 1.00, 0.90, 0.80 } },
	Stealth = { Noise = { 1.15, 1.08, 1.00, 0.92, 0.85 } },
}
Config.Health = {
	Max = 100,
	-- 05 §5.6
	LowBelow = 50,
	CriticalBelow = 25,
	LightBleed = 1,
	HeavyBleed = 3,
	BloodTrailEvery = 2,
	BloodTrailTime = 60,
	HeavyBleedFromHit = 40,
	HeavyBleedFromHitChance = 0.3,
	LimbFractureDamage = 20,
	LimbFractureChance = 0.15,
	Zones = { "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg" },
	Downed = { Crawl = 2, BleedOut = 30, ReviveHold = 4, ReviveRange = 2.5, ReviveHealth = 25, KillDamage = 25 },
}
Config.Stamina = {
	Base = 100,
	SprintDrain = 12,
	Cost = { Roll = 20, Slide = 15, Vault = 10, Shove = 10, HeavyMelee = 15, Ledge = 15 },
	HoldBreathDrain = 20,
	Regen = 15,
	RegenDelay = 1,
	-- 05 §5.5
	BlockBelow = 20,
	LowPenaltyBelow = 20,
	HeavyBreathBelow = 30,
	GaspNoise = 25,
	ZeroAimPenalty = 0.2,
}
Config.Fear = {
	Max = 100,
	BoostAt = 60,
	RearmBelow = 40,
	BoostSpeed = 0.15,
	BoostTime = 4,
	BoostAimPenalty = 0.30,
	BoostRegenPenalty = 0.5,
	BoostRegenTime = 6,
	BoostCooldown = 20,
	Decay = 4,
	DecayNoThreatRadius = 30,
	DecayAfter = 5,
	-- 05 §5.4 scare table: { amount, cooldown per source }
	Scare = {
		FirstSight = { Amount = 8, Cooldown = 10, Radius = 15 },
		Lunge = { Amount = 25, Cooldown = 0 },
		DamageMult = 0.3,
		LoudSound = { Amount = 6, Cooldown = 3, Radius = 20 },
		SeeJanitor = { Amount = 20, Cooldown = 20, Radius = 30 },
		HearCart = { Amount = 10, Cooldown = 30, Radius = 40 },
		SquadDowned = { Amount = 15, Cooldown = 0, Radius = 30 },
		RedAlert = { Amount = 15, Cooldown = 0 },
		Lockdown = { Amount = 30, Cooldown = 0 },
		Screech = { Amount = 20, Cooldown = 0, Radius = 15 },
		Pounce = { Amount = 20, Cooldown = 0 },
	},
	-- 05 §5.3 penalties
	AimPenaltyFrom = 30,
	AimPenaltyMax = 0.35,
	HeartbeatFrom = 40,
	HeartbeatBpm = { Min = 60, Max = 140 },
}
Config.Aim = { LowHealthPenalty = 0.15, ArmFracturePenalty = 0.25, SwayBase = 0.4, HoldBreathSwayCut = 0.7 } -- 05 §5.3, 07 §7.3
Config.Visibility = { Stand = 1, Crouch = 0.6, Lit = 1, Dark = 0.375 } -- 05 §5.3
Config.Carry = {
	Heavy = { From = 0.7, SprintMult = 0.85, DrainMult = 1.5, NoiseMult = 1.3 },
	Over = { From = 1.0, WalkMult = 0.75 },
	PackBonus = { Satchel = 6, FieldPack = 12, TacticalBag = 18 },
}
Config.Injury = {
	Leg = { WalkMult = 0.7, NoiseMult = 1.5 },
	Arm = { AimPenalty = 0.25, ReloadMult = 1.4, RecoilMult = 1.3 },
}
Config.Medical = { -- 05 §5.7: use time and effect per item id
	CancelBefore = 0.5,
	OthersRange = 3,
	OthersTimeMult = 1.25,
	StrangerHealXP = 25,
	StrangerReviveXP = 50,
	Items = {
		["ITM-MED-001"] = { Time = 2.0, Heal = 5, StopsLight = true, HeavyToLight = true },
		["ITM-MED-002"] = { Time = 2.5, Heal = 10, StopsAny = true },
		["ITM-MED-003"] = { Time = 1.0, Duration = 60 },
		["ITM-MED-004"] = { Time = 5.0, Heal = 60, HealPerSecond = 12, StopsLight = true },
		["ITM-MED-005"] = { Time = 4.0, Fractures = 1 },
		["ITM-MED-006"] = { Time = 7.0, Heal = 25, Fractures = 99, StopsHeavy = true },
		["ITM-MED-007"] = { Time = 1.5, SuppressPause = 90 },
		["ITM-MED-010"] = { Time = 2.0, SuppressPause = 90 },
		["ITM-MED-008"] = { Time = 3.0, Cure = true },
		["ITM-MED-009"] = { Time = 1.0, Stamina = 40, FearBoost = true, Fear = 10 },
	},
	TaintedVeinRange = 3,
}

-- ---------------------------------------------------------------- Noise (02 §2.5, 06 §6.1)
Config.Noise = {
	Crouch = 0,
	Walk = 12,
	Sprint = 30,
	Roll = 20,
	Slide = 25,
	Vault = 18,
	Search = 8,
	Craft = 35,
	Melee = 15,
	Gun = 250,
	GunSuppressed = 50,
	Glass = 120,
	Shards = { Walk = 15, Sprint = 30 },
	Shutter = 40,
	Door = 50,
	Alarm = 200,
	AlarmTime = 20,
	Decoy = { Radius = 150, Time = 12, Delay = 3 },
	Generator = 150,
	GeneratorHum = 20,
	Scanner = 20,
	Boombox = 100,
	BoomboxEvery = 2,
	Trap = 60,
	Voice = 25, -- 20 §20.1, every 2 s while loud
	VoiceEvery = 2,
	QuickLine = 30,
	Barricade = 35,
	Pry = 60,
	LightShot = 30,
	Terminal = 60,
	Nightjar = 60,
	Bottle = 60,
	Brick = 40,
	Wall = 120,
	Elevator = 40,
	-- 06 §6.1 floor rules
	OtherFloorMult = 0.5,
	FootstepEvery = 0.5,
	SampleHz = 10,
}
Config.Shutter = { Muffle = 0.5, StepHold = 1.0, TravelTime = 2.0, LoseTrackAfter = 10, HalfCrouchTime = 1.2 } -- 06 §6.2

-- ---------------------------------------------------------------- Vision and light (02 §2.6, 06 §6.3)
Config.Sight = { ZombieCone = 50, ZombieLit = 40, ZombieDark = 15, CrouchMult = 0.6, ProneMult = 0.4, CrawlerMax = 10 }
Config.Flashlight = { Cone = 30, Range = 45, Battery = 300, Beacon = 120, FlickerLast = 20 }
Config.Light = { EmergencyRadius = 4, LitFactor = 1, DarkFactor = 0.375 }

-- ---------------------------------------------------------------- World (06 §6.4–6.9)
Config.World = {
	GeneratorHold = 6,
	Generators = {
		North = { "FoodCourt", "DepartmentStore", "Pharmacy" },
		East = { "Electronics", "Cinema" },
		Service = { "Maintenance", "SecurityOffice" },
	},
	Glass = { Sizes = { "Small", "Medium", "Large" } },
	WallChunkSim = 3,
	Door = { OpenTime = 0.5, SecurityOpenTime = 1.2, GhostLock = 6 },
	Barricade = { Hold = 3, Planks = 3, MeleeHits = 3, AxeHits = 1, StalkerBreak = 4 },
	Wedge = { Hold = 1, Time = 30 },
	Pry = { Hold = 6 },
	Alarm = { ArmedPerRaid = 6, Marked = 12, DisarmHold = 3 },
	Trap = { Points = 20, Reset = 30 },
	Elevator = { Capacity = 4, PerFloor = 3 },
	Escalator = { Speed = 4 },
	MedSafes = 4,
	MedSafeCodeDigits = 4,
	KeycardWings = { "FoodCourt", "Electronics", "DepartmentStore", "Pharmacy", "Security" },
	FuelCansPerRaid = 3,
}

-- ---------------------------------------------------------------- Struggle and infection (02 §2.7, 09)
Config.Struggle = {
	Mode = "Bar",
	-- struggle number → zone width (fraction), needle period (s, one way), time limit (s)
	Steps = {
		{ Zone = 0.30, Period = 1.6, Limit = 5.0 },
		{ Zone = 0.20, Period = 1.3, Limit = 3.0 },
		{ Zone = 0.12, Period = 1.0, Limit = 1.5 },
	},
	InstantFrom = 4,
	Escape = 1.5,
	ShoveBack = 6,
	ShoveDamage = 10,
	Tolerance = 0.1, -- 09 §9.2 server check
	TutorialZone = 0.5,
	InterceptXP = 25,
	InterceptStrangerXP = 50,
	FeedingTime = 2,
}
Config.Infection = {
	Incubation = 180,
	SuppressPause = 90,
	Antidotes = { 1, 3 },
	TurningWarnAt = 20,
	-- 09 §9.5 symptoms by progress
	Symptoms = {
		Cough = { From = 0.2, StillFor = 4, EveryMin = 15, EveryMax = 25, Audible = 12 },
		Tremor = { From = 0.4, Amplitude = 0.6 },
		Heartbeat = { From = 0.6, Audible = 6 },
		Veins = { From = 0.7, FlashlightRange = 10 },
		Twitch = { From = 0.9, EveryMin = 8, EveryMax = 12 },
	},
	-- 09 §9.6 sabotage
	Sabotage = {
		TripRange = 8,
		TripHold = 1.0,
		TripCooldown = 60,
		TaintTime = 2,
		ScentHold = 1,
		ScentTime = 20,
		ScentCooldown = 90,
	},
	AIForgiveAfter = 15, -- 08 §8.4
	AntidoteValue = 15000,
}
Config.Scanner = {
	Time = 3,
	Range = 4,
	Thermometer = { Uses = 3, Time = 3, Range = 4, FeverFrom = 0.3 },
	Blood = { Uses = 1, Time = 5, Range = 2, Audible = 8 },
}
Config.Ghost = { -- 09 §9.10
	ThermalRange = 40,
	PriorityTime = 10,
	Tools = {
		SlamDoor = { Range = 30, Cooldown = 20 },
		TriggerAlarm = { Range = 40, Cooldown = 30 },
		SmashGlass = { Range = 30, Cooldown = 25 },
		Interference = { Range = 25, Cooldown = 30, Time = 4, OffFraction = 0.7 },
	},
	MutateTime = 1.5,
}
Config.Mutant = { -- 02 §2.9, 09 §9.11–9.12
	Stalker = {
		HP = 250,
		Run = 20,
		Sprint = 26,
		Climb = 12,
		Claw = { Damage = 30, Time = 0.7, Bleed = 0.4 },
		Pounce = { Damage = 45, Range = 12, Knockdown = 1, HeavyBleed = 0.5, Cooldown = 8 },
	},
	Super = {
		BaseHP = 1200,
		HPPerHuman = 300,
		HPHumansAbove = 2,
		PaidHPCap = 3000,
		Run = 22,
		Sprint = 28,
		Slam = { Damage = 55, Arc = 6, Fracture = 0.25, HeavyBleed = 0.5, Cooldown = 1.2 },
		Charge = { Distance = 14, Speed = 45, Damage = 70, Knockdown = 1.5, Cooldown = 10 },
		Screech = { Time = 9, Radius = 55, StunRadius = 11, Blur = 2, FlashlightOff = 4, Cooldown = 25 },
		CeilingDrop = { Damage = 30, Radius = 4 },
		HeadshotMult = 1.5,
		UVBlind = 4,
		ReviveWindow = 10,
		ReviveKnockback = 10,
		ReviveRadius = 12,
		Variants = {
			Brute = {},
			Banshee = { ScreechRadius = 80, ScreechCooldown = 18, StunRadius = 14, HPMult = 0.8 },
			Creeper = { SurfaceSpeedMult = 1.3, ChargeCooldown = 7, HPMult = 0.75, Slam = 45 },
			Juggernaut = { HPMult = 1.4, CeilingRun = false, SlamRadius = 8, ChargeCooldown = 14 },
		},
	},
	-- 09 §9.15 Mutant Rep
	Rep = {
		StalkerDown = 20,
		StalkerKill = 40,
		SuperKill = 40,
		LockdownWin = 100,
		GhostDown = 15,
		GhostTool = 5,
		GhostToolWindow = 10,
	},
}

-- ---------------------------------------------------------------- Combat (02 §2.8, 07)
Config.Combat = {
	AllowHipFire = false,
	RewindMax = 0.25,
	MuzzleTolerance = 3,
	SwapTime = 0.6,
	PistolSwapTime = 0.4,
	PickupHold = 0.4,
}
Config.WeaponPose = { AimIkBlend = 0.6 }
Config.AimDot = { Mobile = true, SizePx = 2, Opacity = 0.4 }
Config.Guns = {
	-- Damage (torso), RPM, Mag, Ammo, falloff start, min damage fraction; 07 §7.3 recoil; 07 §7.4 reload
	P9 = {
		Damage = 25,
		RPM = 300,
		Mag = 12,
		Ammo = "Light",
		Falloff = 40,
		MinDmg = 0.6,
		Kick = 1.6,
		Horiz = 0.5,
		Recover = 10,
		Sway = 1.0,
		Reload = 1.6,
		Item = "ITM-GUN-001",
	},
	Wasp = {
		Damage = 16,
		RPM = 750,
		Mag = 30,
		Ammo = "Light",
		Falloff = 30,
		MinDmg = 0.5,
		Kick = 0.9,
		Horiz = 0.6,
		Recover = 12,
		Sway = 1.1,
		Reload = 2.2,
		Item = "ITM-GUN-002",
	},
	Brace = {
		Damage = 9,
		Pellets = 8,
		RPM = 70,
		Mag = 6,
		Ammo = "Shells",
		Falloff = 12,
		MinDmg = 0.2,
		Kick = 5.0,
		Horiz = 1.0,
		Recover = 8,
		Sway = 1.0,
		ReloadPerShell = 0.55,
		Item = "ITM-GUN-003",
	},
	Kestrel = {
		Damage = 22,
		RPM = 600,
		Mag = 30,
		Ammo = "Medium",
		Falloff = 70,
		MinDmg = 0.7,
		Kick = 1.1,
		Horiz = 0.45,
		Recover = 11,
		Sway = 1.2,
		Reload = 2.4,
		Item = "ITM-GUN-004",
	},
	Longhorn = {
		Damage = 70,
		RPM = 45,
		Mag = 5,
		Ammo = "Heavy",
		Falloff = 150,
		MinDmg = 0.85,
		Kick = 6.0,
		Horiz = 0.8,
		Recover = 6,
		Sway = 1.5,
		ReloadPerRound = 0.7,
		Item = "ITM-GUN-005",
	},
	Nightjar = {
		Damage = 24,
		RPM = 600,
		Mag = 30,
		Ammo = "Medium",
		Falloff = 70,
		MinDmg = 0.7,
		Kick = 0.8,
		Horiz = 0.45,
		Recover = 11,
		Sway = 1.2,
		Reload = 2.4,
		Noise = 60,
		Suppressed = true,
		Item = "ITM-GUN-006",
	},
	Revenant = {
		Damage = 55,
		RPM = 180,
		Mag = 6,
		Ammo = "Heavy",
		Falloff = 50,
		MinDmg = 0.7,
		Kick = 4.0,
		Horiz = 0.8,
		Recover = 8,
		Sway = 1.2,
		Reload = 2.0,
		Item = "ITM-GUN-007",
	}, -- PLACEHOLDER: recoil and reload not in blueprint (docs/questions.md)
}
Config.Ammo = { Stack = { Light = 60, Medium = 60, Heavy = 20, Shells = 24 } }
Config.Attachments = { -- 07 §7.5
	RedDot = { Slot = "Sight", AimFOV = 45, AimIn = 0.15, Fits = { "Wasp", "Kestrel", "P9" } },
	Scope = { Slot = "Sight", AimFOV = 20, SwayMult = 1.2, Fits = { "Kestrel", "Longhorn" } },
	Suppressor = { Slot = "Muzzle", Noise = 50, DamageMult = 0.9, Fits = { "P9", "Wasp", "Kestrel" } },
	ExtendedMag = { Slot = "Mag", MagMult = 1.5, ReloadMult = 1.1, Fits = { "P9", "Wasp", "Kestrel" } },
	Foregrip = { Slot = "Underbarrel", KickMult = 0.75, Fits = { "Wasp", "Kestrel", "Brace" } },
	Thermal = { Slot = "Sight", AimFOV = 40, Range = 40, Fits = { "Kestrel", "Longhorn", "Nightjar" } }, -- PLACEHOLDER: Thermal Sight fit list not in blueprint
	DefaultAimIn = 0.25,
	AttachTime = 0.5,
}
Config.Damage = {
	Head = { Player = 2.0, Zombie = 3.0, Helmet = 1.4 },
	Limb = { Mult = 0.7, FractureChance = 0.15, FractureMinDamage = 20 },
	FalloffEndMult = 2,
}
Config.Armour = {
	Light = { Reduce = 0.30, Durability = 200, Kg = 4 },
	Heavy = { Reduce = 0.50, Durability = 400, Kg = 9 },
	Bastion = { Reduce = 0.60, Durability = 500, Kg = 7 },
	RepairScrap = 1,
	RepairMC = 200,
	RepairPer = 50,
}
Config.Helmet = { HeadMult = 1.4, Durability = 120, Kg = 2 }
Config.Melee = {
	Fists = { Damage = 8, Swing = 0.5, Range = 2.5 },
	Pipe = { Damage = 25, Swing = 0.6, Range = 3.5 },
	Crowbar = { Damage = 30, Swing = 0.75, Range = 3.5 },
	FireAxe = { Damage = 50, Swing = 1.1, Range = 4.0 },
	Heavy = { DamageMult = 1.8, SwingMult = 1.6, Stamina = 15, Hold = 0.6 },
	Stagger = 0.6,
}
Config.Shove = { Damage = 0, Knockback = 6, Stamina = 10, Cooldown = 1.0, Range = 2.5, PlayerStagger = 0.5 }
Config.Takedown = { Range = 3, RearAngle = 120, Hold = 1.2 }
Config.Throw = { MinHold = 0.3, MaxHold = 1.0, RangeMin = 10, RangeMax = 30 }
Config.Throwables = { -- 07 §7.12
	Bottle = { Noise = 60, BreaksGlass = { "Small", "Medium" } },
	Brick = { Noise = 40, BreaksGlass = { "Small", "Medium", "Large" }, HeadStun = 1 },
	NoiseDecoy = { Delay = 3, Noise = 150, Time = 12 },
	Molotov = { Radius = 5, Time = 10, Dps = 15, SquadMult = 0.5 },
	UVFlare = { Time = 8, JanitorStun = 6, BlindRadius = 10, BlindTime = 4 },
	SmokeCan = { Radius = 8, Time = 15 },
}
Config.AimAssist = { MagnetAI = 4, MagnetPlayer = 2, PullRate = 20, SlowInside = 6, SlowMult = 0.6 }
Config.PvP = { FriendlyFire = false, UnprovokedWindow = 30 } -- 07 §7.7

-- ---------------------------------------------------------------- Enemies (02 §2.9, 08)
Config.Zombie = {
	Walker = {
		HP = 60,
		Patrol = 4,
		Chase = 13,
		LungeRange = 6,
		LungeWindUp = 0.5,
		LungeCooldown = 4,
		LungeLeap = 6,
		HeadMult = 3,
	},
	Crawler = { HP = 40, Patrol = 3, Chase = 9, GrabRange = 3, HeadMult = 3 },
	Sprinter = { HP = 90, Patrol = 10, Chase = 24, Swipe = 15, SwipeBleed = 0.25, HeadMult = 2 },
}
Config.AI = {
	MaxActive = 40,
	NearCap = 24,
	NearRadius = 120,
	DormantBeyond = 160,
	-- 08 §8.2
	WanderRadius = 25,
	InvestigateLook = 6,
	AlertTime = 1.0,
	LoseSightAfter = 4,
	SearchTime = 8,
	LungeMissStumble = 1.2,
	RepathEvery = 0.5,
	CorpseDespawn = 90,
	CorpseDespawnRadius = 40,
	IdleGroanMin = 6,
	IdleGroanMax = 14,
	-- 08 §8.3
	SightHzIdle = 4,
	SightHzChase = 10,
	ScentRange = 20,
	CallRadius = 25,
	-- 08 §8.5
	UpdateHz = { Chase = 10, Investigate = 4, Search = 4, Idle = 2, Wander = 2, Dormant = 0 },
	Agents = {
		Walker = { Radius = 1.5, Height = 5 },
		Crawler = { Radius = 1.5, Height = 2 },
		Janitor = { Radius = 2.5, Height = 7 },
	},
	PathCost = { Shards = 1, Fire = 50, Glass = 1 },
	FrameBudgetMs = 4,
	-- 08 §8.6
	Spawn = { Walkers = { 30, 36 }, Crawlers = { 6, 8 }, GateExclusion = 40, WalkerPoints = 60, CrawlerPoints = 12 },
	Reinforce = { Every = 120, Max = 4, MinDistance = 50, ServiceDoors = 24 },
	Surge = { SpeedMult = 2 },
}

-- ---------------------------------------------------------------- Inventory and loot (02 §2.10–2.11, 11)
Config.Inv = { Pockets = 4, SafePocket = 1, BlueprintSlot = 1, Quick = 4 }
Config.Packs = { None = nil, Satchel = { 4, 4 }, FieldPack = { 5, 6 }, TacticalBag = { 6, 8 } }
Config.Stash = {
	Bunk = { 10, 15 },
	Executive = { 15, 20 },
	Penthouse = { 20, 30 },
	AmmoLocker = { 10, 10 },
	ExpansionRows = 5,
	ExpansionsMax = 2,
	-- 19 §19.8 also sells Stash Expansion I/II/III at +3 rows each; 02 says +5 rows, 2 passes. 02 wins for shared
	-- values; the conflict is logged in docs/questions.md.
}
Config.Reveal = {
	Time = { Common = 0.3, Uncommon = 0.5, Rare = 0.8, Epic = 1.2, Exotic = 1.8, Relic = 2.6 },
	ExoticCameraPush = 0.3,
	RevealedReopen = 0.6,
}
Config.Container = { OpenHold = 1.2, LockedExtraHold = 2.0, CancelMove = 1.5, SearchNoisePerSecond = 8 }
Config.Corpse = { RevealPerSlot = 0.6, OpenHold = 1.2 }
Config.Tier = {
	Order = { "Common", "Uncommon", "Rare", "Epic", "Exotic", "Relic" },
	Common = { 170, 170, 170 },
	Uncommon = { 92, 190, 92 },
	Rare = { 70, 140, 230 },
	Epic = { 170, 90, 230 },
	Exotic = { 235, 180, 60 },
	Relic = { 235, 60, 60 },
	Shapes = {
		Common = "Circle",
		Uncommon = "Triangle",
		Rare = "Square",
		Epic = "Diamond",
		Exotic = "Star",
		Relic = "Crown",
	},
}
Config.Loot = { -- 11 §11.3, §11.6
	BlueprintChance = 0.04,
	BlueprintChanceByClass = { WeaponCrate = 0.08, StockroomCrate = 0.15, MedSafe = 0 },
	BlueprintTierWeights = { Common = 50, Rare = 30, Epic = 15, Exotic = 5 },
	MaxBlueprintsPerContainer = 1,
	WingBiasMult = 2.0, -- "+100%" for the wing's favoured categories
	WorldRelicsPerRaid = 6,
	BlankVinylExoticShare = 0.01,
	NightjarWeaponCrateExotic = 0.02,
	GlintRange = 6,
	ContainerTarget = { Min = 215, Max = 235 },
}

-- ---------------------------------------------------------------- Crafting and wheel (12)
Config.Craft = {
	FieldBenches = 8,
	BenchSpeedMult = 0.8,
	Learn = 2,
	FlatTiers = {
		Common = { MC = 1000, Minutes = 5 },
		Rare = { MC = 4000, Minutes = 20 },
		Epic = { MC = 10000, Minutes = 60 },
		Exotic = { MC = 25000, Minutes = 180 },
	},
	QueueSlots = { Bunk = 1, Executive = 2, Penthouse = 3 },
	TraySlots = 10,
	VIPTimeMult = 0.9,
}
Config.Wheel = {
	SpinTime = 3,
	MCLevel = 25,
	-- 12 §12.5: jump → success / consolation / destroyed (percent), MC cost, Robux cost
	Jumps = {
		{ Success = 70, Consolation = 20, Destroyed = 10, MC = 5000, Robux = 49 },
		{ Success = 25, Consolation = 40, Destroyed = 35, MC = 15000, Robux = 99 },
		{ Success = 6, Consolation = 44, Destroyed = 50, MC = 40000, Robux = 199 },
	},
	PityAfter = 10,
	TradeUp = { Level = 10, Count = 3, MC = { Common = 3000, Rare = 8000, Epic = 20000 } },
}

-- ---------------------------------------------------------------- Survivors and progression (13)
Config.Survivor = {
	Faces = 12,
	Hair = 16,
	Skins = 8,
	Builds = 3,
	DraftOptions = 3,
	MemorialMax = 50,
	Reroll = { FullMC = 20000, FullRobux = 25, LockRobux = 75, RebalanceMC = 8000 },
}
Config.XP = {
	-- 13 §13.4 level curve: XP from n to n+1 = Base + Step * (n - 1)
	Base = 400,
	Step = 120,
	MaxLevel = 100,
	Level100Total = 621720,
	-- 03 §3.8 results
	Extract = 100,
	PerHaul = 100, -- 1 XP per 100 MC
	HaulMax = 300,
	Revive = 50,
	ZombieKill = 25,
	ZombieKillMax = 250,
	Cured = 150,
	LockdownSurvived = 200,
	Death = 50,
	CollectionEntry = 20,
	CollectionSection = 500,
	FriendBonus = 0.1,
}
Config.Levels = { -- 13 §13.4 unlock levels
	MC2 = 2000,
	DailyContracts = 3,
	Flea = 5,
	Rebalance = 8,
	Titles = 10,
	TradeUp = 10,
	BountyHunter = 15,
	ExecutiveMC = 20,
	WheelMC = 25,
	OutfitEvery = 5,
	OutfitFrom = 30,
	Veteran = { 50, 75, 100 },
}
Config.Rep = {
	MerchantPerHaul = 10000,
	VendorLoyaltyMin = 1000,
	VendorLoyaltyEscort = 5,
	VendorDiscountPer = 20,
	VendorDiscountStep = 0.01,
	VendorDiscountMax = 0.10,
	HelperTitles = { 10, 50, 200 },
	MutantTrack = { 100, 250, 500, 1000, 2000, 5000 },
}
Config.Contracts = {
	Starter = { MC = 500, XP = 100 },
	Daily = { Count = 3, MC = 1500, XP = 150, AllBonus = 1000, Rerolls = 1 },
	Weekly = { MC = 8000, XP = 800, PassXP = 3000 },
	ResetHourUTC = 0,
	WeeklyResetDay = 1, -- Monday
}

-- ---------------------------------------------------------------- Tower and residency (14)
Config.Residency = {
	ReserveSeconds = 120,
	WaitlistHold = 48 * 3600,
	MoveCooldown = 24 * 3600,
	InactiveDays = 30,
	NewResidentsPerDay = 40,
	LiveRefresh = 15,
	LiveStale = 45,
	PresenceRefresh = 30,
	PresenceTTL = 90,
	ReadOnlyOnError = true,
}
Config.Rent = { Bunk = 1500, FreeWeeks = 2, PrepayWeeks = 4 }
Config.Flat = {
	Executive = { MC = 250000, Robux = 399, Level = 20 },
	Penthouse = { Robux = 1499 },
	MinLightWithVisitors = 0.4,
	-- 15 §15.2
	Tiers = {
		Bunk = { Mounts = 1, Pedestals = 0, Case = 0, FurnitureCap = 25, Queue = 1 },
		Executive = { Mounts = 3, Pedestals = 1, Case = 0, FurnitureCap = 60, Queue = 2 },
		Penthouse = { Mounts = 6, Pedestals = 3, Case = 6, FurnitureCap = 120, Queue = 3 },
	},
	DoorHold = 0.6,
	OverflowDays = 7,
	OverflowGrid = { 10, 10 },
	Build = { Snap = 0.5, RotateStep = 15, FixtureFront = 3, Colours = 12, SaveEvery = 60 },
	Perks = {
		WellRestedTime = 120,
		WellRestedRegen = 0.15,
		ArmoryMounts = 5,
		DeskTax = 0.02,
		DeskTaxFloor = 0.03,
		DeskInsuranceCut = 0.15,
	},
	Bays = 64,
}
Config.TowerPA = { EveryMin = 240, EveryMax = 360, FlickerMin = 600, FlickerMax = 1200, FlickerTime = 3 }
Config.Party = { Max = 3, StickTogether = true }

-- ---------------------------------------------------------------- Economy (02 §2.12, 16)
Config.Econ = {
	StartCash = 5000,
	TargetHaul = 6000,
	DeathPayout = 300,
	WelcomeBackMC = 2000,
	WelcomeBackDays = 14,
	WelcomeBackEvery = 60,
}
Config.Vendor = { PriceMult = 1.6, HeavyAmmoStacksPerDay = 2, ConfirmSellFrom = "Rare" }
Config.Flea = {
	Tax = { Base = 0.10, Floor = 0.05 },
	TaxStepPer = 20,
	TaxStep = 0.01,
	PassTaxMult = 0.5,
	WarnHigh = 1.5,
	WarnLow = 0.7,
	Level = 5,
	AccountAgeDays = 7,
	Slots = 3,
	SlotPer = 25,
	SlotsMax = 8,
	PassSlots = 2,
	VIPSlots = 1,
	Fee = 0.01,
	FeeMin = 50,
	BarterFee = 100,
	PriceMin = 0.5,
	PriceMax = 8,
	BlueprintPriceMax = 6,
	Duration = 48 * 3600,
	RelistLock = 24 * 3600,
	PurchasesPerItemPerDay = 10,
	HistoryKeep = 200,
	ThinMarketSales = 5,
	ThinMarketMult = 1.5,
	CacheSeconds = 60,
	HoldToConfirm = 1,
}
Config.Insurance = { MCRate = 0.15, RobuxCap = 50000, ReturnMinutes = 60 }
Config.Repo = { HoldHours = 24, MCRate = 0.6 }
Config.Mail = { KeepDays = 30 }

-- ---------------------------------------------------------------- Bounties and roles (17)
Config.Bounty = {
	HeatPerKill = 1500,
	HeatCapPerRaid = 4500,
	ContributeMin = 500,
	ContributeMax = 20000,
	ContributeWindow = 600,
	WallFrom = 5000,
	AccountAgeDays = 7,
	PartyWindow = 24 * 3600,
	RotateEvery = 8,
	NetworkTop = 10,
	TowerTop = 5,
	RefreshEvery = 60,
	CollectedShow = 60,
	DogtagHold = 2,
	DogtagHours = 72,
	Ticket = { Rate = 0.1, Min = 500, Max = 3, Bonus = 0.25, Raids = 5 },
	Proximity = 40,
	RadioFrom = 10000,
	RadioAt = { 300, 720 },
	ExpireDays = 7,
	RefundRate = 0.5,
	ClaimXP = 100,
	Titles = {
		BountyHunter = { MC = 15000, Level = 15, Robux = 49 },
		Bodyguard = { MC = 10000, Level = 10, Robux = 39 },
		Mercenary = { MC = 10000, Level = 10, Robux = 39 },
		Vigilante = { MC = 12000, Level = 10, Robux = 39 },
	},
	Escort = { FeeMin = 1000, FeeMax = 25000, Minutes = 30, FailKeep = 0.1, XP = 300, RatingLast = 20 },
	Hire = { FeeMin = 500, FeeMax = 10000 },
	Justice = { MC = 2000, Max = 2, SenseRadius = 60 },
}

-- ---------------------------------------------------------------- Relics (18)
Config.Relic = {
	PoolCooldown = 30 * 60,
	PoolReadOldest = 50,
	ClaimLease = 30 * 60,
	HistoryKeep = 20,
	NamedMaxPerAccount = 20,
	Epithets = 40,
	NameTagMC = 5000,
	NoticesPerDay = 3,
	Vinyl = { Sleeves = 12, Colours = 8, Tracks = 40, Serial = "VinylSerial", TrackMax = 180, PreviewSeconds = 15 },
	Jukebox = { Queue = 10, Radius = 40 },
	Boombox = { PlaceTime = 0.8, Audible = 100, RedAlertVolumeCut = 0.6, BreakDamage = 20 },
}

-- ---------------------------------------------------------------- Shop and compliance (19)
Config.Shop = {
	ReceiptsKeep = 500,
	PolicyRetries = 3,
	PolicyRetryDelay = 2,
	PriceCacheSeconds = 600,
	Pass = {
		Weeks = 8,
		Tiers = 50,
		XPPerTier = 1000,
		CatchUpWeeks = 2,
		CrateTiers = { 10, 20, 30, 40 },
		HaulBonus = 0.1,
		Premium = 499,
		PremiumPlus10 = 999,
	},
	Crate = { Common = 40, Rare = 35, Epic = 20, Exotic = 5 },
	MCDailyCap = 400000,
	Expansion = { Rows = 3, Robux = { 149, 249, 399 }, MC = { 50000, 120000, 250000 } },
	VIP = { Stipend = 1500, FleaSlots = 1, CraftTimeMult = 0.9 },
	Catalysts = {
		BloodMoon = {
			ZombieMult = 1.5,
			WalkerSpeed = 0.15,
			EpicMult = 1.5,
			ExoticMult = 2,
			BlueprintMult = 1.5,
			Robux = 99,
		},
		Blackout = { JanitorAt = 360, RarePlusMult = 1.25, BlueprintMult = 1.5, Robux = 99 },
		SupplyDrop = {
			At = 420,
			Noise = 120,
			Slots = 8,
			Weights = { 0, 0, 40, 45, 15 },
			BlueprintChance = 0.5,
			Robux = 99,
		},
	},
	Referral = { ReferrerMC = 5000, NewMC = 2000, AtRaid = 3, PerMonth = 10, Charm = "COS-CHM-011" },
}

-- ---------------------------------------------------------------- Social and matchmaking (20)
Config.Social = {
	VoiceTower = 40,
	VoiceRaid = 50,
	QuickLineRange = 40,
	QuickLineBubble = 3,
	QuickLineCooldown = 1.5,
	PingTime = 10,
	PingRange = 80,
	PingsMax = 3,
	SquadTagRange = 30,
	ChatNearby = 50,
	ArmbandColours = { { 255, 220, 0 }, { 0, 220, 255 }, { 255, 0, 220 } }, -- yellow, cyan, magenta
}
Config.Matchmaker = {
	TicketTTL = 90,
	TicketRefresh = 10,
	LockLease = 10,
	LockRenew = 3,
	LoopEvery = 2,
	RegionPrefer = 20,
	RaidPlanTTL = 600,
	LaunchDelay = 3,
	TeleportRetries = 3,
	TeleportBackoff = 2,
	Regions = { "NA", "EU", "AS", "OC", "SA", "Global" },
}

-- ---------------------------------------------------------------- Settings defaults (02 §2.13)
Config.Settings = {
	Shake = 1,
	ReduceMotion = false,
	Shoulder = "Right",
	AutoSprint = true,
	AimAssist = true,
	ToggleAim = { PC = false, Mobile = true, Gamepad = false },
	Volume = { Master = 100, Music = 70, SFX = 100, Voice = 100 },
	TierShapes = false,
	Subtitles = true,
	SubtitleSize = "M",
	AllowCatalystRaids = true,
	MonoAudio = false,
	HighContrastStruggle = false,
	HoldToToggle = false,
	Quality = "Auto",
	FPSCap = 60,
}

-- ---------------------------------------------------------------- Admin (22 §22.1)
Config.Admin = {
	UserIds = {}, -- PLACEHOLDER: Mareux's user id and named testers (Handoff.md). Studio makes everyone an admin.
	GroupId = 0, -- PLACEHOLDER: the group that owns the game
	GroupRank = 250,
	LiveGrants = false,
	LogKeep = 50,
}

-- ---------------------------------------------------------------- Networking, data, security (25)
Config.Net = {
	RateDefault = { PerSecond = 20, Burst = 40 },
	RateInventory = { PerSecond = 30, Burst = 60 },
	RateFire = { PerSecond = 15, Burst = 30 },
	RatePose = { PerSecond = 25, Burst = 50 },
	StrikesPerMinute = 3,
	DistanceTolerance = 2,
	GeoUrl = "", -- PLACEHOLDER: IP geolocation endpoint, Mareux picks the service in P1 (25 §25.4)
}
Config.Data = {
	Store = "PlayerData_v1",
	KeyPrefix = "Player_",
	Version = 1,
	AutoSave = 60,
	LockedKickAfter = 15,
	Retries = 5,
	Backoff = { 1, 2, 4, 8 },
	AuditFlushEvery = 30,
	AuditKeepDays = 90,
}
Config.Security = {
	MoveSampleHz = 10,
	SpeedTolerance = 0.2,
	FlagsToRubberBand = 3,
	FlagWindow = 10,
	KickOnSession = 3,
}
Config.AntiAlt = { LinkWindowDays = 7, AccountAgeDays = 7 }
Config.Perf = {
	ClientFPS = 60,
	MobileFPS = 30,
	MobileMemoryGB = 1.6,
	ServerHz = 60,
	AIFrameMs = 4,
	NetDownKBs = 50,
	NetPeakKBs = 80,
	MapParts = 60000,
	MapMemoryMB = 25,
	RagdollsPerClient = 8,
	DecalsMax = 300,
	StreamingRadius = 256,
}

-- ---------------------------------------------------------------- Audio (24)
Config.Audio = {
	DistanceFactor = 3.33,
	RolloffScale = 1,
	DuckDb = -8,
	DuckTime = 1.5,
	MaxVoices = 48,
	RollOffMin = 6,
	OcclusionRange = 60,
	OcclusionEvery = 0.25,
	OcclusionHighDb = -18,
	OcclusionVolumeDb = -4,
	OtherFloorDb = -8,
	OtherFloorNearby = 30,
	ZoneCheckEvery = 0.5,
	ZoneCrossfade = 1.5,
	DistantShotFrom = 80,
	DistantShotBlend = { 60, 80 },
	Music = {
		DroneDb = -24,
		SleeperDb = -18,
		MuzakDb = -20,
		Tension1Fear = 30,
		Tension2Fear = 60,
		Tension2Chasers = 3,
		JanitorRange = 40,
	},
	-- Footstep surface map: Enum.Material name → footstep set
	Surface = {
		Default = "Tile",
		Concrete = "Concrete",
		Metal = "Metal",
		DiamondPlate = "Metal",
		Fabric = "Carpet",
		Glass = "Shards",
		Grass = "Grate",
	},
}

-- ---------------------------------------------------------------- Weekly Mall Conditions (28 §28.3)
Config.Weekly = {
	Conditions = {
		"FogWeek",
		"RatKing",
		"PowerSurge",
		"LootersParadise",
		"QuietHalls",
		"NightShift",
		"MedShortage",
		"DoubleStruggle",
	},
	FogWeek = { AtmosphereMult = 2, SightMult = 0.8 },
	RatKing = { CrawlerMult = 2, WalkerMult = 0.8 },
	LootersParadise = { TillSlots = 1 },
	QuietHalls = { ReinforceEvery = 180 },
	NightShift = { JanitorAt = 360 },
	MedShortage = { MedCabinetSlots = -1, Antidotes = 2 },
	DoubleStruggle = { ZoneBonus = 0.05, ZombieMult = 1.2 },
}

-- ---------------------------------------------------------------- Orientation Run (03 §3.9)
Config.Orientation = { Minutes = 4, RedAlertCountdown = 30, OpenWindow = 20, CollectionSeed = 5 }

return table.freeze(Config)
