# 01 · Overview

Owner of: how to use this blueprint, pitch, identity pillars, tone rules, audience, the raid at a glance, Stages vs Features, every name in the game, glossary, research grounding.

---

## 1.1 How to use this blueprint

- This blueprint is the full spec of **HellRaiders**. If something isn't written here, it isn't in the game. Never invent behaviour, numbers or text. If something is missing or contradictory, write it in `docs/questions.md` and ask Mareux before building it.
- Start with `00-index.md`, then this file, then `02-shared-values.md`. After that, follow `26-build-roadmap.md` one stage at a time. Each stage lists the files to read.
- Every number lives in `src/shared/Config.luau`, copied from this blueprint. Every on-screen string lives in `src/shared/Strings.luau`, copied from `21-hud-ui-controls-strings.md` §21.10.
- **Placeholders.** Each model, animation, sound, music track, texture, UI image and VFX has an id in `27-assets.md`, such as `ANIM-MOV-004` or `SFX-ZOM-012`. Code only uses assets through `AssetRegistry` with those ids. Until the real asset exists, the registry returns a grey-box placeholder and logs `PLACEHOLDER <id>` once per server. At the start of each stage, the roadmap's **Asset requests** block lists the ids that stage needs for real. Claude must ask Mareux for them in one message at the start of that stage and keep building with placeholders until they arrive (see `26` §26.1 rule 6).
- **Existing code.** The current Studio place already has strong movement, camera, stats, inventory, guns, throwables, ragdoll and traversal code. The roadmap ports those modules in S1 and reconciles them with this blueprint. It doesn't rewrite them. Where the existing code and this blueprint disagree, this blueprint wins and the module is changed to match.

## 1.2 Pitch

**"Anyone could be infected."**
HellRaiders is a third-person extraction looter set in a zombie-overrun shopping mall. You raid Sunshine Valley Mall solo or in a squad of up to three, loot what you can carry, and get out at the single Red Alert Evac. Anyone bitten keeps playing as a hidden **Sleeper**: they look human, keep their gear, and secretly choose between finding a cure and betraying everyone. If a Sleeper steps into the evac zone, the doors lock and they become the **Supermutant**.

Between raids you live in **High-Rise Tower**, a run-down, Dredd-style residential block above the mall. Each server is one tower with a fixed number of residents. Your flat is your stash, your workbench and your trophy room. The ground floor is the player trading hub.

## 1.3 Identity pillars (never break these)

1. **Tension over power.** Horror comes from scarcity, noise, light and fear, not jump-scare spam. There's no crosshair (PC), no hitmarker and no health number. Health is shown through screen effects and the body.
2. **Trust is the weapon.** Hidden infection and hidden intent. Nothing on screen ever reveals a Sleeper or a betrayer. Players read symptoms, behaviour and evidence.
3. **Every choice has a cost.** Weight slows you and makes noise. Light lets you see but gets you seen. Crafting is loud. Fear helps you run but hurts your aim. Searching takes time.
4. **Bodies that feel physical.** Movement, traversal, tackles and knockdowns are blended or procedural, never cut. The camera is cinematic and never fights the player.
5. **Nothing is ever truly lost.** Named items and vinyls lost in the mall go back into the world and can be found by someone else.
6. **Status lives in the tower.** Flats, trophies, displays and titles are where players show off.

## 1.4 Tone rules

- Grounded, gritty, late-2000s urban decay. The mall has dead neon, wet floors, tiled atriums, broken escalators and rattling shutters. The tower has graffiti, flickering strip lights, pipes, laundry lines, CCTV and armed guards.
- The one pulpy layer is the mutants (Stalker Mutant, Supermutant, The Janitor). They're grotesque and physical, never cartoonish.
- No comedy gimmicks, no bright cartoon VFX, no brainrot memes. Humour lives only in NPC chatter, graffiti and item descriptions, and stays dry.
- Gore level: blood splats, wounds and bite marks. No dismemberment and no exposed organs, to keep within Roblox's "Moderate" maturity.
- No Hellraiser imagery (no puzzle boxes, no pinned faces). No real brands: weapons are generic models with invented names.

## 1.5 Audience

- **Target:** 13+ (Moderate maturity label: realistic weapons, blood, horror). Expected spread: about 60% 13–17, about 40% 18+. Some under-13s will play where their account allows Moderate content, so every system still works without chat and without reading.
- **Devices:** design for mobile first (about 80% of Roblox players), then PC and gamepad, with full control parity (see `21` §21.2).
- **Motives served:** achievers (gear, blueprints, levels), explorers (secrets, keycard rooms, lost items), socialisers (squads, tower life, visiting flats), competitors (PvP, bounties, the Supermutant) and creators (flat decoration, named weapons, vinyls).

## 1.6 The raid at a glance

1. **Tower.** You wake in your flat. You stash, craft, decorate and trade, form a party, then walk to the freight elevators.
2. **Deploy.** Squads of 1 to 3 (solo, duo and trio pools) are matched into a 12-player raid. The freight lift drops you to one of four basement entry gates of Sunshine Valley Mall.
3. **Raid (20:00).** You search containers. Items reveal one by one, with rarity hints. You manage weight, noise and light. Walkers and Crawlers react to what they hear and see. Other squads may help you, ignore you or rob you.
4. **Tackles and infection.** A zombie lunge starts a timing-bar struggle. Fail it and you're bitten. You become a hidden Sleeper with about 3 minutes before you mutate, unless you find an Antidote or a Suppressant.
5. **The Janitor.** From minute 8, an unkillable stalker roams the mall and homes in on the loudest noise.
6. **Red Alert Evac.** From minute 10, anyone can trigger the evac at a Security terminal. If no one does, it starts on its own at minute 17. Sirens sound, every zombie surges, and a random exit is revealed: the Rooftop Helipad or the Basement Garage. A 120 s countdown runs, then the zone is open for 45 s.
7. **Betrayal.** If a Sleeper is inside the zone when the lift departs, the doors lock for 90 s and the Sleeper becomes the Supermutant. Survive or kill it, and the doors reopen for a final 30 s window.
8. **Return.** Extracted loot goes to your stash with a haul tally. If you died, you lose what you carried, except the Safe Pocket and Blueprint Slot. That survivor is gone for good, and you pick a new one from three.

