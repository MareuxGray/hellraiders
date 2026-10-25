# 12 · Crafting, blueprints and the Blueprint Wheel

Owner of: in-raid crafting (inventory and field workbenches), recipes, blueprints and learning, hideout workbench crafting and queues, armour repair, the Fixed Trade-up, and the Blueprint Wheel with its odds and compliance. Prices of paid spins are in `19`.

---

## 12.1 In-raid crafting

- **Inventory crafting** (anywhere): open the inventory, tab **Craft** (`UI-INV-020`). Shows recipes you can make from what you carry. Making one is a channelled action (`ANIM-ACT-040`, kneel and assemble) with noise 35 (`02` §2.5). Moving or being hit cancels it and keeps the materials.
- **Field workbenches:** 8 fixed benches in maintenance rooms and some shops (`MDL-ENV-080`, `23` §23.6). Hold Context to open the bench panel. Advanced recipes need a bench. Bench crafting is 20% faster.
- Crafting sounds: tape rip, metal clank, liquid pour (`SFX-CRF-001…005`), chosen by recipe.

| Recipe | Ingredients | Where | Time | Output |
|---|---|---|---|---|
| Molotov | 2 Alcohol + 1 Rag | inventory | 4 s | ITM-THR-004 |
| Noise Decoy | 1 Radio + 1 Wire | inventory | 5 s | ITM-THR-003 |
| Improvised Bandage | 2 Cloth + 1 Tape | inventory | 3 s | ITM-MED-001 (Bandage) |
| UV Stun Flare | 1 Flashlight + 1 Tape + 1 Battery | bench | 6 s | ITM-THR-005 |
| Improvised Suppressant | 1 Chemical Flask + 1 Syringe | bench | 6 s | Improvised Suppressant (ITM-MED-007 behaviour; id ITM-MED-010) |
| Door Wedge | 2 Scrap | bench | 4 s | ITM-GER-005 |
| Planks ×3 | 2 Scrap + 1 Tape | bench | 5 s | ITM-GER-006 |

## 12.2 Blueprints

- A **blueprint** is a 1×1 item that unlocks permanent crafting of one equipment model at the flat workbench. Categories: **Guns**, **Armour**, **Attachments**. Tiers: Common, Rare, Epic, Exotic.
- Found in raids (`11` §11.3), auto-placed into the Blueprint Slot if it's empty (kept on death). A second blueprint goes into normal inventory (lost on death like any item).
- **Learning:** at the flat workbench, use a blueprint item > Learn (2 s, `SFX-UI-030` + `STR.CRF.LEARNED`). The item is consumed and the recipe is permanent on the account. A blueprint you already know shows "Known" and can be sold, traded on the Flea (`16`) or sacrificed on the Wheel (§12.5).

| Category | Common | Rare | Epic | Exotic |
|---|---|---|---|---|
| Guns | P9 | Wasp, Brace | Kestrel, Longhorn | **Nightjar** (AR), **Revenant** (magnum revolver) |
| Armour | — | Light Vest, Helmet | Heavy Vest | **Bastion Plate** |
| Attachments | Red Dot Sight, Foregrip | Extended Mag, 4× Scope | Suppressor | **Thermal Sight** |

**Exotic models** (craft-only; also 2% in Weapon crates as the Exotic roll):

| Item | Slot | Stats | Size / kg | Value |
|---|---|---|---|---|
| ITM-GUN-006 Nightjar | Primary | Kestrel stats but 24 damage, vertical kick 0.8°, built-in suppression (noise 60, no damage loss) | 5×2 / 3.4 | 45,000 |
| ITM-GUN-007 Revenant | Secondary | 55 damage, 180 RPM, 6 rounds, Heavy ammo, falloff 50 / 70% | 2×1 / 1.6 | 40,000 |
| ITM-ARM-004 Bastion Plate | Armour | torso −60%, durability 500 | 3×3 / 7 | 38,000 |
| ITM-ATT-006 Thermal Sight | Sight | Aim FOV 40; while aiming, warm bodies (humans, zombies, mutants) show as bright silhouettes within 40 in darkness; doesn't distinguish Sleepers | 2×1 / 0.5 | 35,000 |

