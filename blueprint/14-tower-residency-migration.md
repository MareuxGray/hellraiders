# 14 · High-Rise Tower: the lobby, residency, instances, visiting and Move-in

Owner of: the tower fiction and layout, NPCs and atmosphere, tower shards and their data, live instances and Annexes, routing players through the Arrival place, residency and flat slots, new-player assignment, upgrades and the waitlist, rent, inactivity relocation, visiting, parties across towers, the paid Move-in, tickets, tower leaderboards, and tower safety rules. Flat interiors are in `15`. Prices are in `19`.

---

## 14.1 Fiction and vibe

- High-Rise Towers are run-down megablocks around the dead city, each housing a few hundred people (only players and NPCs we show). Think Dredd's Peach Trees: brutalist concrete, flickering strip lights, graffiti, pipes, laundry lines across stairwells, CCTV, chain-link, sandbags and armed guards at the ground floor. Crime and poverty hum in the background. Each server is one numbered tower: **High-Rise Tower {NN}** (number from the tower id).
- From every window and from the roof you can see Sunshine Valley Mall below, dark, with fires and the odd searchlight (`MDL-TWR-090` backdrop).
- The tower is a **safe zone**: weapons can't be drawn, no damage of any kind, player-to-player collision off (stops door blocking).

## 14.2 Places and routing

| Place | Role |
|---|---|
| **Arrival** (start place) | Tiny place: a 6–10 s freight-elevator loading scene (`MDL-TWR-001`, `SFX-TWR-001`). Loads the profile, assigns residency if new, decides which tower instance to send the player to, then teleports. Shows the friend visit choice (§14.9). |
| **Tower** | The lobby. Every live server is a reserved server for one tower id (an instance or an Annex). |
| **Mall** | Raids (`03`). |

- Players never land in a public Tower server. Public server joins of the Tower place (e.g. from a "join" button) are bounced to Arrival with their join data.
- Roblox invites and Share Links carry `launchData = {visit = towerId, inviter = userId}`. Arrival reads it (`Player:GetJoinData()`), and `ReferredByPlayerId` feeds the friend invite rewards (`20` §20.9).

## 14.3 Tower layout (one physical model, streaming enabled)

| Level | Name | What's there |
|---|---|---|
| Roof | **Black Market** | Helipad and lounge. Blueprint Wheel and Fixed Trade-up (NPC **Vex**), Catalyst dealer (NPC **Sully**), Supermutant variant shop "The Lab" (NPC **Dr. Halloran**), viewpoint over the mall, a burning barrel, graffiti. |
| Floors 30–33 | **Penthouse Level** | 4 corridors × 2 Penthouse doors (8). Carpet, working lights, private guard. |
| Floors 10–15 | **Mid Block** | 6 corridors × 4 Executive doors (24). Cleaner, half the lights work. |
| Floors 2–5 | **Low Block** | 4 corridors × 8 Bunk doors (32). Graffiti, buzzing lights, laundry, TVs behind doors. |
| Ground | **The Flea** (atrium) | Flea Market stalls and listing terminals (`16`), Appraisal Terminal, **Concierge Desk** (real estate, Move-in), **Most Wanted Wall** (LED, above the dry fountain) and **Contract Terminals** (`17`), **Contract Board** (daily contracts, `13` §13.8), **Quartermaster** (vendor: ammo, meds, basic gear, `16` §16.2), **Pawnbroker** (buys anything, `16` §16.2), **Mail Room** (insurance returns, `16` §16.6), **The Drain** (dive bar with the public jukebox and the back-room Pressing Booth, `18` §18.5), **Second-Hand Sal** (furniture stall, `15` §15.9), security checkpoint with turrets, and the **Transit Gates** with 4 freight elevators to the mall (deploy). |
| Basement (decor) | Freight shaft and tunnels | Seen through the gate glass. |

- **Internal lifts:** the main lift lobby on every level. Using a lift opens a floor picker (`UI-TWR-001`) and plays a 2 s ride (`SFX-TWR-002`) while the player is moved to that floor's landing. Floors are stacked physically; only the player's current floor and the ground floor are fully streamed in.
- **Stairs** exist as decor between adjacent floors only.
- Floor numbers between blocks (6–9, 16–29) are not accessible ("Condemned" signs on the lift picker).

