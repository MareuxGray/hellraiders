# Hell Raiders: design review (discussion phase)

Reviewed 25 Oct 2026 against all 9 research branches and the games database. Covers the full design notes Mareux pasted, the game report, HANDOFF.md and HANDOVER_TO_YAGO.md. This is for discussion only, not the blueprint.

## 1. Big picture

- **Pitch:** "Anyone could be infected." An extraction looter where the person helping you carry loot out might be the one who gets everyone killed.
- **Identity and fantasy:** you're a mercenary scavenger living in High-Rise Tower 09. You raid the infected Sunshine Valley Mall below, then climb back up to your flat to stash, craft, trade and show off.
- **Tone:** grounded tension horror (no crosshair, no health number, noise and light as the danger), with one pulpy layer on top: mutants and the Supermutant. Every fix has to respect that: no cartoon gimmicks, and the danger stays diegetic.
- **Core loop:**
  - Moment to moment: sneak, search, manage noise and light.
  - Raid: deploy by elevator, loot the grid, survive zombie tackles. You may get bitten and become a hidden sleeper. Red Alert Evac follows, and a sleeper in the zone triggers the Supermutant lockdown. Then you extract or die.
  - Session: stash, craft from blueprints, trade.
  - Meta: flat tier, trophy walls, blueprint collection, bounties.
- **Where the fun should come from:** greed against fear, plus paranoia. The paranoia is the part no other Roblox game has.
- **Audience:** realistically 13+ (guns, blood, permadeath), mostly mobile, with a strong teen status motive (flats, trophies, bounties).
- **What's special and must never break:** the hidden infection, the extraction betrayal twist, and the "nothing is ever lost" world.

**Saturation:** clear. No social-deduction extraction game exists in the database. The only zombie extraction rival, HUSH, is PvE only. Murder Mystery 2 owns social deduction, but as a lobby party game, not a looter. This passes the "one strong twist on a known format" test: extraction is the known format, and the hidden sleeper is the twist.

## 2. What's already excellent (keep)

| System | Why it works |
|---|---|
| Sleeper Agents | Peer-visible risk and trust choices are what teen brains respond to most. Social deduction makes endless stories from simple rules. |
| Extraction betrayal + 90 s lockdown + reopen | A built-in spike-then-relief climax at the end of every raid. This is the clip and the thumbnail. |
| Ghost Guidance | Dead players keep playing instead of spectating. Low frustration is a big reason casual games go viral. |
| Red Alert Evac | Rising tension toward one point, with a random exit, so every raid ends in a chase. |
| Shop shutters / barricades / noise and light | Danger the player can see and hear. Fits the existing stats graph. |
| Timing-bar QTE (Option B) with teammate intercept | One button (works on mobile), skill-based, and it rewards helping. |
| Flats, trophy walls, squad spawns in the leader's flat | Visible status before every raid, and it makes squads feel like they share a home. |
| Anonymous Wanted Board | The mystery stays intact (no names), which protects kids. |
| "Nothing is ever lost" world items (vinyls, named guns) | The most original meta idea. It drives curiosity and discovery, and other players hold the value. |

## 3. Root problems (ranked by impact)

1. **Monetisation is built on pain relief and paid chance.** About half the Robux products sell power, randomness or relief after a loss. Several break Roblox rules as written, and they undercut the trust the game depends on. See section 4.
2. **Losses stack.** Lost gear, lost character, lost rolled stats, lost paid titles, a delayed insurance mail, and a 24 h repossession fee all land at once. A loss feels about twice as big as the same gain, and stacking them turns one death into a reason to quit. Selling the relief then makes it a spend-after-loss trap.
3. **Too many systems for the first hour.** There are around 20 systems: grid, limbs, bleeding, infection, cure, crafting in two places, blueprints, a gambling wheel, flea market, rent, insurance, repossession, roles, bounties, catalysts, permadeath and rerolls. Young players' working memory is small, and every extra rule costs attention. The first raid has to teach one idea: loot, get out, and watch your squad.
4. **No defined reward ladder inside the raid.** Blueprints have tiers (C/R/E/Exotic in one doc, F to S in another, which needs unifying), but nothing gives the search phase anticipation. There are no rarity signals, no named top-tier finds, and no reveal moment when you extract.
5. **The sleeper's own experience isn't designed yet.** Among Us works because being the impostor is fun. A sleeper needs concrete sabotage tools and a fair chance either way. A solo player who gets bitten has no one to betray, so solo infection needs its own goal.
6. **Mobile and kid controls.** There's no crosshair and no hip fire, aiming is on the right mouse button, the reaction inputs are random, and there are lots of keybinds. 80% of players are on mobile.