## 12.3 Flat workbench crafting

- The workbench (`MDL-FLT-010`) is in every flat. Panel `UI-FLT-010`: known recipes, ingredients, cost, time, and the queue.

| Output tier | Materials | Mall Cash | Time |
|---|---|---|---|
| Common | 4 Scrap + 1 Mechanical Parts | 1,000 | 5 min |
| Rare | 4 Scrap + 3 Mechanical Parts + 1 Electronic Parts | 4,000 | 20 min |
| Epic | 6 Mechanical Parts + 2 Electronic Parts + 2 Precision Parts | 10,000 | 60 min |
| Exotic | 4 Electronic Parts + 3 Precision Parts + 1 Exotic Alloy | 25,000 | 180 min |

- **Queue slots:** Bunk 1, Executive 2, Penthouse 3. Crafts run in real time, **including while offline** (capped: a finished item waits in the bench output tray, never lost). This is a positive tomorrow hook.
- **Consumables** (bandages, medkits, ammo, meds) can't be crafted at the flat; they come from raids or vendors (`16` §16.2).
- Finished items go to the bench tray (10 slots; then crafting pauses until emptied) and from there to the stash with one tap.

## 12.4 Armour repair

- At the flat workbench: restore durability at 1 Scrap + 200 MC per 50 durability. Instant.

## 12.5 The Blueprint Wheel (Black Market, rooftop)

- **Where:** the Black Market on the tower roof (`14` §14.3), operated by the NPC broker "Vex" (`MDL-NPC-010`). Physical wheel `MDL-TWR-040` with a 3 s spin (`ANIM-TWR-001`, `SFX-TWR-010` ratchet).
- **How:** pick a blueprint you own as an item (learned or not; learned-only recipes can't be sacrificed since they aren't items) and a target tier jump. The output is a random blueprint of the **same category** at the target tier. The sacrificed blueprint is consumed on the spin.
- **Access:** Mall Cash spins from **account level 25**. Robux spins at any level (the level bypass is built into the Robux spin).

| Jump | Success | Consolation (a different random blueprint of the sacrificed one's own tier, same category) | Destroyed | MC cost | Robux cost |
|---|---|---|---|---|---|
| +1 tier | 70% | 20% | 10% | 5,000 | 49 R$ |
| +2 tiers | 25% | 40% | 35% | 15,000 | 99 R$ |
| +3 tiers (Common → Exotic) | 6% | 44% | 50% | 40,000 | 199 R$ |

- **Output model:** uniform among the category's models at the target tier (table in §12.2). The panel lists them with equal chances shown.
- **Pity (Robux spins only):** after 10 failed Robux spins in a row (any jump), the next Robux spin of a +1 jump is a guaranteed success. The counter is shown on the wheel panel (`STR.WHEEL.PITY`).

**Compliance (paid random item, required, `19` §19.2):**
1. The full odds table above (success, consolation, destroy, each output model's chance) is shown on the spin panel **before** the purchase or MC spend, with a labelled **Odds** button. All outcomes total 100%.
2. Mall Cash can be bought with Robux, so MC spins are treated as indirect paid random items too and follow the same disclosure.
3. `PolicyService:GetPolicyInfoForPlayerAsync(player).ArePaidRandomItemsRestricted == true`: the wheel's spin buttons are hidden, and only the Fixed Trade-up (§12.6) is offered, with `STR.WHEEL.RESTRICTED`.
4. Blueprints produced by a Robux spin are flagged `PaidOrigin = true` (`16` §16.3 trading rules).
5. The game's Maturity & Compliance Questionnaire declares paid random items.

## 12.6 Fixed Trade-up (no randomness)

- At the same Black Market counter. Give **3 blueprints of one tier and category** + MC (Common → Rare 3,000; Rare → Epic 8,000; Epic → Exotic 20,000) and **choose** the exact output model of the next tier in that category.
- Available to everyone at level 10+. This is the non-random path for restricted players and an honest option for everyone else.
