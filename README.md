# bolton-house-prices-crispdm-r
CRISP-DM house price prediction for Bolton residential area (R programming language): data prep, model comparison(MLR/SVR/Tree/RF), and Random Forest deployment.

![R](https://img.shields.io/badge/R-4.x-blue) ![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

End-to-end **CRISP-DM** project to predict residential sale prices in **Bolton**.  
Data understanding → preparation (log/factors/scale) → model comparison (MLR, SVR, Tree, **Random Forest**) → evaluation & single-property valuation. All in **R**.  
See full report: `docs/report.pdf`. 

## Highlights
- Dataset: **13,932** records, 17 columns (structural, distances, noise, month).   
- Prep: drop `PARCELNO`, `LATITUDE`, `LONGITUDE`; `SALE_PRC_LOG10`; factor conversions; scale/center.   
- Split & CV: 80/20 train/test; **5-fold CV** for tuning.   
- Best model: **Random Forest** (~500 trees) with lowest **RMSE (~$99k)**, lowest **MAE (~$47k)**, highest **R² (~0.89)** on test. 

## Quickstart
```r
install.packages("renv"); renv::init()
renv::restore()  # installs packages from renv.lock