## 1.7 Stages and Features

- **Stages (S0 to S17)** build everything needed for a complete raid loop that two people can play together: the **two-player Alpha**. Gate: two real players can deploy together, loot, get bitten, evac, betray or extract, and keep their loot in a saved stash and basic flat.
- **Features (F1 to F13)** add the tower and residency system, flat tiers and customisation, migration, flea market, insurance and repossession, bounties and roles, world items and vinyls, the blueprint wheel, Supermutant variants and catalysts, the shop and passes, progression and retention, the art pass and polish.
- **P1** is pre-launch and publishing. **L1 to L4** are post-launch updates.

## 1.8 Names (use exactly these)

| Thing | Name | Notes |
|---|---|---|
| Game | HellRaiders | One word on the store page. In-world signage uses "Hell Raiders". |
| Raid map | Sunshine Valley Mall | Launch map. |
| Lobby | High-Rise Tower {NN} | Each server shard is a numbered tower, e.g. "High-Rise Tower 17". |
| Soft currency | Mall Cash | Shown with the "MC" icon. |
| Hidden infected player | Sleeper | Never shown on another player's screen. |
| Player mutation, timer ran out | Stalker Mutant | Playable. |
| Lockdown boss | Supermutant | Playable. Variants in `09` §9.12. |
| AI stalker | The Janitor | One per raid, cannot be killed. |
| Dead infected player's body | Sprinter | AI-driven, steered by the Ghost (dead player). |
| Basic zombie | Walker | |
| Floor zombie | Crawler | |
| Extraction event | Red Alert Evac | |
| Failed extraction | Lockdown | 90 s. |
| Personal home | Flat | Tiers: Bunk Studio, Executive Suite, Skyline Penthouse. |
| Ground floor trading hub | The Flea | The player market, officially the "Flea Market". |
| Rooftop vendors | Black Market | Wheel, catalysts, rerolls, Supermutant variants. |
| Bounty display | Most Wanted Wall | LED wall in the atrium. |
| Character | Survivor | Permadeath. Account progress stays. |
| Safe 1×1 slot | Safe Pocket | Any 1×1 item. Kept on death. |
| Blueprint 1×1 slot | Blueprint Slot | Blueprints only. Kept on death. |
| Unique world items | Relics | Named gear and vinyls. Highest tier. |
| Moving towers | Move-in | Paid relocation of your flat to another tower. |
| Tutorial | Orientation Run | First deploy only. |
| Season pass | Evac Pass | |
| Subscription | Mall VIP | |

## 1.9 Glossary

- **Raid:** one 20-minute match in the mall.
- **Squad:** party of 1 to 3 queued together. Squads are colour-tagged to each other only.
- **Stranger:** any player not in your squad.
- **Struggle:** the timing-bar QTE started by a zombie lunge.
- **Struggle counter:** how many struggles you've had this raid (makes later struggles harder).
- **Bite:** a failed struggle. Turns a healthy player into a Sleeper, or kills an existing Sleeper.
- **Incubation:** the hidden Sleeper timer, ending in mutation.
- **Haul:** what you extracted with.
- **Stash:** your persistent storage grid in your flat.
- **Tier:** item rarity: Common, Uncommon, Rare, Epic, Exotic, Relic.
- **Blueprint:** permanent crafting unlock. Tiers Common to Exotic.
- **Resident:** a player whose flat is in a given tower.
- **Visitor:** a player in a tower where they're not a resident.
- **Annex:** a second live server of the same tower, used when the first is full.
- **Catalyst:** a paid server-wide raid modifier.

## 1.10 Research grounding (why the design is shaped this way)

- **Hidden infection and social deduction:** teens take more risks and feel more reward when peers are watching, and trust and betrayal choices in front of others are the strongest social pull. Simple rules with many players create endless new stories.
- **Rarity reveal one slot at a time:** dopamine rises most when a reward is uncertain, so the search itself must carry anticipation. Hints must always match the real item, because faked hints are deceptive.
- **Loss with caps (Safe Pocket, Blueprint Slot, Ghost Guidance, death XP):** a loss feels about twice as big as the same gain. Total wipes cause rage-quits, while capped losses keep the tension.
- **Red Alert Evac and the Lockdown:** arousal works best as a spike followed by relief, and high-arousal moments (panic, betrayal, a last-second escape) are what get clipped and shared.
- **Short, complete raids (20 min) with natural ends:** Roblox weighs return visits and 28-day retention over marathon sessions, and a complete raid is a healthy stopping point.
- **Tower status (flats, trophies, titles):** visible status is especially motivating for teens, and visiting flats gives players a reason to come back together.
- **Mobile-first controls:** most players are on phones, and a PC-only advantage makes mobile players feel cheated.
- **Originality:** no social-deduction extraction game exists in the top Roblox charts. The format is familiar (extraction) plus one strong twist (the Sleeper).
