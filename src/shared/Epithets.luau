--!strict
-- Epithets for named gear (18 §18.4): a preset list of 40. The blueprint gives five examples; the other 35 are
-- PLACEHOLDERS (question Q-004 in docs/questions.md) and show as "[Epithet n]" until Mareux supplies the list.
-- Never let a player type free text here (18 rules).

local list = {
	"Old Faithful",
	"Lucky",
	"The Widowmaker",
	"Night Shift",
	"Sunday Best",
}
for n = #list + 1, 40 do
	table.insert(list, `[Epithet {n}]`)
end

return table.freeze({ List = table.freeze(list), Count = #list, RealCount = 5 })
