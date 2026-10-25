# 20 · Social: voice, quick lines, pings, emotes, chat, parties, matchmaking, invites and private servers

Owner of: every way players talk and signal, squad identification, parties, the matchmaker, invites and referral rewards, private servers, and safety tools.

**Rules that never change:**
- A stranger's intent is never shown by the game. Talking, signalling and lying are the players' tools (the betrayal pillar).
- Matchmaking uses **party size only** (Mareux, 25 Oct). No skill, behaviour, bounty or aggression score.
- The dead never speak to the living.

---

## 20.1 Voice

- Roblox voice chat, available only to users Roblox has made eligible (age-checked). Nothing in the game depends on voice; quick lines (§20.2) cover everyone.
- Built on the audio API (`AudioDeviceInput` → `AudioEmitter` on the character; `AudioListener` on the camera), so the game controls routing.

| Where | Channel | Rule |
|---|---|---|
| Tower | Proximity | Heard within 40 studs, normal falloff. Flats: only people in that flat. |
| Raid | Proximity (default) | Heard within 50 studs by everyone, strangers included, muffled through walls (`AudioFilter` low-pass when there's no line of sight). Talking is noise 25 every 2 s while the voice level is high (`02` §2.5 `Noise.Voice`). |
| Raid | **Squad radio** | Hold Radio (PC **Caps Lock**, gamepad D-pad right hold, mobile radio button) to transmit to your squad at any distance with a radio filter (`AudioDistortion` + band-pass) and a click (`SFX-COM-001/002`). You're still heard in proximity while transmitting. |
| Raid | Bodyguard VIP radio | `17` §17.6. |
| Raid | Mutants | Stalker Mutants and the Supermutant are muted on proximity voice and squad radio (`09` §9.11); their quick lines become roars. |
| Raid | Dead and spectating | Muted to all living players. Dead players hear each other (spectator channel). Ghosts (`09` §9.10) are dead players: muted to the living. |

## 20.2 Quick lines

- Hold **QuickLine** (PC **Z**; gamepad **D-pad left tap** opens the comms wheel; mobile **comms** button tap) to open an 8-slot wheel (`UI-COM-001`). Release (PC) or select (gamepad stick + A, mobile tap) a slot to say it.

| Slot | Line | Bubble text | Voice ids (voice A / B, 3 takes each) |
|---|---|---|---|
| 1 | Friendly! | `STR.QL.FRIENDLY` | `VO-QL-001…006` |
| 2 | Don't shoot! | `STR.QL.DONTSHOOT` | `VO-QL-007…012` |
| 3 | Follow me | `STR.QL.FOLLOW` | `VO-QL-013…018` |
| 4 | Help! | `STR.QL.HELP` | `VO-QL-019…024` |
| 5 | Danger! | `STR.QL.DANGER` | `VO-QL-025…030` |
| 6 | Thanks | `STR.QL.THANKS` | `VO-QL-031…036` |
| 7 | Over here | `STR.QL.OVERHERE` | `VO-QL-037…042` |
| 8 | Wait | `STR.QL.WAIT` | `VO-QL-043…048` |

- The line plays in 3D from the survivor (heard 40 studs, noise 30) with a speech bubble for 3 s (`UI-COM-002`, preset text, no filtering needed). Cooldown 1.5 s.
- Each survivor is given voice A or B at generation (by build). Voice packs (`19` §19.5) replace both.
- Squad-only versions: hold the wheel and press Radio to send the line over squad radio instead (bubble shows only to squad).

## 20.3 Pings (squad only)

- **Ping** (PC **middle mouse**, gamepad **D-pad right tap**, mobile ping button) marks what you're looking at for your squad for 10 s. Mutants and the dead can't ping.
- Ping types (decided by what's under the centre ray, 80 studs): **Location** (yellow diamond), **Item** (icon with tier colour, "Loot"), **Enemy** (red, zombie or The Janitor), **Player** (white "Player", not attached; stays where they were). `UI-HUD-080…083`, sound `SFX-COM-005`.
- Max 3 active pings per player. Pings are never shown to strangers.

## 20.4 Squad identification

- Squadmates wear a **coloured armband** on their left arm visible only to their squad (client-side colouring): slot 1 yellow, slot 2 cyan, slot 3 magenta. Strangers see a plain grey armband on everyone.
- **Squad tags:** squadmates' survivor names and a small health bar show above them within 30 studs, through walls (`UI-HUD-084`). Beyond 30 studs, nothing, unless they're Downed (then a red edge arrow and a "Downed" tag at any distance, `UI-HUD-085`).
- The squad list (top-left, `UI-HUD-010`) shows each mate's name, health and state (alive, Downed, dead). It never shows Sleeper status (a Sleeper sees only their own state, `09` §9.4).

## 20.5 Emotes

- Tap **Gesture** (PC **H**) to open the emote wheel (`UI-COM-010`). On gamepad and mobile, the emote wheel is the second page of the comms wheel (switch pages with LB/RB, or the tab on mobile). 8 slots, set in the collection.
- **Holding** Gesture for 1 s (PC hold H, gamepad hold D-pad left, mobile long-press the comms button) does nothing visible for anyone. For a Sleeper it starts the scent trail (`09` §9.6). Because the hold looks the same for everyone, it gives nothing away.
- Free: Wave, **Hands Up** (holsters the weapon and raises both hands; the universal "I'm friendly" signal), Point, Thumbs Up. Bought ones in `19` §19.5.
- Emotes cancel on any movement input except Wave and Point, which play on the upper body while walking.

## 20.6 Text chat

- Roblox `TextChatService`, all text filtered by Roblox.
- Tower: **General** (this instance) and **Party**. Raid: **Squad** and **Nearby** (players within 50 studs). No raid-wide channel.
- Dead players only see and write in a **Spectators** channel.
- Bubble chat on in the tower and for Nearby in raids.

## 20.7 Parties

- Covered in `14` §14.12: max 3, invite by Context on a player or from the party panel (`UI-TWR-020`), friends from other towers routed to the leader's instance.
- Party panel: members, leader crown, Stick Together toggle (default on), Fill Squad toggle (leader), Leave, Kick (leader).
- Leader leaving passes leadership to the longest-standing member.

## 20.8 Matchmaking (`Services.Matchmaker`)

**Queueing:**
1. The leader stands in the Transit Gates hall and opens the deploy panel (`UI-DEP-001`): party list, pool (auto: Solo, Duo or Trio by party size), **Fill Squad** toggle (for solos and duos), insurance (`16` §16.4), a loadout summary with warnings (overweight, no meds, Overflow Crate has items, Survivor Draft pending blocks), catalyst if bought (`19` §19.7), and **Deploy**.
2. Every member must be in the same tower instance and press **Ready** (members see a ready prompt). Ready members are frozen out of shops until they cancel.
3. The tower server writes a **ticket** to MemoryStore SortedMap `Queue:<pool>`: `{ticketId, userIds, partySize, fill, catalyst?, restricted, regionHint, serverJobId, enqueuedAt}`; score = `enqueuedAt`. Ticket TTL 90 s, refreshed every 10 s while queued.

**The matchmaker loop:**
- One tower server at a time holds the MemoryStore lock `MatchmakerLock` (lease 10 s, renewed every 3 s). That server runs the loop every 2 s.
- For each pool, oldest tickets first:
  - **Solo:** take up to 10 solo tickets.
  - **Duo:** up to 6 duo tickets. Fill-on solos are paired into duos first.
  - **Trio:** up to 4 trios. Fill-on duos get one Fill-on solo; Fill-on solos are grouped in threes.
  - A raid launches at max size, or at 4+ players once its oldest ticket has waited 45 s (`02` §2.1).
  - **Separation rules:** at most one catalyst ticket per raid; restricted players (`19` §19.2) never join a raid with a catalyst; Fill-on Mercenaries (`17` §17.6) are taken first when filling.
  - **Region:** tickets with the same `regionHint` are preferred for the first 20 s of waiting, then any region is allowed. `regionHint` comes from the tower server's location, looked up once at server start (`25` §25.4); "Global" if unknown.
- Launch: `TeleportService:ReserveServer(Places.Mall)` → access code; write `RaidPlan:<raidId>` to MemoryStore `{raidId, accessCode, squads, catalyst, createdAt}` (TTL 10 min); remove the tickets; publish MessagingService `RaidFound:<serverJobId>` to each involved tower server.
- Each tower server receiving `RaidFound` shows "Raid found" (`UI-DEP-002`, `SFX-UI-050`), waits 3 s (the freight-lift doors close in the Transit Gates hall), saves and releases profiles, and teleports its players with `TeleportAsync` (`ReservedServerAccessCode`, teleport data `{raidId}`).
- Squads from different towers are fine: everyone arrives at the same reserved server.

**Failures:**
- A player who fails to teleport after 3 tries stays in the tower; the raid starts without them (`03` §3.10).
- A ticket whose tower server dies expires by TTL.
- If the matchmaker server dies, another tower server takes the lock within 10 s.
- **Cancel:** any member can cancel before "Raid found"; the ticket is removed.
- Queue UI shows elapsed time and "Searching (Solo)" etc. (`UI-DEP-003`). No estimated time.

## 20.9 Invites and referral rewards

- **Invite friends** (tower HUD button and party panel): `SocialService:PromptGameInvite` with `launchData = {visit = towerId, inviter = userId}` (`14` §14.2).
- **Referral:** when a new player joins through an invite or Share Link, `Player:GetJoinData().ReferredByPlayerId` is stored on their profile. When the new player completes their **3rd raid** (extracted or not), both get a reward: the referrer gets 5,000 MC and the charm **"Plus One"** (`COS-CHM-011`, once); the new player gets 2,000 MC and the same charm. Max 10 referral rewards per referrer per month.
- **Friend bonus:** +10% raid XP when your squad includes a Roblox friend.
- Arrival's friend list (`UI-ARR-001`) lets players jump to a friend's tower (`14` §14.9).

## 20.10 Private servers

- The **Tower** place offers Roblox private servers (price set in P1, `26`; target the lowest standard monthly price).
- A private server runs a **Private Tower**: the ground floor, roof and Transit Gates, with the same vendors and the Flea, but no residency (nobody lives there). A lift button "My Flat" opens your own flat interior (built from your profile, `15` §15.1).
- Deploying from a private server creates a **private raid**: only that server's players (1–12, any squad sizes), no strangers, no minimum player count.
- Private raids: loot, XP, contracts and Supermutant revives work normally; catalysts allowed; no world Relics are placed (but Relics lost there still go to the pool); no bounty heat or claims; achievements that need strangers can't progress there.

## 20.11 Safety

- **Block** and **Report:** in the tower, Context on a player > Block (`StarterGui:SetCore("PromptBlockPlayer", player)`) or Report (Roblox's own report flow). In raids, use the Roblox Esc menu (People tab). The Roblox player list core GUI is **disabled in raids** (`SetCoreGuiEnabled(PlayerList, false)`) so names aren't shown on screen; the Esc menu's People tab still lists who is in the server, which is acceptable because it never links a name to a character.
- Blocked players: you don't hear their voice or see their text; they can't invite or visit you; the matchmaker still may place you in the same raid (party-size pools only).
- Display names are Roblox's own. No custom text anywhere in the game (`18` §18.4).
- Voice abuse is handled by Roblox's voice moderation.
