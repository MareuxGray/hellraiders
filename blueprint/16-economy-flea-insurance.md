# 16 · Economy, the Flea, vendors, insurance, repossession and mail

Owner of: Mall Cash sources and sinks, vendors (Quartermaster, Pawnbroker, Second-Hand Sal), the Flea Market (listings, tax, fees, limits, barter, appraisal, anti-exploit, technical design), insurance, repossession, and the mail system. Robux prices are in `19`.

---

## 16.1 Mall Cash

- One soft currency, Mall Cash (MC), shown with the MC icon (`UI-ICO-001`). Server-owned. Every change is logged with a reason (`25` §25.8 analytics: `EconomyEvent`).

| Sources | Sinks |
|---|---|
| Selling to the Pawnbroker | Vendor purchases |
| Flea sales | Flea tax and listing fees |
| Contracts, level rewards, achievements | Bunk rent |
| Death payout | Crafting costs, armour repair |
| Bounty payouts, Bodyguard escrow | Insurance, repossession |
| Mall VIP stipend (`19`) | Executive Suite, furniture, Rebalance, MC rerolls, MC wheel spins, Fixed Trade-up, role titles, claim tickets, Supermutant variants, Name Tags |
| Mall Cash bundles (Robux, `19`) | Bounty contributions |

- Starting MC 5,000. Target median extracted haul 6,000 (`02` §2.12). Executive Suite at 250,000 is about 40 good raids (a long-term goal).

## 16.2 Vendors

| Vendor | Where | Buys | Sells |
|---|---|---|---|
| **Quartermaster** (Okafor) | Ground | — | Light ammo, Medium ammo, Shells (unlimited); Heavy ammo (2 stacks per player per day); Bandage, Gauze, Painkillers, Splint; Flashlight, Battery, Planks, Door Wedge; Satchel; P9; Pipe, Crowbar. Price = item value × 1.6, minus Vendor Loyalty discount (1% per 20, max 10%). |
| **Pawnbroker** (Lenny) | Ground | everything tradeable, at item value × 1.0 (blueprints at their value; Relics never; cosmetics never) | — |
| **Second-Hand Sal** | Ground | — | furniture (`15` §15.9) |

- Vendor UI `UI-VEN-001` (buy/sell grid, quantity, total, confirm). Selling a Rare or better item asks for confirmation.

## 16.3 The Flea Market

**Access:** account level 5, **or** a Resident Pass (owning an Executive or Penthouse entitlement), **and** account age 7 days or more (anti-bot). There's no Robux bypass of the level gate apart from the Resident Pass (which is a flat purchase).

**Where:** listing terminals and stalls in the ground-floor atrium (`MDL-TWR-050`, 8 terminals), and the Flat Terminal (browse and buy only; listing needs a ground-floor terminal).

**Listings:**
- Any tradeable item from the stash can be listed for a Mall Cash price, or as a **barter** (offer items, ask for specific items).
- **Listing slots:** 3, +1 per 25 Merchant Score, up to 8. Merchant Tax Pass: +2 (so up to 10).
- **Listing fee:** 1% of the asking price (minimum 50 MC), non-refundable, paid when listing.
- **Tax** (paid by the seller from the sale): 10% at Merchant Score 0, −1% per 20 Merchant Score, floor 5%. Merchant Tax Pass halves the result. Security Terminal Desk −2% after that (floor 3%). Example: MS 60 → 7%, with pass 3.5%, with desk 3% (floor).
- **Price limits** (anti real-money trading and anti laundering): minimum 50% of the item's vendor value, maximum 8× vendor value. Blueprints: 50%–6×.
- **Duration:** 48 h. Unsold items return to your mail.
- **Item lock:** an item bought on the Flea can't be relisted for 24 h.
- **Purchase limit:** 10 purchases per item id per player per day.

**Not tradeable:** cosmetics and furniture bought with Robux, raid-only items, Safe code notes, Supermutant Trophies (they're your squad's kill), Relics (they circulate through the world only, `18`), role titles, tickets and tokens.

**Paid-origin items:** items flagged `PaidOrigin` (outputs of Robux wheel spins, Evac Pass crate blueprints, items from Robux bundles) can be listed and bought only by players whose `PolicyService` result has `IsPaidItemTradingAllowed == true`. For other players these listings are hidden and the list action is disabled with `STR.FLEA.PAID_RESTRICTED`. Mall Cash bundles are hidden for players with `IsPaidItemTradingAllowed == false` (Mall Cash is spent on the player market).

**Browsing UI** (`UI-FLEA-001`): search by name, filter by category and tier, sort by price or newest. Each item row shows the lowest price, the number of listings, and the 7-day average from the Appraisal data. Buying shows a confirm dialog with the total and your balance after (`STR.FLEA.CONFIRM`).

