# 28 · Live ops, retention, virality and the store page

Owner of: retention hooks (session, daily, weekly, seasonal), the weekly Mall Condition, seasons and the content calendar, post-launch updates L1–L4, clip-moment design, creator and social features, the store page (title, icon, thumbnails, description), launch plan and KPI targets.

**Research grounding (summary):** variable rewards with visible near-misses drive the search; loss should feel like a story rather than a punishment; tomorrow hooks beat streak punishments; fresh-start landmarks (Mondays, season starts) restart motivation; viral Roblox games have one clip-able moment that explains itself in 3 seconds; icons and thumbnails need one face, one threat and one clear action.

---

## 28.1 Retention hooks

| Horizon | Hook | Where |
|---|---|---|
| In raid | Container reveals with true-tier glow; Relic chance; the Sleeper doubt; Red Alert sprint | `11`, `09`, `10` |
| End of raid | Haul tally count-up; "New blueprint!"; Collection Book entry; death payout so every raid moves you forward | `03` §3.8 |
| Session | 3 daily contracts doable in one raid each; workbench queue; flat decorating | `13` §13.8, `12` §12.3, `15` |
| Tomorrow | Workbench crafts finish offline; daily contracts refresh at 00:00 UTC; "Someone found your lost Kestrel" mail; Flea sales completed overnight; VIP stipend | `12`, `13`, `18` §18.6, `16`, `19` §19.12 |
| Weekly | Weekly contract; weekly Mall Condition (§28.3); Tower Standing reset and banners; bounty board churn | `13`, §28.3, `14` §14.13, `17` |
| Season (8 weeks) | Evac Pass; new cosmetics; new vinyls; one new mechanic or wing per season | `19` §19.6, §28.4 |
| Long term | Executive Suite (≈40 good raids), Penthouse, Exotic blueprints, Collection Book completion, Memorial Wall stories, Mutant Track | `15`, `12`, `13` |

**Rules:** no streak that punishes absence (no lost progress for missing a day); no daily login reward ladder that resets; returning players get a "Welcome back" mail with 2,000 MC if away 14+ days (once per 60 days) and their flat is always safe (`14` §14.11).

## 28.2 Session pacing targets

- First session: Arrival → Draft → Orientation (4 min) → tower tour hint → first real raid within 8 minutes of joining.
- Average session target: 3 raids (≈70 minutes with tower time).
- No shop prompts in the first session (the shop button exists but there are no first-session offers); no Robux prompts before the player's first extract.

## 28.3 Weekly Mall Condition (free, everyone)

- Changes every Monday 00:00 UTC. Shown on the deploy panel and as a PA line at Deploy. Applies to every raid that week, including catalyst raids (stacks).
- Rotation (`Config.Weekly.Conditions`, in order, then repeat):

| Condition | Effect |
|---|---|
| Fog Week | Atmosphere density ×2 in the galleria; sight ranges −20% for AI and players feel it |
| Rat King | Crawlers ×2, Walkers ×0.8 |
| Power Surge | One random generator starts already running |
| Looters' Paradise | Till and register slots +1 |
| Quiet Halls | Reinforcements every 180 s instead of 120 s |
| Night Shift | The Janitor enters at 360 s |
| Med Shortage | Med cabinets −1 slot; Antidotes always 2 |
| Double Struggle | Struggle zones +5% width (easier); zombie count ×1.2 |

