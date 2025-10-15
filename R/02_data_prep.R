## 2. Data Preparation (Data Munging)

```{r}
#2.1. Install and load libraries needed for the data preparation.

# Install packages.
install.packages(c("janitor", "caret"))

library(janitor)     # clean_names(), duplicate handling
library(caret)       # preprocessing (scaling, centring, Box–Cox)


#2.2. Selecting the data.

#Removing the Latitude, Longitude, ParcelNo columns as irrelevant to the scope of the project and its goals.
housing_pre <- housing_data %>% 
  select(-c(LATITUDE, LONGITUDE, PARCELNO))


#2.3.Cleaning the data.
#Verifying the absence of missing values
stopifnot(sum(is.na(housing_pre)) == 0)   # Should be TRUE


#2.4. Construct data (feature engineering) - keeping both raw and log targets to better aim different models in the modelling phase.


housing_pre <- housing_pre %>%
  mutate(
    # 1. Create log‑transformed sale price (helps linear / SVR models)
    log_SALE_PRC = log10(SALE_PRC),

    # 2. Re‑encode integer codes as factors
    month_sold = factor(month_sold,
                        levels = 1:12,
                        labels = month.abb,
                        ordered = TRUE),
    avno60plus = factor(avno60plus, labels = c("No", "Yes")),
    structure_quality = factor(structure_quality, ordered = TRUE)
  )



#2.5. Integrate the dataset (formatting it for modelling).

#Identify numeric predictors
num_vars <- housing_pre %>% 
  select(where(is.numeric)) %>% 
  names()

# Drop both target columns from scaling list
num_vars <- setdiff(num_vars, c("SALE_PRC", "log_SALE_PRC"))

#Standardise (mean‑centre & unit‑variance) numeric columns
pp <- preProcess(housing_pre[, num_vars], method = c("center", "scale"))
housing_model <- bind_cols(
  predict(pp, housing_pre[, num_vars]),
  housing_pre %>% select(-all_of(num_vars)) #retain raw targets
)

#Final glimpse
glimpse(housing_model)


```