**Scam and mistake protection:** if a buy price is above 150% of the item's 7-day average, the confirm dialog adds a red line `STR.FLEA.WARN_HIGH` and the Buy button needs a 1 s hold. If a listing price is below 70% of the 7-day average, the list dialog adds `STR.FLEA.WARN_LOW` and a 1 s hold (`Flea.WarnHigh`, `Flea.WarnLow` in `02`). Items with fewer than 5 sales in 7 days use vendor value ×1.5 as the average. Barter offers show the summed 7-day average of each side (`STR.FLEA.BARTER_VALUE`). Your last 50 Flea buys and sales are listed on the Flat Terminal (`STR.FLEA.HISTORY`). There are no direct player-to-player trades outside the Flea, so the classic "swap at the last second" scam can't happen.

**Barter UI** (`UI-FLEA-002`): post an offer (up to 4 items given, up to 4 wanted by item id and minimum count). Others with the wanted items can accept, which swaps atomically. No tax on barters; the listing fee is 100 MC.

**Appraisal Terminal** (`MDL-TWR-051`, ground floor): scan any item in your stash to see vendor value, current lowest Flea price, 7-day average, last 20 sales and a trend arrow (`UI-FLEA-003`).

**Merchant Score** (`13` §13.5) grows with completed sales.

### Flea technical design (`Services.Flea`)

- Listings live in MemoryStore SortedMaps, one per item id (`Flea:<itemId>`), sorted by price then time, each entry `{listingId, sellerId, price, qty, itemData, expires}`. Barters live in `FleaBarter`.
- **Listing:** the item is removed from the seller's stash into the profile's `escrow.listings[listingId]` (saved), then the entry is written to MemoryStore. If the MemoryStore write fails, the item returns to the stash.
- **Buying:** the buyer's server calls `UpdateAsync` on the entry to mark it `soldTo = buyerId` (atomic; fails if already sold). Then it deducts MC from the buyer, grants the item, saves the buyer's profile, removes the entry, and appends the payout to DataStore `FleaPayouts/<sellerId>` with `UpdateAsync` (idempotent by listingId).
- **Seller payout:** when the seller's profile loads (or within 10 s via MessagingService `FleaSold` if they're online), payouts are applied: MC (minus tax) added, escrow entry cleared, Merchant Score +1, mail notice.
- **Expiry:** a sweeper returns expired listings to the seller's mail (escrow → mail).
- **Price history:** every sale appends `{price, time}` to `FleaHistory/<itemId>` (last 200 kept, DataStore), used by Appraisal and the 7-day average.
- **Logs:** every Flea action writes an audit line (`25` §25.8) for moderation.

## 16.4 Insurance

- At the Transit Gates before deploying (`UI-DEP-010`): tick the equipped items to insure (guns with attachments, armour, helmet, backpack). Not insurable: anything in the backpack grid, pockets or quick slots, Relics and Named items (`18`), blueprints.
- **Cost:** Mall Cash 15% of the insured items' total vendor value, or **Insurance (Robux)** 49 R$ per raid covering up to 50,000 MC of insured value (`19` §19.4).
- **Return:** if you die and an insured item isn't extracted by another player before the raid ends, it's mailed back after **60 minutes** of real time (−15% with the Security Terminal Desk). It arrives in the Mail Room and your flat mail. An insured item that another player extracted is gone ("Taken by a raider").
- Insurance lasts for one raid. A player who extracts gets nothing back (they kept their gear).

## 16.5 Repossession (Black Market)

- Uninsured items you lost on death that **nobody extracted** go into a **24 h hold** (after the raid ends).
- From the Mail Room's Black Market window ("Repossession", `UI-MAIL-010`) you can reclaim each held item for **60% of its vendor value in MC**, or a flat **99 R$ per item** (`19` §19.4).
- After 24 h, unclaimed items are gone.
- Not repossessable: Relics and Named items (they go to the world pool, `18`), raid-only items.

## 16.6 Mail

- Mail Room counter (NPC Pip) on the ground floor, plus the mail tab on the Flat Terminal (`UI-MAIL-001`).
- Mail holds: insurance returns, expired Flea listings, Flea payout notices, overflow auto-sale notices, repossession holds, Move Tickets and Homecoming Tickets, contract rewards not yet claimed, gifts (`19` §19.9), system messages.
- Items in mail are claimed to the stash with one tap (needs space). Mail items are kept 30 days.
- A small red dot on the Flat Terminal and the Mail Room sign shows unclaimed mail. No pop-ups.
