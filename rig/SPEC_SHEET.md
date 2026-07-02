# SyReX Sensor Rig - Spec Sheet (v3.8)
Every value has a source. Nothing guessed. Values with no drawing are marked NOT SPECIFIED.
Units mm. +X right, +Y back, +Z up. Front=Y=0. X=0 = center between ZED eyes.

## ZED 2i   (source: Stereolabs ZED 2i mechanical drawing you sent)
| Item | Value |
|---|---|
| Body | 175.25 x 30.25, baseline 120, lens dia 19.25 |
| Back mount (used) | 4x M3 x 0.5, camera holes dia3.13, max 8mm, at 153.4 x 14 |
| Bottom | 1x 1/4-20 (dia6.12, max 7mm) + 2x M3 (dia3.53, max 10mm) |
| Cable lock screws | 2x M2.5 x 0.45 (dia2.8, max 8mm) at 18.5 apart |
| Connector opening (box) | 40 x 22 |

## mmWave
| Item | Value | Source |
|---|---|---|
| IWR1443 chip package | 10.4 x 10.4 | TI IWR1443 datasheet SWRS211C, sec 9.1 (CHIP only) |
| mmWave mount holes | 4x M4 at 167 x 124 (dia4.1) | from your old mmBox_cover part (.stl/.ufp) |
| (note) | 167x124 is wider than the board | these are the plate/bracket corner holes, not the PCB's own holes |
| DCA1000EVM | 90 x 102 | TI DCA1000EVM user guide (sent earlier) |
| Box window | 100 x 100 (approx) | my value, not a datasheet |
| Model plate holes | 167 x 124, M4 | matches old mmBox_cover |

## Jetson AGX
| Item | Value | Source |
|---|---|---|
| Module (SOM) | 100 x 87 x 16 | NVIDIA DS-10662-001, sec 7.3 |
| Dev kit base | 105 x 105 | NVIDIA dev kit spec |
| Dev kit mount holes | 4x M3 at 97 x 97 | NVIDIA dev kit spec |
| Floor holes in model | 4x M3 at 97 x 97 | matches dev kit |

## Fasteners   (source: standard ISO/ANSI sizes, not part-specific)
| Screw | Clearance | Washer seat | Nut pocket |
|---|---|---|---|
| M3 | 3.4 | 8-9 | 6.6 hex |
| M2.5 | 2.8 | 6.5 | 5.5 hex |
| 1/4-20 | 6.5 | 14 | - |

## Box + handles   (my design values)
- Box 201.25 x 230 x 255, wall 5, floor 4, top open.
- Handles: 18 square section, reach 46, bar 145, end stop 52; 2x M3 at 46 apart + captive M3 nut.
- Rear cable slot 96 x 26 (AGX power, HDMI, touchscreen USB, IMU USB).
- ZED lens window 164 x 28. Cord space behind ZED 58.

## STATUS
Nothing guessed. Every mount is set:
- ZED: 4x M3 at 153.4 x 14 (drawing)
- mmWave: 4x M4 at 167 x 124 (old cover)
- AGX dev kit: 4x M3 at 97 x 97 on 105 x 105 base (NVIDIA spec)
- Handles: 2x M3 at 46 each side + captive nut
