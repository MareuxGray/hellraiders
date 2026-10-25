# 17 · Bounties, the Most Wanted Wall and role titles

Owner of: how bounties are created, funded, shown, claimed and expire; Dogtags; Claim Tickets; the radio bounty call; the four role titles (Bounty Hunter, Bodyguard, Mercenary For Hire, Vigilante), their contracts and perks; anti-abuse rules. Built in Feature F6 (`26`).

**Rules that never change:**
- Bounties are **anonymous**. No account name, display name or survivor name is ever shown for a target, a contributor or a hunter. Targets are identified only by their survivor's look (face, hair, outfit cosmetics) and a last-seen wing.
- Bounties are funded with **Mall Cash only**. Robux never goes into a bounty.
- A bounty is on a **survivor**, not an account. When that survivor dies, the bounty ends (claimed or not).
- Nothing about bounties shows on the raid HUD of strangers. Betrayal and hostility stay hidden (`07` §7.7).

---

## 17.1 Words

- **Target:** a survivor with an active bounty.
- **Pot:** the total MC on a target (system heat + contributions).
- **Heat:** MC added to a target's pot automatically by unprovoked kills.
- **Dogtag:** a 1×1 item (`ITM-TAG-001`, "Dogtag", tier Epic, value 0, not tradeable, not sellable) harvested from a dead target by a Bounty Hunter. It carries the target's bounty id.

## 17.2 How a bounty grows

| Source | Amount | Rule |
|---|---|---|
| **Unprovoked kill** (`07` §7.7) | +1,500 MC heat per kill | Paid by Tower Management (a faucet). Max 4,500 heat per raid per survivor. Killing a Sleeper who later turns out to be infected still counts (nobody can know). Kills of mutants (Stalker, Supermutant) and Sprinters never count. |
| **Victim contribution** | 500–20,000 MC, chosen by the victim | On the death screen of a human killed by another human (`UI-RES-010`), the button **"Put a price on their head"** (`STR.BNT.CONTRIBUTE`) opens a slider. Available for 10 minutes after the raid (also from the mail notice "You were killed by a raider"). The victim sees only the killer's portrait (survivor look, no name). |
| **Public contribution** | 500–20,000 MC per player per target per day | At a Contract Terminal, anyone can add to any listed target's pot. |

- A target appears on the wall once its pot reaches **5,000 MC**.
- Contributors need account age 7 days or more and can't contribute to a bounty on a survivor in their party, their friends list, or anyone they've partied with in the last 24 h.

## 17.3 The Most Wanted Wall

- **Where:** a three-storey LED wall above the dry fountain in the ground-floor atrium (`MDL-TWR-060`, SurfaceGui panels `UI-BNT-001`). Six Contract Terminals around it (`MDL-TWR-061`), staffed by NPC Contract Officer **Reyes**.
- **Content:** rotates every 8 s through the **Network Top 10** (the highest pots across all towers). Each card shows: a slowly rotating 3D render of the target survivor (ViewportFrame, `UI-BNT-002`) wearing their outfit cosmetics, the pot in MC, the last-seen sighting ("Last seen: Electronics, Floor 2, 3 h ago"), and the number of active Claim Tickets. A side strip shows the **Tower Top 5** (targets who live in this tower).
- **Last seen:** the wing and floor where the target was when their last raid ended for them (extract, death or disconnect), with the time.
- **Data:** MemoryStore SortedMap `Bounties` keyed by bounty id, sorted by pot. Each entry `{bountyId, survivorId, ownerUserId (server-only, never sent to clients), look, pot, heat, lastSeen, tickets, createdAt, lastIncreaseAt}`. A copy is kept in DataStore `BountyRecords/<bountyId>` for durability. The wall refreshes every 60 s.
- **Target's own view:** a target sees a small "WANTED · {pot} MC" tag on their own HUD in the tower and raid (`UI-HUD-060`), and a notice when they enter the Network Top 10. Nobody else sees this tag.
- Sound: the wall hums (`SFX-BNT-001`); a new #1 plays a short alarm sting across the atrium (`SFX-BNT-002`).

## 17.4 Claiming a bounty

1. Only a survivor holding the **Bounty Hunter** title (§17.6) can claim.
2. The hunter kills the target in a raid (final damage, `07` §7.7). Any kill counts, provoked or not.
3. On the target's corpse, a **Harvest Dogtag** action appears for the hunter only (hold Context 2 s, `ANIM-ACT-050` crouch and snap, `SFX-BNT-010` chain snap). The Dogtag goes into the hunter's inventory (needs a 1×1 space).
4. The hunter must **extract** with the Dogtag. Dying loses it like any item (another Bounty Hunter can loot it and extract it).
5. At a Contract Terminal, **Claim** (`UI-BNT-010`): the pot is paid in MC, × the Claim Ticket multiplier (§17.5). `STR.BNT.CLAIMED`, `SFX-BNT-011` cash register, the wall shows "BOUNTY COLLECTED" over that card for 60 s (no names).
- The Dogtag can be claimed for 72 h after the raid, then it crumbles (removed, mail notice).
- **No claim** if the hunter and target were in the same party in the last 24 h, are Roblox friends, or are a linked pair flagged by the anti-alt check (`25` §25.9). The Harvest action doesn't appear.

## 17.5 Claim Tickets

