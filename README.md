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
```
## Data
Place data under **data/** (**see data/README.md**), **then run scripts**:

```r
source("R/01_data_understanding.R")
source("R/02_data_prep.R")
source("R/03_train_models.R")
source("R/04_evaluate.R")
# one-off valuation (edit inside the script or pass args)
source("R/05_predict_one.R")
```
**or run the whole RMarkdown notebook notebooks/DAT7303_1_3_2011184.Rmd**

## Results
  - **RF** achieved the strongest generalisation with the above metrics; metric table and RMSE comparison figure included in docs/figures/.

  ### Single-property valuation
  The trained RF predicted $1,453,318 for a high-spec property with large land/living area and favourable distances (see report §6.3).

## Repo map
```php
R/           ... 01_* to 05_* scripts (EDA → prep → train → eval → predict)
notebooks/   ... original Rmd (optional)
data/        ... (not in git) CSVs go here; see data/README.md
models/      ... saved .rds (ignored in git; use Releases)
results/     ... metrics.json and generated figures
docs/        ... report.pdf and figures from the report
```

## Ethics and privacy
Coordinates and unique identifiers are excluded from modelling to protect privacy and reduce leakage risk. Dataset usage must comply with source licensing.

## License
**MIT**

