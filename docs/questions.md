# Questions for Mareux

Open points where the blueprint is missing data or contradicts itself (26 §26.1 rule 3). Each has the placeholder
used in code so nothing blocks. Answer here or in chat; the answer goes into the blueprint first, then the code.

| # | Status | Where | Question | Placeholder used in S0 |
|---|---|---|---|---|
| Q-001 | Open | 02 §2.10 vs 19 §19.8 | Stash expansion: 02 says `Stash.ExpansionRows = 5`, "+5 rows each, 2 passes max"; 19 §19.8 sells Stash Expansion I/II/III at +3 rows each. Which is right? | `Config.Stash.ExpansionRows = 5`, `ExpansionsMax = 2` (02 wins for shared values); `Config.Shop.Expansion.Rows = 3` with three Robux/MC prices kept from 19 for the Products table. |
| Q-002 | Open | 02 §2.8, 12 §12.2 | The Revenant has damage, RPM, mag, ammo and falloff but no recoil, horizontal kick, recovery, sway factor or reload time (07 §7.3–7.4 list the other guns). | `Config.Guns.Revenant`: Kick 4.0, Horiz 0.8, Recover 8, Sway 1.2, Reload 2.0, marked PLACEHOLDER. |
| Q-003 | Open | 23 §23.3.1 | The 48 shops are "named in `MallShops.luau` with invented brand names", but no names are listed anywhere. Please supply 48 names by shop type (or approve Claude drafting them for your review). | `MallShops.luau` names are `[Apparel 1]` … `[ArmyCheckpoint 1]`. |
| Q-004 | Open | 18 §18.4 | Epithets: "a preset list of 40", five examples given (Old Faithful, Lucky, The Widowmaker, Night Shift, Sunday Best). Please supply the other 35. | `Epithets.luau` entries 6–40 are `[Epithet n]`. |
| Q-005 | Open | 19 §19.5 | Cosmetics: counts, id ranges and price ranges are given, but not each item's name or exact price (e.g. which 8 finishes are MC and at what price between 5,000 and 25,000). | `Cosmetics.luau` names are `[Finish n]` etc.; prices are the low end of each range; allocation order is MC rows first, then Robux, then earned. |
| Q-006 | Open | 19 §19.5, 27 | Door banners: 19 lists 10 banners at 25–99 R$; 27 has 9 shop banner models (MDL-FLT-091…099) plus the free weekly Tower Standing banner (MDL-FLT-090). Is the tenth banner the weekly one? | `COS-BAN-010` is the weekly banner (source Weekly, no price). |
| Q-007 | Open | 15 §15.9 | Wallpapers and floorings: "1,000–6,000 MC; 4 wallpapers / 2 floors are 49 R$". Which ones, and the MC price of each? | `Furniture.Surfaces`: first 8 wallpapers and 6 floors at 1,000 MC, the rest 49 R$. |
| Q-008 | Open | 11 §11.2 | Molotov and UV Stun Flare have tier "crafted only". The reveal, Collection Book and Pawnbroker need a display tier. | Molotov `Uncommon`, UV Stun Flare `Rare` (matches their values next to neighbours). |
| Q-009 | Open | 07 §7.5, 12 §12.2 | Thermal Sight: which guns does it fit? (The other sights list their guns.) | `Config.Attachments.Thermal.Fits = Kestrel, Longhorn, Nightjar`. |
| Q-010 | Open | 25 §25.1 | ProfileStore has no official Wally package (loleris publishes on GitHub only; Wally has unofficial mirrors). OK to vendor the official module into `ServerPackages/ProfileStore.luau` in S3, or do you prefer a mirror? | Not installed in S0; `wally.toml` has a comment. Nothing in S0 requires it. |
| Q-011 | Open | 27 | `UI-COS-001…130` is 130 icons but the cosmetics catalogue has 136 rows (the 6 nameplate frames have their own `UI-NPF-*` art). Confirm nameplate frames use `UI-NPF-*` as both art and icon. | Nameplate frames use `UI-NPF-*` for both `asset` and `icon`; `UI-COS-*` covers the other 130 rows exactly. |
| Q-012 | Open | S0 step 2 | Universe setup needs your account: create the group-owned HellRaiders-Dev universe with Arrival (start), Tower and Mall places; HTTP requests on, API access on, third-party teleports off. Then paste the three PlaceIds. | `Config.Places.*.Dev = 0`; Studio boots as `Config.Places.StudioDefault` ("Mall") or the Workspace attribute `HellRaidersPlace`. |
| Q-013 | Open | 22 §22.1 | Admin user ids and the group id. | `Config.Admin.UserIds = {}`, `GroupId = 0`. Studio makes everyone an admin, so nothing blocks. |

## Resolved

(none yet)
