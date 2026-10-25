--!strict
-- Time helpers: MM:SS for the wristwatch and evac timer (03 §3.4, 21 §21.3), UTC day and ISO-week ids for the
-- daily (00:00 UTC) and weekly (Monday 00:00 UTC) resets (13 §13.8, 28 §28.3). Pure Luau.

local Time = {}

--- "MM:SS" from seconds (clamped at 0, minutes may exceed 59).
function Time.mmss(seconds: number): string
	local s = math.max(0, math.floor(seconds + 0.5))
	return string.format("%02d:%02d", s // 60, s % 60)
end

--- UTC day id (days since the epoch) for a unix time.
function Time.dayId(unix: number): number
	return unix // 86400
end

--- Seconds until the next 00:00 UTC.
function Time.untilNextDay(unix: number): number
	return 86400 - (unix % 86400)
end

--- Week id where weeks start Monday 00:00 UTC. Unix day 0 (1970-01-01) was a Thursday, so shift by 3 days.
function Time.weekId(unix: number): number
	return (unix // 86400 + 3) // 7
end

--- Unix time of the Monday 00:00 UTC that starts the given week id.
function Time.weekStart(weekId: number): number
	return (weekId * 7 - 3) * 86400
end

--- Seconds until the next Monday 00:00 UTC.
function Time.untilNextWeek(unix: number): number
	return Time.weekStart(Time.weekId(unix) + 1) - unix
end

--- Weekly Mall Condition index (1-based) for a week id over a rotation of `count` conditions (28 §28.3).
function Time.rotationIndex(weekId: number, count: number): number
	return (weekId % count) + 1
end

--- Season index (1-based) and week within season (0-based) for an 8-week season starting at `seasonStartWeekId`.
function Time.season(weekId: number, seasonStartWeekId: number, weeksPerSeason: number): (number, number)
	local delta = weekId - seasonStartWeekId
	if delta < 0 then
		return 0, 0
	end
	return delta // weeksPerSeason + 1, delta % weeksPerSeason
end

return Time
