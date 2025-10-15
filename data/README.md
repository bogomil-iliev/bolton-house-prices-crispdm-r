
# Data (not included)

Place the Bolton housing CSV(s) here (kept out of git for privacy/compliance).

**Expected columns** (see report & dataset spec):
PARCELNO, SALE_PRC, LND_SQFOOT, TOTLVGAREA, SPECFEATVAL,
RAIL_DIST, OCEAN_DIST, WATER_DIST, CNTR_DIST, SUBCNTR_DI,
HWY_DIST, age, avno60plus, structure_quality, month_sold, LATITUDE, LONGITUDE

# Notes:
- Modelling **drops** `PARCELNO`, `LATITUDE`, `LONGITUDE` (ID/coords; privacy & leakage). 
- `SALE_PRC` is also log10-transformed for some models. 
- Convert to factors: `month_sold`, `avno60plus`, `structure_quality`. 
- Split: 80/20 train/test; CV: 5-fold for tuning. 

