## 4. Prediction Generation for a Specified Property.

```{r}

#Inputting the data for prediction as per the assignment brief
new_house <- tibble(
  LND_SQFOOT        = 11247,
  TOT_LVG_AREA      = 4552,
  SPEC_FEAT_VAL     = 2105,
  RAIL_DIST         = 4871.9,
  OCEAN_DIST        = 18507.2,
  WATER_DIST        = 375.8,
  CNTR_DIST         = 43897.9,
  SUBCNTR_DI        = 40115.7,
  HWY_DIST          = 41917.1,
  age               = 42,
  avno60plus        = factor(0, levels = c(0, 1), labels = c("No", "Yes")),
  structure_quality = factor(5, ordered = TRUE),
  month_sold        = factor(8, levels = 1:12, labels = month.abb, ordered = TRUE)
)

#Apply same numeric scaling as the preprocessing in Task 2.
new_num   <- predict(pp, newdata = new_house[, names(pp$mean)])   # pp from Task2
new_ready <- bind_cols(new_num, new_house %>% select(-names(pp$mean)))

#Add dummy column required by rf_fit 
new_ready$log_SALE_PRC <- 0    # placeholder; not used by any split

#Make prediction
pred_price <- predict(rf_fit, newdata = new_ready)   # rf_fit from Task3
round(pred_price, 0)

```