## 14.4 Tower shards and data

- A tower is a persistent record in DataStore `Towers` keyed by tower id:

```
Tower {
  id: number, createdAt, status: "Filling" | "Full" | "Quiet",
  flats: { [slotId]: { tier: "Bunk"|"Executive"|"Penthouse", resident: userId|nil, since, pending: {userId, txId, expires}|nil } },
  waitlist: { Executive: {userId…}, Penthouse: {userId…} },
  weekly: { weekId, extractValue, extracts, topSurvivor }   -- tower leaderboard (§14.13)
}
```

- Slot ids are fixed per layout: `L2-01…L5-08` (Bunk), `M10-01…M15-04` (Executive), `P30-01…P33-02` (Penthouse).
- **All writes use `UpdateAsync`** on the tower record (atomic), and every residency change is a two-phase transaction (§14.6).
- `Towers/index` keeps lists of tower ids by status for assignment.

## 14.5 Live instances and Annexes

- MemoryStore SortedMap `TowerLive` keyed by tower id holds the live servers for that tower: `[{accessCode, jobId, players, updatedAt, isAnnex}]`, refreshed every 15 s by each Tower server (entries older than 45 s are dead).
- **Routing a player to tower T** (from Arrival, from a raid, or a visit):
  1. Read `TowerLive[T]`. Pick the instance with the most players that has room for the whole party (`players + partySize ≤ 46`, `Tower.AnnexAt`).
  2. If none has room, create an Annex: `TeleportService:ReserveServer(TowerPlaceId)`, store the access code in `TowerLive[T]` with a lock (MemoryStore `UpdateAsync`) so two servers don't create two Annexes at once, and teleport there.
  3. If no instance exists, reserve one (same lock) and teleport.
