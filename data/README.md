# Data (not included)

Place the Bolton housing CSV(s) here (kept out of git for privacy/compliance).

**Expected columns** (see report & dataset spec):
PARCELNO, SALE_PRC, LND_SQFOOT, TOTLVGAREA, SPECFEATVAL,
RAIL_DIST, OCEAN_DIST, WATER_DIST, CNTR_DIST, SUBCNTR_DI,
HWY_DIST, age, avno60plus, structure_quality, month_sold, LATITUDE, LONGITUDE

# Notes:
- Modelling **drops** `PARCELNO`, `LATITUDE`, `LONGITUDE` (ID/coords; privacy & leakage). :contentReference[oaicite:8]{index=8}
- `SALE_PRC` is also log10-transformed for some models. :contentReference[oaicite:9]{index=9}
- Convert to factors: `month_sold`, `avno60plus`, `structure_quality`. :contentReference[oaicite:10]{index=10}
- Split: 80/20 train/test; CV: 5-fold for tuning. :contentReference[oaicite:11]{index=11}

