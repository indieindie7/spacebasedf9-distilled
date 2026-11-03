# Spacebase DF-9 - distilled Lua

Smaller copy of the game scripts of *Spacebase DF-9* (Double Fine Productions). Same behaviour, less code.
Code by Double Fine Productions, "Copyright (c) 2012 Double Fine Productions", licensed CPAL-1.0 (see `COPYING`). The CPAL-1.0 licence is taken from the community fork https://gitlab.com/derelictgames/spacebase-v2-updated-code; the Steam install itself ships no licence text, only the copyright headers.
This repo holds only Lua source and text. No art, audio or binaries. You need your own legal copy of the game.

## Size
| | files | lines |
|---|---|---|
| shipped (baseline 82b4704) | 465 | 132003 |
| distilled | 395 | 75152 lines, 565458 Lua tokens (baseline 131942 lines, 776846 tokens by the lexer metric) |

## What was cut (commits)
1. 45f25fb: 70 files unreachable from `config.lua`/`main.lua` (editor/dev tools, analytics/IAP, jit disassemblers, duplicate string table, unused UI/tasks).
2. 9a04d21: 246 member/local functions whose name appears nowhere else in the code base.
3. f986ced: comments (license/copyright ones kept), blank lines, trailing whitespace.
4. bdd6083: `GalaxyData` 4096 one-line rows -> packed 64x64 number array + loader, identical resulting table (checksum verified in game).
Passes 13-15: shared UI.LH layout helpers, credits/linecode data, HEAD_TYPE helper, dead-function re-sweep. Remaining candidates (per-file _hN helpers, dup windows) each gain < 0.2%.

## Verification
Harness boots the game (`Space.exe`, minimized), starts a new base, runs 3 in-game days at 60x, forces 8 event types, logs every Lua error, compiles every file (syntax check). Each pass: 0 errors, 0 syntax failures, same events, same loaded-module set (lazy-loaded modules vary with run noise). Limit: start base is tiny (3 crew, 1 room), so late-game code paths are covered only by static analysis. Play-test before trusting rarely used features.

## Install
Copy the contents over `Data/` of your legally owned Spacebase DF-9 (back up `Data/` first). Files here mirror the `Data/` layout (`Scripts`, `Common`, `Moai`, `UILayouts`, `Dialog`, `build.string`).

## License
CPAL-1.0, see `COPYING`. Original notices retained. Exhibit B attribution: Double Fine Productions.
