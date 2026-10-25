--!strict
-- Tween helpers: pure easing and interpolation used by camera effects, HUD counters and the reveal (04 §4.11,
-- 11 §11.4, 21). Instance tweening goes through TweenService in the controller that owns the instance.

local Tween = {}

function Tween.lerp(a: number, b: number, t: number): number
	return a + (b - a) * t
end

function Tween.clamp01(t: number): number
	return math.clamp(t, 0, 1)
end

function Tween.smoothstep(t: number): number
	t = Tween.clamp01(t)
	return t * t * (3 - 2 * t)
end

function Tween.easeOutQuad(t: number): number
	t = Tween.clamp01(t)
	return 1 - (1 - t) * (1 - t)
end

function Tween.easeInQuad(t: number): number
	t = Tween.clamp01(t)
	return t * t
end

function Tween.easeInOutSine(t: number): number
	t = Tween.clamp01(t)
	return -(math.cos(math.pi * t) - 1) / 2
end

--- Exponential approach used for boom lag and follow rates (04 §4.11 `Cam.Lag`): frame-rate independent.
function Tween.approach(current: number, target: number, rate: number, dt: number): number
	local alpha = 1 - math.exp(-rate * dt)
	return current + (target - current) * alpha
end

--- Scales a camera effect amount by the Shake setting and Reduce Motion (04 §4.11).
function Tween.effectScale(amount: number, shakeSetting: number, reduceMotion: boolean, reduceScale: number): number
	local scaled = amount * shakeSetting
	if reduceMotion then
		scaled *= reduceScale
	end
	return scaled
end

return Tween
