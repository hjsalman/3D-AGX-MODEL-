# SENSOR RIG ENCLOSURE - SPEC SHEET (v3.9)
Parametric OpenSCAD enclosure, USC SyReX lab.
Files: sensor_enclosure.scad (assembly), box_body.scad, handles.scad, box_body.stl, handles.stl.

## BOX
- Outer: 201 x 285 x 185 mm
- Wall 5 mm, floor 4 mm, top open
- Cavity inner: X +/-95.6, Y 5 to 280, Z 4 to 189 mm
- Frame: +X right, +Y back, +Z up; front face = Y0; X0 = midpoint of ZED lenses

## COMPONENTS (size, source)
| Part | Size (mm) | Source |
|---|---|---|
| ZED 2i | 175.25 x 30.25 x 43.1, baseline 120 | stereolabs.com/products/zed-2i |
| IWR1443BOOST + DCA1000 stack | DCA board 90 x 102 x 1.6; stack depth ~30 | ti.com/tool/DCA1000EVM |
| Jetson AGX dev kit | 105 x 105 x 65 | developer.nvidia.com/embedded/jetson-agx-xavier-developer-kit |

## COMPONENT POSITIONS (bounding box, mm)
| Part | X | Y | Z |
|---|---|---|---|
| ZED 2i | -87.6 to 87.6 | 5.0 to 48.1 | 14.0 to 44.2 |
| mmWave (antenna on X0) | -11.0 to 79.0 | -8.0 to 26.0 | 86.2 to 188.2 |
| AGX | -52.5 to 52.5 | 106.1 to 211.1 | 10.0 to 75.0 |

## MOUNT HOLES
| Mount | Pattern (mm) | Screw | Encl. hole | Board hole | Extra |
|---|---|---|---|---|---|
| mmWave (rear plate) | 76.30 x 56.89 | M3 | 3.4 clr | DCA 4.32 / IWR 4.06 | 8 washer seat |
| ZED 2i (rear plate) | 153.4 x 14 | M3 | 3.4 clr | 3.13 | 8 washer seat |
| AGX (floor) | 97 x 97 | M3 | 3.4 clr | 3.5 | 9 counterbore, 6 standoff |
| Handles (each side) | 46 vertical (hole pitch) | M3 | 3.4 clr | - | captive M3 nut, 6.6 A/F |

mmWave and ZED boards bolt to full-width plates fused into both side walls (same scheme).
mmWave plate at Y26 (DCA back); ZED plate at Y48.
Antenna centered on X0: the marked antenna center sits 34 mm to the side and 8 mm up from the
4-screw center, measured off the real board photo (76.30/56.89 screws as scale). Mounting holes
are offset 34 mm (rad_cx=34) so the actual antenna array lands on the ZED centerline (X=0).
IMU (Phidgets 1205): 4 screw holes in the front wall at X=55 (right of the mmWave opening),
Z=137. Hole pattern 22.86 x 27.94 mm, M2 bolts (VERIFIED from Phidgets MOT0110 mechanical drawing). IMU enclosure 37.8 x 39.0 mm, holes dia 2.0.
Handles: mounted at box middle (Y=143), grab bar centered on the mount.
Handles: 18 mm sq section, reach 72 (54 mm hand clearance), grab bar 240 long centered on the mount (mounted at box middle), end stops 52 up both ends.

## OPENINGS (mm)
- mmWave front window: 91.5 x 103.5
- ZED lens window: 164 x 28
- ZED connector opening: 40 x 22
- Rear cable slot: 104 x 30 (~AGX board width)

## INTERNAL CLEARANCES (mm)
- AGX back to rear wall (cables): 63.5 (2.5 in)
- AGX front to ZED (front clearance): 63.5 (2.5 in)
- ZED top to mmWave bottom: 42
- ZED to each side wall: 8
- mmWave antenna protrudes 8 out the front window; top open for wire routing
- IMU inside: case 13.4 mm thick extends Y5-18.4; clears mmWave board (X gap ~6 mm)
- No component collisions

## FASTENERS
- All mounts M3. Enclosure holes 3.4 clearance (not tapped).
- Secure with screw + washer + nut, or M3 heat-set insert. No printed threads.
- Washer 8 | AGX counterbore 9 | M3 nut 6.6 across flats
- ZED extra holes (unused for mounting): bottom 1/4-20 UNC + 2x M3 (3.53); cable lock 2x M2.5 (2.8) @ 18.5

## SOURCES
- DCA1000EVM holes (76.30 x 56.89, dia 4.32): ti.com/tool/DCA1000EVM -> SPRR350 STEP
- IWR1443BOOST holes (75.55 x 56.90, dia 4.06): ti.com/tool/IWR1443BOOST -> SPRR253 NPTH.drl
- DCA board 90 x 102: ti.com/lit/ug/spruij4a/spruij4a.pdf
- ZED 2i: stereolabs.com/products/zed-2i
- Jetson AGX dev kit: developer.nvidia.com/embedded/jetson-agx-xavier-developer-kit

## CONFIRM (before final)
- Antenna phase-center offset (used 12 mm from TI IWR Gerber; confirm exact value)

## CONFIRM ON THE BENCH (caliper)
- ZED back-hole pitch 153.4 x 14 (from Stereolabs drawing)
- AGX mount pitch 97 x 97 (from NVIDIA spec)
- mmWave stack depth 34 (DCA measured ~20 from STEP + connector/IWR)

## EXPORT
openscad -o box_body.stl box_body.scad
openscad -o handles.stl handles.scad