## 4. Monetisation verdicts

**Red (cut or redesign).** These break rules or sell power or relief:

| Item | Problem | Replace with |
|---|---|---|
| Blueprint gambling wheel + Robux bypass | A paid random item (Roblox's "enhancement" type). It needs odds before purchase, a PolicyService fallback, and is blocked for under-18s in Brazil. Destroy-on-fail is gambling. | Free only, no Robux path, odds and pity shown. Or a fixed combine: 3 of one tier makes 1 of the next tier in a category you choose. |
| Paid stat reroll / targeted lock | Paid randomness plus power in PvP. | Free: pick 1 of 3 rolled survivors. Stat spread stays small. |
| Robux → Mall Cash bundles | Mall Cash buys gear and blueprints from players, so Robux buys power. It also invites real-money trading. | Remove. Robux never turns into tradeable currency. |
| Robux insurance and repossession | Selling relief right after a loss (named in the Sydney study). | Mall Cash only. Insurance only on gear you brought in. |
| Supermutant 10 s revive prompt | A countdown to spend after losing. A textbook dark pattern. | Remove. |
| Supermutant on-demand transformation | Paid power against other players. | Remove. |
| Match catalysts that boost blueprint drops | A paid probability modifier (another paid random item type) that affects strangers. | Free rotating weekly modifiers. Paid catalysts only in private servers, with no drop boosts. |
| Battle pass "rare blueprint crates" and cash boosters | A loot box inside the pass. | Cosmetics plus fixed, named rewards only. |
| Robux bypass of level gates (flea market, wheel) | The level 5 gate exists to stop bot accounts, so selling the bypass breaks it. | No bypass. |

**Amber (keep with limits):** VIP stipend (small, cosmetic-weighted, one-tap cancel). Merchant tax pass (cap the discount). Weekly rent in Mall Cash: an expiry that switches off perks is a punishment for coming back, so make rent prepaid and paused while you're offline, or make every tier a one-off purchase. Paid Supermutant variants are fine only if they're cosmetic or a sidegrade.

**Green (core of the shop):** weapon finishes, stickers and charms; death and mutation effects; voice packs; extraction flare FX; flat decor and furniture looks; penthouse as space and display; stash expansions; private servers; a season pass with a cosmetic track; supporter pass; vinyls (section 6).

The pasted monetisation overview says everything stays reachable through gameplay. As written, that isn't true for several red items.

## 5. Loss design (recommendation)

- Keep the stakes but cap the stack: you lose what you carried, minus a safe pocket and the blueprint slot (already designed).
- Survivor permadeath stays as flavour. Rolled stats are small, and you choose your next survivor from 3 offered. Titles bought with Mall Cash are lost on death, which is fine. Robux is never spent on anything that dies.
- Every death gives something back. Ghost Guidance already keeps you playing. Add a small XP or reputation payout so that losing still moves you forward.

## 6. "Nothing is ever lost": vinyls and named weapons

- **Design:** each unique item has a world record. If it's lost on death and not extracted, it goes back into the mall's loot pool and can turn up for someone else. You see "Maru's M4: lost 3 days ago, Floor 2." It feeds curiosity and gives a story to the top-tier finds.
- **Vinyl constraints:**
  - Players can't upload or choose arbitrary songs. Copyright and Roblox audio rules apply, and every track needs rights and moderation.
  - Use a curated catalogue: Roblox's licensed music library or tracks the game owns.
  - Paying sends a copy into the world from that catalogue, with a filtered label.
- **Rules:**
  - Names on items use filtered display names or tags.
  - Paid-origin items follow `IsPaidItemTradingAllowed`.
  - Never sell a cosmetic version of a top-tier earned relic.

## 7. Open questions for discussion (in order)

1. Do you agree to replace the red monetisation items?
2. Loss cap: safe pocket, pick 1 of 3 survivors, no Robux on anything that dies?
3. MVP scope: the first build covers one mall, squads, loot grid, zombies, tackle QTE, sleeper and cure, Red Alert Evac with the betrayal lockdown, stash, and a basic flat. Flea market, bounties and roles, Supermutant playable variants, vinyl circulation and penthouses come after launch.
4. Sleeper toolkit and the solo-infected goal.
5. Raid reward ladder: one unified tier list and extraction reveal.
6. Mobile controls and aim assist.
7. Retention hooks, live ops and virality (clip moments, thumbnails, name).

## 8. Decisions log
- 2026-10-25: Mareux chose to keep every monetisation item that doesn't break Roblox rules. The blueprint must build paid random items (wheel, stat reroll, catalyst drop boosts) with full odds before purchase, live odds while a boost is active, a PolicyService fallback, an accurate maturity declaration, and flea market listing only where paid-item trading is allowed. Claude recommended (once) turning the 10 s Supermutant revive into a pre-match pass.
- 2026-10-25: Build structure: Stages (S0..Sn) end at a two-player Alpha: one mall, squads, loot grid, zombies, tackle QTE, sleeper and cure, Red Alert Evac with the lockdown, saved stash and a basic flat. Features (F1..) follow: flat ownership and customisation, flea market, bounties and roles, vinyls and "nothing is lost", Supermutant variants, monetisation, then polish and publish.
- Raid hiding uses shop shutters and barricades, not a safe room. Betrayal stays hidden. Bounties are anonymous.
- 2026-10-25: Mareux keeps the 10 s Supermutant revive prompt as designed. Mareux delegated topics 1 to 6 to Claude. Proposals below (section 9).

## 9. Claude's proposals for delegated topics (25 Oct)

**1. Sleeper toolkit**
- Zombies ignore sleepers unless the sleeper attacks first. That gives sleepers freedom, and it's also a clue observant players can spot.
- Fear already causes hand tremor and aim sway, so a shaky aim is never proof on its own. Symptoms stay ambiguous, which reuses the existing fear system.
- Sabotage actions use the same hold-to-interact as normal actions, so nobody can tell them apart by watching:
  - Quietly trigger a nearby noise trap or alarm.
  - Taint one med item (once per sleeper): whoever uses it is bitten.
  - Lead the horde with an infected scent trail.
  - The big one: walk into the evac zone.
- Rewards both ways. Cured and extracted: you keep your loot. Lockdown as a Supermutant: Mutant reputation plus a mutant cosmetic track. Both paths pay, so the choice is real.
- Bitten solo player: cure race, or go rogue (join a stranger squad's evac to trigger their lockdown).
- Timer: 3 min base, lengthened by Infection Resistance and suppressants.

**2. Loot reveal (ARC-style) and one reward ladder**
- Tiers: Common (grey), Uncommon (green), Rare (blue), Epic (purple), Exotic (gold), Relic (unique, named, world-persistent: vinyls, named guns). This replaces F to S.
- Hold to open a container. Its grid shows face-down slots that reveal one by one, with rare slots taking longer. The tier colour glows on the slot edge before the icon shows, with a distinct sound per tier. Hints always match the real item.
- You can grab items mid-reveal. Searching makes a small amount of noise.
- Container classes: bins and racks, tills and registers, med safes (where the cure can be), and locked stockrooms (keycards).
- Relic reveal: a unique stinger and gold rim, used for nothing else.
- Back at the flat: a haul tally. Items slide into the stash with a value count-up, a "Blueprint learned" moment, and a collection book entry.

**3. Raid shape and matchmaking (adapted from ARC Raiders)**
- ARC Raiders matches by squad size (solo, duo and trio pools), then skill, then hidden behaviour. Players who shoot other players drift into aggressive lobbies, and players who avoid fights drift into friendly ones. No score is shown.
- Ours:
  - Solo, duo and trio pools, with a Fill Squad toggle.
  - 12 players per server (mobile performance with many zombies).
  - A 20 min raid.
  - No mid-raid joins.
- No aggression or behaviour matchmaking (Mareux, 25 Oct). Pools are by party size only.
- Built with Roblox reserved servers, TeleportService and a MemoryStore queue.

**4. Mobile**
- PC stays as designed (no crosshair).
- Mobile:
  - Aim assist (magnetism while aiming down sights), with the fire button shown only while aiming.
  - One context button for search, traverse and shutters.
  - Auto-sprint toggle.
  - Tackle QTE is the timing bar (one tap).

**5. Retention**
- Tomorrow hooks:
  - Workbench crafts finish while you're offline (capped).
  - 3 daily tower contracts.
  - "Someone found your lost M4" notices from the nothing-is-lost world.
- Weekly: a rotating free mall modifier on a fixed update day.
- Seasonal: the Evac Pass, with forgiving streaks.

**6. Virality**
- Clip moments: the lockdown, the "you're infected" reveal, and mutant point-of-view hunts.
- Thumbnails show a sleeper reveal.
- Friend invite rewards and private servers.
- Name check: "Hell Raiders" is close to the Hellraiser horror films.

## 10. Remaining calls (Mareux delegated, 25 Oct)
- **Throwing and breaking:**
  - Glass (windows, displays, storefronts) breaks from throws, shots, melee or a Supermutant charge.
  - Broken glass leaves shards that crunch underfoot, so they become a noise trap afterward.
  - Breaking glass carries noise across floors.
  - Lights can be shot out.
  - 3 generators per mall restore power to a wing (lights, elevators, shutters), but light also exposes you to mutants.
  - Doors can be barricaded or wedged. A crowbar pries open locked doors (noisy).
- **Stats:** five survivor attributes: Endurance (stamina), Strength (carry), Composure (fear and infection resistance), Marksmanship (aim stability), Stealth (noise).
  - Point-buy pool 25, each 3 to 7.
  - New survivor: pick 1 of 3 rolled, for free. The paid reroll is kept, with odds shown and a PolicyService fallback.
  - Base speed, max health and base noise stay fixed for PvP fairness.
- **Melee:** pipe, crowbar and fire axe. Light attack, heavy attack, and a shove (breaks a tackle on a teammate). Stealth takedown on an unaware Walker from behind while crouched.
- **Enemies:**
  - Walker: slow, hearing-led, tackles.
  - Crawler: on the floor, gets under shutters, ankle-grab QTE.
  - Sprinter: from dead infected players, ghost-guided.
  - The Janitor: one per raid, an AI stalker from minute 8. It can be stunned with a UV flare but not killed, homes in on the loudest noise, and its dragged cart squeals as an audio tell.
  - Stalker Mutant: an infected player whose timer ran out.
  - Supermutant: a player boss, at the lockdown or paid.
- **Weapons:**
  - Guns: pistol, SMG, pump shotgun, assault rifle (generic, no real brand names), hunting rifle.
  - Ammo: light, medium, heavy, shells.
  - Attachments: sight, suppressor, extended mag, grip.
  - Recoil kick added.
  - Throwables: bottle, brick, noise decoy, molotov, UV flare.
- **Communication:** Roblox proximity voice where the player is eligible (age-checked 13+). For everyone: a quick-line wheel (Friendly!, Don't shoot, Follow me, Help, Danger) and hands-up and wave emotes.
- **Sunshine Valley Mall:**
  - 3 floors plus basement garage and roof.
  - Wings: Food Court, Electronics, Department Store, Pharmacy (med safes), Cinema (pitch dark), Security Office (evac terminals), Maintenance tunnels (field workbenches).
  - 4 basement entry gates.
  - Evac at the Rooftop Helipad or the Basement Garage, chosen at random.
- **Music:** mostly silence and ambience. Threat layers follow fear and nearby enemies. Unique siren themes for evac and lockdown. Jukebox in the flat.
- **Onboarding:** the first deploy is a 4 min solo Orientation Run in one wing: 3 Walkers, one guaranteed tackle QTE, one cure, one extract. No shop until the second session.
- **Name:** keep "Hell Raiders". Avoid any Hellraiser imagery (puzzle boxes, pinned faces).
- **Build base:** a new Rojo + Git repo. The proven modules from the current place (Gait/Locomotion, CameraRig, Body, Actions, Stats v2, Inventory, Combat, Ragdoll, Throwables, AM traversal) are ported in at the stage that needs them, not rebuilt.
- **Files:** blueprint in /mnt/project-files/hell-raiders/blueprint/ and in a new private repo MareuxGray/hellraiders, created when the blueprint starts.
