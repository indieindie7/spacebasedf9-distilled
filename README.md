# Spacebase DF-9 - distilled Lua

Smaller copy of the game scripts of *Spacebase DF-9* (Double Fine Productions). Core loop kept (build rooms, mine, assign duties, keep crew alive); non-gameplay systems removed.
Code by Double Fine Productions, "Copyright (c) 2012 Double Fine Productions", licensed CPAL-1.0 (see `COPYING`). The CPAL-1.0 licence is taken from the community fork https://gitlab.com/derelictgames/spacebase-v2-updated-code; the Steam install itself ships no licence text, only the copyright headers.
This repo holds only Lua source and text. No art, audio or binaries. You need your own legal copy of the game.

## Size
| | files | lines |
|---|---|---|
| shipped (baseline 82b4704) | 465 | 132003 |
| distilled (ef09583) | | 68446 lines, 521348 Lua tokens (baseline 131942 lines, 776846 tokens by the lexer metric): -33% tokens, -48% lines |

## What was cut (commits)
1. 45f25fb: 70 files unreachable from `config.lua`/`main.lua` (editor/dev tools, analytics/IAP, jit disassemblers, duplicate string table, unused UI/tasks).
2. 9a04d21: 246 member/local functions whose name appears nowhere else in the code base.
3. f986ced: comments (license/copyright ones kept), blank lines, trailing whitespace.
4. bdd6083: `GalaxyData` 4096 one-line rows -> packed 64x64 number array + loader, identical resulting table (checksum verified in game).
Passes 20-27 (non-gameplay removal): debug/dev, all audio (SoundManager, cues, voices, call sites; game runs silent), editor/cheats, profiling, crash reporting, credits + options menus, 236 unused linecodes; save-upgrade code kept (shipped modules use save versions 1, 3, 7); platform shims kept (live per-OS branches).
Passes 13-15: shared UI.LH layout helpers, credits/linecode data, HEAD_TYPE helper, dead-function re-sweep. Remaining candidates (per-file _hN helpers, dup windows) each gain < 0.2%.

Pass 19: tutorial removed. Pass 28 (006aec1): player save/load removed (module deserialization kept: new games, docking ships and asteroids load shipped `Modules/*.sav`). Passes 29-32: UI dedup (shared layout helpers `LH.pos`, `LH.iconBtn`, table-driven ObjectMenu rows), -1%.

## Findings
- Behaviour-preserving refactors bottom out around -27% tokens (pass 18); every later gain came from deleting features.
- What is left (by file-name grouping, rough): UI scripts + layouts ~32%, stats/inspectors 5.6%, social/chat/log + dialogue lines 4.9%, derelicts/docking 2.8%, disasters 2.1%, research 1.9%, hints/tooltips 1.8%, combat/turrets 1.3%.
- Class trees are shallow (48 Task, 34 SeqCommand, 17 EnvObject subclasses). An entity-component rewrite in the spirit of Casey Muratori's "The Big OOPs" talk would save only an estimated 5-10%; the bulk is UI and data, not hierarchy.

## Ideas tried / not done
- Tried: dead-code sweeps, duplicate-window dedup, packed data tables, shared UI helpers, feature removal (tutorial, debug, editor, cheats, profiling, crash reports, credits, options, audio, saves, unused lines).
- Not done: a from-scratch rewrite of the core loop as a new small game. Rough estimate: the core simulation fits in about 1k lines; the 68k here are mostly UI, content data and engine glue.
- Not done: running it in DOSBox (Lua 5.1 via DJGPP + headless harness first, then a VGA tile view; the Moai/OpenGL renderer would need a software rewrite). Rules from Andreas Fredriksson's Amiga demo "Eon" talk would apply: hard caps, static pools, tables baked offline.

## Verification
Harness boots the game (`Space.exe`, minimized), starts a new base, runs 3 in-game days at 60x, forces 8 event types, logs every Lua error, compiles every file (syntax check). Each pass: 0 errors, 0 syntax failures, same events, same loaded-module set (lazy-loaded modules vary with run noise). Limit: start base is tiny (3 crew, 1 room), so late-game code paths are covered only by static analysis. Play-test before trusting rarely used features.

## Install
Copy the contents over `Data/` of your legally owned Spacebase DF-9 (back up `Data/` first). Files here mirror the `Data/` layout (`Scripts`, `Common`, `Moai`, `UILayouts`, `Dialog`, `build.string`).

## License
CPAL-1.0, see `COPYING`. Original notices retained. Exhibit B attribution: Double Fine Productions.