- All instances of a tower load the same tower record and show the same residents' doors. A resident's flat interior is live only in the instance where that resident is (profile session lock means they're in one place at a time). In other instances their door shows "Not home" and visitors can't enter.
- An Annex shows a small sign by the lifts: "Annex B". Players can switch instance at the Concierge (`STR.TWR.SWITCH_INSTANCE`) if there's room, e.g. to join a friend.
- Empty instances close normally when their last player leaves.

## 14.6 Residency transactions (no double-booking)

Every residency change (assignment, move, upgrade) runs:
1. **Reserve:** `UpdateAsync` on the target tower: check the slot is free and has no live `pending`, then write `pending = {userId, txId, expires = now + 120}`.
2. **Pay** (if paid): MC is deducted in the profile, or the Robux product prompt is shown (§14.10). Free moves skip this.
3. **Commit to profile:** profile `residency = {towerId, slotId, tier}`, `txLog += txId`.
4. **Finalise:** `UpdateAsync` on the target tower: `resident = userId, pending = nil`. Then `UpdateAsync` on the old tower: clear the old slot.
- A sweeper in every Tower server clears `pending` entries past `expires` (and checks the profile's txLog so a committed move is finalised rather than lost).
- All steps are idempotent by `txId`. A crash between steps 3 and 4 is repaired the next time either tower record is loaded.

## 14.7 Residency rules

- Every player has exactly one residency at a time.
- **Tier entitlement vs occupied flat:** buying Executive or Penthouse grants a permanent **entitlement** to that tier. You occupy a flat slot of any tier up to your entitlement. Stash size follows your entitlement (so you never lose stash space). Display slots and furniture perks follow the flat you occupy (`15` §15.2).
- **New players (Arrival):**
  1. If they arrived from a friend's invite or Share Link, or a Roblox friend is a resident of a tower with a free Bunk slot, they're assigned there for free (first assignment only).
  2. Else, assign to the `Filling` tower with the most residents that still has a free Bunk slot and has received fewer than 40 new residents in the last 24 h.
  3. Else, create a new tower.
  4. A tower becomes `Full` when all 64 slots are taken; it becomes `Filling` again when a slot frees.
- **Starter flat:** a Bunk Studio. Rent free for the first 2 weeks.

## 14.8 Upgrading, the waitlist and rent

- **Upgrade** at the Concierge Desk or the flat terminal: Executive Suite (250,000 MC from level 20, or 399 R$) or Skyline Penthouse (1,499 R$).
  - If your tower has a vacant slot of that tier: reserve, pay, move (your old slot frees). Furniture moves with you (`15` §15.7).
  - If not: choose **Join waitlist** (keeps your place; when a slot frees, the first in line gets a 48 h claim hold and a notice; if they don't claim, the next one does) or **Move up elsewhere** (free move to another tower with a vacancy of that tier; your friends can still visit you). You can buy the entitlement first and wait in your current flat; the purchase isn't lost.
- **Rent (Bunk Studio only):** 1,500 MC per week. First 2 weeks free. Auto-pay from your Mall Cash is on by default (toggle at the flat terminal); you can prepay up to 4 weeks. If rent is unpaid: your items and the flat stay safe, you're never evicted, and only functional furniture perks (`15` §15.4) pause until you pay. Reminder on the flat terminal only (no pop-ups).
- Executive and Penthouse have no rent.

## 14.9 Visiting

- Any player can visit any tower where a Roblox friend is a resident, or where they've been invited (invite link, party invite).
- **From Arrival:** if friends are online in the game, Arrival lists them (`UI-ARR-001`): "Go home" (default) or "Visit {friend}'s tower". Presence comes from MemoryStore `Presence[userId] = {towerId, instance, inRaid}` (updated every 30 s).
- **From the tower:** the Concierge Desk "Visit a friend" lists friends' towers.
- **Visitors** can use every public area (the Flea, vendors, bar, roof, deploy) and form parties. They can enter a resident's flat only when the resident is home and either invites them (party members are auto-invited) or has set the door to "Friends can enter". A visitor knocks (Context on the door) and the resident gets a prompt.
- Visitors raid from that tower and, after the raid, return to the tower their party leader is in if the party's **Stick Together** toggle is on (default), otherwise to their own tower.

## 14.10 Move-in (paid relocation)

- **What:** move your residency to another tower (normally a friend's). Product **"Move In"** (199 R$, `19` §19.4).
- **Where:** at the Concierge Desk of the target tower, as a visitor.
- **Flow:**
  1. Concierge shows the vacancies in this tower up to your entitlement (`UI-TWR-010`): e.g. "Low Block: 3 free · Mid Block: 0 · Penthouse: 0".
  2. You pick a slot. The server reserves it for 120 s (§14.6 step 1).
  3. The Robux prompt shows (`MarketplaceService:PromptProductPurchase`).
  4. `ProcessReceipt`: if the reservation is still yours, commit and finalise. Your flat (furniture, displays, stash) moves with you instantly; the new flat loads around you with a short "moving boxes" scene (`VFX-TWR-001`, 2 s).
  5. If the reservation expired before the receipt arrived (rare), grant a **Move Ticket** (stored on the profile) instead, with `STR.TWR.TICKET_GRANTED`. Move Tickets work like the product.
- **If the tower is full:** Move-in isn't offered. The Concierge offers **Join this tower's waitlist** (free, for Bunk too), and you're notified when a slot opens (48 h claim hold, then you still pay or use a ticket).
- **Moving at a lower tier:** a Penthouse-entitled player can move into a Bunk or Executive slot (keeping the entitlement and stash) and is automatically on that tower's Penthouse waitlist.
- Cooldown: 24 h between moves of any kind.
- **Free moves (tickets):** first assignment near a friend (§14.7), Move up elsewhere (§14.8), Homecoming (§14.11).

## 14.11 Inactivity relocation

- A resident who hasn't logged in for 30 days is relocated to a `Quiet` tower (a normal tower kept for returning players), at the same tier, with everything intact. This frees slots in active towers.
- On their next login, Arrival shows `STR.TWR.RELOCATED` ("While you were away, your flat moved to High-Rise Tower {N}. Everything is safe.") and grants a **Homecoming Ticket**: one free move back to the old tower if it has a vacancy at their tier (else they can join its waitlist with the ticket kept).
- Relocation never deletes items, cosmetics or entitlements.

## 14.12 Parties in the tower

- Form a party (max 3) with anyone in the same instance (Context on a player > Invite, or the party panel `UI-TWR-020`), or invite an online friend from another tower (they get a Roblox-style prompt and are routed to the leader's instance, as a visitor if needed).
- **Spawn in the leader's flat:** when a party forms, members are moved into the leader's flat (auto-invited). After raids with Stick Together on, everyone returns to the leader's flat.
- Leader starts the queue at the Transit Gates (`20` §20.8).

## 14.13 Tower leaderboard

- Each tower tracks the weekly total extracted value and extract count of its residents (`weekly` in the tower record, updated on raid results).
- The lobby shows **Tower Standing** on a board by the lifts (`MDL-TWR-030`): this tower's rank among all towers this week (computed hourly from an OrderedDataStore `TowerWeekly`).
- The top 10 towers each week give their residents a free cosmetic banner for their flat door for the next week (`MDL-FLT-090`). Fresh start every Monday 00:00 UTC.

## 14.14 NPCs and atmosphere

| NPC | Where | Role | Model / voice |
|---|---|---|---|
| Concierge "Marla" | Ground, desk | Real estate, Move-in, visits, instance switch | `MDL-NPC-001`, `VO-NPC-001…010` |
| Quartermaster "Okafor" | Ground | Vendor | `MDL-NPC-002`, `VO-NPC-011…020` |
| Pawnbroker "Lenny" | Ground | Buys items | `MDL-NPC-003`, `VO-NPC-021…030` |
| Bartender "June" | The Drain | Jukebox, Pressing Booth | `MDL-NPC-004`, `VO-NPC-031…036` |
| Second-Hand Sal | Ground, furniture stall | Furniture | `MDL-NPC-007`, `VO-NPC-073…078` |
| Contract Officer "Reyes" | Ground, terminals | Bounties, roles, contracts | `MDL-NPC-005`, `VO-NPC-037…046` |
| Mail Clerk "Pip" | Mail Room | Insurance returns | `MDL-NPC-006`, `VO-NPC-047…050` |
| Vex | Roof | Wheel, Fixed Trade-up | `MDL-NPC-010`, `VO-NPC-051…060` |
| Sully | Roof | Catalysts | `MDL-NPC-011`, `VO-NPC-061…066` |
| Dr. Halloran | Roof, The Lab | Supermutant variants | `MDL-NPC-012`, `VO-NPC-067…072` |
| Guards ×6 | Ground checkpoint, Penthouse level | Patrol loops | `MDL-NPC-020` |
| Residents ×12 ambient | Corridors, stairwells | Idle loops: smoking, arguing, a stairwell mugging scene on the Low Block (looping, no interaction), kids playing cards, a man fixing a TV | `MDL-NPC-030…041`, `ANIM-NPC-001…020` |

- NPC voice lines play with subtitles when the player interacts (`STR.NPC.*`).
- **Ambience:** PA announcements from "Tower Management" every 4–6 minutes (`VO-PA-030…045`: curfew reminders, rent notices, "Report suspicious bites"), distant dogs, sirens, muffled TVs and arguments behind doors (`SFX-TWR-020…035`), buzzing lights. A random **power flicker** every 10–20 minutes (lights dim for 3 s, `SFX-TWR-040`).

## 14.15 Edge cases

- **Resident with a pending raid reconnect** (`03` §3.7): Arrival sends them to the raid first.
- **Tower record corrupted or unreadable:** the player is routed to a temporary fresh instance of their tower in read-only mode (`STR.TWR.READONLY`); no residency changes allowed until it loads.
- **Two players buy the last slot at once:** only one reservation can succeed (§14.6). The other is told before any purchase prompt.
- **A Penthouse resident's flat in an Annex:** the flat lives where the resident is; visitors must be in that instance.
- **Banned or deleted accounts:** their slot frees after 30 days like inactivity, with their profile kept.
