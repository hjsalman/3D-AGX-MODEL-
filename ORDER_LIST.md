# SENSOR RIG ENCLOSURE — ORDER LIST
Metal build: 3003 aluminum, 2 mm, bent into 2–3 panels screwed together.
All mounts are through-holes (screw + nut). Screw lengths below are figured to go all the way
through and still catch the nut, with a little margin. Rule of thumb: if unsure on a length, get the NEXT SIZE LONGER, not shorter (too long = add a washer, too short = useless).

======================================================================

## SHEET-METAL TAKEOFF (why half a 4x4)
Box outer: 201 (W) x 285 (D) x 185 (H) mm, open top.
| Panel | Size (mm) | Area m2 |
|---|---|---|
| Front | 201 x 185 | 0.037 |
| Back | 201 x 185 | 0.037 |
| Left side | 285 x 185 | 0.053 |
| Right side | 285 x 185 | 0.053 |
| Bottom | 201 x 285 | 0.057 |
| mmWave mount plate (internal) | 201 x 79 | 0.016 |
| ZED mount plate (internal) | 201 x 55 | 0.011 |
| Panels subtotal | | 0.264 |
| Bend flanges + screw tabs | | 0.034 |
| Nesting + kerf waste ~25% | | 0.074 |
| TOTAL NEEDED | | 0.372 m2 |

Sheet: quarter 4x4 (0.37 m2) = too small (no margin). HALF a 4x4 = 24x48 in (0.74 m2) = right buy, 2x need.

## 1. METAL (the box itself)
======================================================================
- **3003 aluminum sheet, 2.0 mm (0.080") thick.**
  **AMOUNT: half a 4x4 ft sheet = 24 x 48 in (610 x 1220 mm). One piece.**
  Why that much: the five panels (front, back, 2 sides, bottom; open top) unfold to roughly
  0.25 m² of flat area. A 24x48 in piece is ~0.75 m², so ~3x what's needed — plenty of margin for
  the bend flanges, the tabs where panels overlap, and a couple of mistakes. One piece covers it.
  - OnlineMetals (cut to size, ships 1–2 days): https://www.onlinemetals.com  (search: 0.080" 3003-H14 sheet)
  - Metals Depot (backup): https://www.metalsdepot.com/aluminum-products/aluminum-sheet-3003
  (6063-T3 at 2 mm is a fine substitute if 3003 is out.)

======================================================================
## 2. SCREWS / NUTS / WASHERS  (per mount, with length reasoning)
======================================================================
Fastest way to cover ALL of these in one shot: one big M3 assortment kit (screws 6–25 mm +
nuts + washers) + one M2 kit. Buying each size separately (McMaster / Fastenal) also fine.
- M3 assortment kit: https://www.amazon.com/s?k=M3+socket+head+cap+screw+nut+washer+assortment+kit
- M2 assortment kit: https://www.amazon.com/s?k=M2+screw+nut+washer+assortment+kit
- Local same-day (all sizes): Fastenal, Columbia SC — https://www.fastenal.com/locations
- Exact individual parts: McMaster-Carr — https://www.mcmaster.com

Detailed breakdown (what each goes to):

| # | Where it goes | Screw | Qty | Length reasoning |
|---|---|---|---|---|
| A | mmWave (IWR+DCA) — 4-hole pattern 76.30 x 56.89 | M3 x 22 | 4 | thru DCA board (1.6) + 15 mm standoff + 2 mm plate + catch nut ≈ 21 -> use 22 |
| A2| mmWave standoffs (space DCA 15 mm off the plate) | M3 x 15 round spacer/standoff | 4 | fixed 15 mm (from reference box) |
| B | ZED 2i — 4-hole pattern 153.4 x 14 | M3 x 8 | 4 | thru 2 mm plate + into ZED's own M3 insert (~5) = 7 -> use 8 (no nut, ZED is threaded) |
| C | Jetson AGX — 4-hole pattern 97 x 97 | M3 x 12 | 4 | thru 2 mm floor + 6 mm AGX standoff + catch nut ≈ 10 -> use 12 |
| C2| AGX standoffs (raise AGX ~6 mm off floor for airflow) | M3 x 6 spacer | 4 | fixed 6 mm |
| D | Handles — 2 per handle, 2 handles | M3 x 16 | 4 | thru 6 mm foot + 2 mm wall + catch nut ≈ 10 -> 16 leaves room for a lock nut/washer |
| E | IMU (Phidgets 1205) — 4-hole pattern 22.86 x 27.94 | M2 x 8 | 4 | thru 2 mm wall + into IMU case (~5) = 7 -> use 8 |
| F | Panel joints (assemble the 2–3 aluminum parts) | M3 x 8 | ~16 | thru two 2 mm flanges (4) + catch nut ≈ 6 -> use 8. (Or 1/8" pop rivets, see below) |

NUTS:
- M3 hex nuts (5.5 mm across-flats): ~28  (mmWave 4, AGX 4, handles 4, panel joints 16)
- M2 hex nuts: 4 (IMU)
WASHERS:
- M3 flat washers (Ø7 OD): ~44  (2 per fastener at mmWave/AGX/handles/panels, 1 at ZED)
- M2 flat washers: 8 (IMU)
(All of the above nuts + washers are included in the assortment kits above.)

OPTIONAL — panel joining by rivets instead of screws+nuts (cleaner, permanent):
- 1/8" (3.2 mm) aluminum blind/pop rivets, ~1/4" grip, qty ~24 + a rivet gun.
  https://www.amazon.com/s?k=1%2F8+aluminum+pop+rivets

======================================================================
## 3. USB HUB (for the touchscreen + IMU wires off the AGX)
======================================================================
- Powered USB 3.0 hub, 4-port, compact.
  https://www.amazon.com/s?k=powered+usb+3.0+hub+4+port+compact
  Pick one and send me its L x W x H if you want space cut for it inside.

======================================================================
SHIPPING NOTE: aluminum from OnlineMetals/Metals Depot and the kits from Amazon all land in
1–2 days. Fastenal Columbia has all the M2/M3 hardware in stock for same-day local pickup.
If unsure on any screw length, buy the next size LONGER (too long, add a washer; too short, useless).