- Conditions never change loot tier odds (so they aren't paid-random-item modifiers).

## 28.4 Seasons and content calendar

- Season = 8 weeks, starts on a Monday. Each season ships: an Evac Pass (50 tiers), 6–8 cosmetics, 8 vinyl tracks, 1 new furniture set, and one gameplay addition from the backlog below. Season theme drives the pass art and the mall's decorations (e.g. Season 2 "Black Friday": sale banners, trolley barricades).
- **Update day:** Fridays 17:00 UTC for content updates (before the weekend peak); Mondays for weekly resets.
- **Backlog for seasons** (in priority order, each needs its own blueprint update file):
  1. New wing in Sunshine Valley Mall: the Ice Rink (open floor, slippery, Crawlers under the ice).
  2. New enemy: the Bloater (explodes into an infection gas cloud: a bite-free infection source, cured normally).
  3. New exit type: the Delivery Truck (ground-level, drives off; three exits rotate).
  4. Second map: Starlight Hospital (taller, more Med Safes, darker).
  5. Duos Night event: double XP for duos on Friday nights.
  6. Prestige: at level 100, reset to level 1 for a Veteran star on your armband and name plate (cosmetic only, nothing lost). Not built at launch; needs its own blueprint update when the first players reach level 100.

## 28.5 Post-launch updates

| Update | When | Content |
|---|---|---|
| **L1** | launch + 2 weeks | Balance pass from analytics (haul median, struggle success rates, Lockdown rate target 15–25% of raids, survival rates), bug fixes, first new vinyls, Flea price limit tuning |
| **L2** | launch + 8 weeks (Season 2) | Season 2 pass, the Ice Rink wing, new cosmetics, tower decorations |
| **L3** | launch + 16 weeks (Season 3) | The Bloater, Delivery Truck exit, furniture set 2, Hire Board improvements |
| **L4** | launch + 24 weeks (Season 4) | Starlight Hospital (second map, map vote at deploy: Mall or Hospital), new Supermutant variant |

## 28.6 Store page

- **Title:** `HellRaiders` (one word). Optional season suffix on update weeks only, e.g. `HellRaiders [SEASON 2]`. No emoji spam.
- **Description (first 2 lines show in search):** "Raid an infected mall with your friends. Grab loot, get out... but someone in your squad might be infected." Then: how to play in 4 bullets (loot, survive, extract, live in the tower), a line on the Lockdown betrayal, a line on flats and the Flea, update notes, and the group link. All text in `docs/store-page.md` (written in P1).
- **Icon** (512×512, `UI-STO-001`): one survivor face, half-lit by a flashlight, with green infected veins creeping up one side of the neck; the mall sign glowing behind. Readable at 64 px. No text.
- **Thumbnails** (1920×1080, `UI-STO-010…014`):
  1. The Lockdown: a squad pressed against the cage as a teammate's silhouette tears into a Supermutant.
  2. The Sleeper reveal: a squadmate offering a hand, veins visible under a flashlight.
  3. The struggle: a Walker lunging at the camera with the timing bar.
  4. The Red Alert sprint: red strobes down the galleria, helicopter lights above.
  5. The tower: the Most Wanted Wall and Flea at night, flats glowing above.
- **Trailer** (30 s, `MUS-SEA-001`): loot reveal → struggle → "One of you is infected" → Red Alert → Lockdown slam → title.
- Assets `UI-STO-001`, `UI-STO-010…014` are commissioned in P1 (`27` Step P1).
- **Testing:** use the Creator Hub thumbnail experiments to run thumbnails 1 and 2 against each other as the first image for 7 days, then the winner against 3. Judge by click-through rate first, then the play-through rate (players who reach a first raid). Icons are tested the same way once a second icon exists; never change the icon and thumbnails in the same week.

## 28.7 Clip moments (designed to be shared)

| Moment | Why it's clip-able | Built in |
|---|---|---|
| Lockdown slam and transformation | Betrayal + monster reveal in 3 seconds | `10` §10.6, `09` §9.12 |
| "You've been bitten" private message | The audience knows; the squad doesn't | `09` §9.4 |
| Supermutant Charge through a wall | Spectacle + destruction | `09` §9.12, `06` §6.6 |
| Janitor grab dodge | Skill + horror | `08` §8.7 |
| Relic reveal | Rare-find hype | `11` §11.4, `18` |
| Squad slide-tackle ragdoll | Friendly chaos | `04` §4.5 |
| Boombox lure | Funny/clever play | `18` §18.7 |

- **Spectator camera:** dead players get a free-cam (`03` §3.5) good for recording.
- **Creator support:** a "Creator Codes" system is **not** built at launch; private servers (`20` §20.10) are the creator tool (custom games with friends and viewers).
- **Share Links:** every invite and referral in `20` §20.9 uses Roblox Share Links, so the link opens straight into the inviter's tower. Opt the experience into Roblox's **Creator Rewards** in P1 (Roblox pays for players a creator brings in; no game code needed).

## 28.8 Launch plan and KPI targets

- Soft launch: closed test (20 friends) → public, unlisted promotion for 1 week → sponsored ads in the second week if D1 ≥ 25%.
- **Targets (first month):** D1 retention ≥ 30%, D7 ≥ 10%, average session ≥ 25 min, first-raid extraction rate 40–60%, Lockdown in 15–25% of raids, payer conversion ≥ 2%, ARPDAU tracked weekly. Likes ratio ≥ 85%.
- Dashboard: Roblox Creator Hub analytics (retention, engagement, monetisation, funnels from `25` §25.8).

## 28.9 Research gap check (all 9 branches)

The blueprint was checked against each research branch's audit checklist on 25 Oct 2026. Where a point is met, the owning file is named; where it was missing, it was added in that file.

| Branch | Checklist point | Where it's met |
|---|---|---|
| 1 Reward neuroscience, kids and teens | Uncertain rewards with an anticipation signal during the search | `11` §11.4 true-tier glow and rising pitch |
| 1 | Loss that doesn't wipe progress; something gained every raid | `02` death payout, `03` §3.8, `18` "nothing is ever lost" |
| 1 | Works for under-13s without reading or chat | `01` audience, icon-first HUD `21`, quick lines and pings `20` |
| 2 Gambling and monetisation | Odds before purchase, PolicyService fallbacks, no paid random item trading where restricted | `19` §19.2, `12` §12.5, `16` §16.3 |
| 2 | Honest price ladder, regional pricing, no pressure offers | `19` Pricing rules, `28` §28.2 |
| 2 | Pity on repeated paid random spins | `12` §12.5 pity |
| 3 Reward presentation | Tier colour, sound and escalation scale with rarity; the rarest item gets its own moment | `11` §11.4, `18` §18.6 Relic card |
| 3 | Repeated reveals stay short (no forced long animations) | in-raid reveal is grab-anytime (`11` §11.4); the wheel spin is 3 s |
| 4 Game feel and movement | Acceleration, momentum, camera response, hit feedback | `04`, `07` hit feedback |
| 4 | Input buffering and a grace window (coyote-time equivalent) | `04` §4.2, `02` §2.3 |
| 5 Attention, short-form, store page | Hook within the first minutes; first real raid inside 8 minutes | `28` §28.2, `03` Orientation Run |
| 5 | Icon with one face, one threat; 5 thumbnails; A/B testing | `28` §28.6 |
| 6 Social virality and creators | Clip-able 3-second moments, spectator cam, Share Links, Creator Rewards, referrals | `28` §28.7, `20` §20.9, `20` §20.10 |
| 6 | Betrayal and social deduction create stories players retell | `09` Sleeper, `10` Lockdown, `17` anonymous bounties |
| 7 Compulsion loops and progression | Clear moment, core, session and meta loops; long-term goals | `01` raid at a glance, `28` §28.1 |
| 7 | No punishing streaks; tomorrow hooks; fresh-start landmarks | `28` §28.1, §28.3 Mondays, §28.4 seasons |
| 7 | Prestige | backlog item 6 (§28.4); not needed before level 100 |
| 7 | A combine sink for duplicates | `12` §12.6 Fixed Trade-up, `12` §12.5 wheel |
| 8 Roblox platform | ToS-safe monetisation, maturity questionnaire, private-space rule (17+ trigger avoided) | `19`, `25` §25.11, `15` §15.10 |
| 8 | Screen-time limits and disconnects lose nothing | `25` §25.11, `03` §3.7 |
| 8 | Retention metrics and live ops cadence | `25` §25.8, `28` §28.4, §28.8 |
| 9 Virality, saturation, originality | Not a copy of a saturated Roblox game; one strong twist | extraction raid + hidden infected squadmate + Lockdown betrayal; `01` originality note (no social-deduction extraction game in the top Roblox charts) |
| 9 | Simple, pre-learned core | loot, survive, get out (`01`); tag-like chase in the Supermutant phase |
| 9 | Longevity over a short spike | towers, flats and the Flea give a home loop beyond the raid (`14`, `15`, `16`) |

**Only analysis-grade ([A]) points:** the clip-moment list and the prestige timing are practitioner or analysis judgement, not measured research. Check them against analytics at L1.