- At a Contract Terminal, a Bounty Hunter can take a **Claim Ticket** on a listed target: cost 10% of the current pot (min 500 MC). Max 3 tickets per hunter per target.
- Each ticket adds **+25%** to that hunter's payout on that target (paid by Tower Management on top of the pot). Tickets last for the hunter's next 5 raids or until the target dies, whichever comes first. No refund.
- A ticket also adds the target to the hunter's **Dossier** (§17.6) for those raids.
- Matchmaking never uses bounties or tickets. Meeting a target is chance (`20` §20.8).

## 17.6 Role titles

- One role title per survivor at a time. Bought at a Contract Terminal. Lost when the survivor dies (`13` §13.2). Buying a new title replaces the old one (no refund).
- In the tower, the title shows as a small badge under the player's display name (`UI-TWR-030`). In raids it's never shown to strangers.

| Title | MC (level) | Robux (any level) |
|---|---|---|
| Bounty Hunter | 15,000 (level 15) | 49 R$ |
| Bodyguard | 10,000 (level 10) | 39 R$ |
| Mercenary For Hire | 10,000 (level 10) | 39 R$ |
| Vigilante | 12,000 (level 10) | 39 R$ |

Titles give **permissions and information**, never combat stats.

### Bounty Hunter
- Can harvest Dogtags and claim bounties (§17.4) and take Claim Tickets (§17.5).
- **Dossier** (`UI-BNT-020`, opened from the inventory screen in raids): lists the targets present in this raid (max 3 shown, highest pots first) with their portrait and pot. Ticketed targets are always listed if present. It never shows positions.
- **Proximity cue:** when within 40 studs of a target from the Network Top 10 or one you hold a ticket on, a faint, slow ticking plays in the hunter's ears (`SFX-BNT-020`, 2D, volume rising as distance falls). No direction, no marker.
- Earns +100 XP per claim.

### Bodyguard
- Can accept **Escort Contracts** at a Contract Terminal (`UI-BNT-030`). Any player (the **Client**) can post one: fee 1,000–25,000 MC, held in escrow from the Client's MC when posted. The contract lasts 30 minutes or until accepted.
- On accept, Bodyguard and Client are put in the same party (in the Client's instance, `14` §14.12) and queue together. The contract covers **one raid**.
- **Payout:** the fee goes to the Bodyguard if the Client extracts alive (the Bodyguard doesn't need to). If the Client dies, the fee returns to the Client minus 10% (the Bodyguard gets nothing). If the Bodyguard leaves the party or the raid early, the full fee returns to the Client.
- **VIP radio:** the Client's position shows to the Bodyguard as a gold squad marker at any distance, and the Client's health shows as a bar (`UI-HUD-061`). Quick lines and voice between them work at any distance with a radio crackle (`SFX-COM-010`).
- On success: +300 XP and +5 Vendor Loyalty (`13` §13.5).
- A Client can rate the Bodyguard thumbs up or down after the raid; the Bodyguard's rating (percentage of ups, last 20) shows on their listing.

### Mercenary For Hire
- Appears on the **Hire Board** (a tab on the Contract Terminals, `UI-BNT-040`) with their asking fee (500–10,000 MC), rating, raid count and survivor portrait. Mercenaries can set themselves available or not.
- A party with a free slot can hire one. The fee is paid when the raid starts (non-refundable) and the mercenary joins the party for one raid. If the mercenary leaves the raid early (`03` §3.6), the fee is refunded to the party leader.
- The party can rate the mercenary after the raid (same as Bodyguard).
- Mercenaries get first priority in Fill Squad (`20` §20.8) when they queue solo with Fill on.

### Vigilante
- **Justice pay:** killing a human who made an unprovoked kill **in this raid** pays +2,000 MC at results (`STR.BNT.JUSTICE`), even if they had no bounty. Max 2 per raid.
- **Sense:** when a stranger within 60 studs makes an unprovoked kill, the Vigilante hears a short low sting (`SFX-BNT-030`). No direction, no marker. They know a killer is close, not who.
- Earns +1 Helper reputation per Justice kill.

## 17.7 The radio bounty call

- If any survivor in the raid has a pot of 10,000 MC or more, the mall radio (the in-world PA, `24` §24.4) announces at 300 s and 720 s of the raid clock: "Bounty sighting. {Wing}." (`VO-RAD-010…016`, one per wing, subtitled `STR.RAD.BOUNTY`). The wing is where the highest-pot target is at that moment. Everyone hears it.

## 17.8 Expiry and refunds

- **Target dies without a valid claim** (zombies, a non-hunter, sealed in, mutation): the bounty ends. Contributors get 50% of their contributions back by mail. Heat and ticket money vanish.
- **No increase for 7 days:** the bounty ends with the same 50% refund.
- **Target's account is moderated or deleted:** the bounty ends with a 100% refund to contributors.
- When a bounty ends, the target gets a quiet notice ("Your bounty has ended").

## 17.9 Anti-abuse

- Self-claiming through an alt account is blocked by the party, friend and device-link checks (§17.4) and the 7-day account age.
- System heat needs a kill that is "unprovoked" by the server's rule (`07` §7.7) and is capped per raid.
- A player can't take a Claim Ticket on a bounty they contributed to, or claim it.
- Every bounty event writes an audit line (`25` §25.8).
- Bounties never affect matchmaking (Mareux, 25 Oct: party-size pools only).
