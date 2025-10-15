## 1. Data Description
## 1.1. Installing and loading of necessary libraries

```{r}
# Install packages for initial data description.
install.packages(c("tidyverse", "summarytools", "skimr", "GGally", "ggcorrplot", "scales", "ggplot2", "tidyverse"))


# Load necessary libraries
library(tidyverse)     # data manipulation and visualization
library(summarytools)  # descriptive statistics
library(skimr)         # detailed data summaries
library(ggplot2)
library(scales)        # for comma() formatting
library(ggcorrplot)    # to generate correlational heatmaps.

```

## 1.2. Loading of the Bolton Housing Prices Dataset from 2023.
```{r}

#PLEASE ENSURE YOU CHANGE THE DIRECT PATH WITH THE ONE YOU ARE USING WHEN TESTING THE CODE!!!

#Get the current working directory.
getwd()

#Setting a new working directory
setwd("C:\\Users\\bogoi\\Desktop\\(MSc.) AI\\DAT7303 - Data Mining and Machine Learning\\Assignments\\Portfolio 3\\")

#Double-check the working directory has been changed.
getwd()

#Read the Bolton Housing Prices Dataset from 2023
housing_data <- read.csv('Housing_Data_Same_Region.csv')


```

## 1.3. Examination of the data and its surface properties (Summary Statistics).
```{r}
# View the first 10 rows of the dataset.
head(housing_data, n=10)

#Examining the last 10 records from the dataset. 
tail(housing_data, n=10)

# Get structure of dataset
str(housing_data)

# Summary statistics
summary(housing_data)

# Detailed descriptive statistics using summarytools
view(dfSummary(housing_data))
```

## 1.4. Data Exploration (Preliminary Analysis)
```{r}
#Histogram to show Distribution of Target Variable (SALE_PRICE)

ggplot(housing_data, aes(x = SALE_PRC)) +
  geom_histogram(binwidth = 50000,            # 50‑k bins
                 fill = "steelblue",
                 colour = "black") +
  scale_x_continuous(
    breaks  = seq(0,
                  max(housing_data$SALE_PRC, na.rm = TRUE),
                  by = 250000),               # tick every 250‑k
    labels  = label_number(scale  = 1e-3,     # divide by 1 000
                           suffix = "k",
                           accuracy = 1)      # round to nearest k
  ) +
  labs(title = "Distribution of Sale Prices",
       x     = "Sale Price (USD, thousands)",
       y     = "Frequency") +
  theme_minimal()


#Boxplots to identify outliers

ggplot(housing_data, aes(y = SALE_PRC)) +
  geom_boxplot(fill = "lightblue") +
  scale_y_continuous(
    labels = label_number(scale  = 1e-3,
                          suffix = "k",
                          accuracy = 1)
  ) +
  labs(title = "Boxplot of Sale Prices",
       y     = "Sale Price (USD, thousands)") +
  theme_minimal()


#Generating a correlational heatmap to identify relationships between features.
#Selecting the numeric predictors. 
numeric_data <- housing_data %>%         
  select(
    SALE_PRC, LND_SQFOOT, TOT_LVG_AREA, SPEC_FEAT_VAL,
    RAIL_DIST, OCEAN_DIST, WATER_DIST,
    CNTR_DIST, SUBCNTR_DI, HWY_DIST,
    age, structure_quality
  )

#Create the correlation matrix 
corr_mat <- cor(numeric_data, use = "complete.obs")   

#Draw the heat‑map
ggcorrplot(
  corr_mat,
  method   = "square",
  type     = "lower",              # lower‑triangle only
  hc.order = TRUE,                 # cluster similar vars
  lab      = TRUE,                 # print r‑values
  colors   = c("firebrick", "white", "steelblue2"),
  lab_size = 3
) +
  labs(title = "Correlation Heatmap of Housing Features")

```
## 1.5. Verification of Data Quality.
```{r}
# Check the number of missing values per column
colSums(is.na(housing_data))

#Check for Duplicates by the unique occurances of the PARCEL Numbers.
housing_data %>%
  count(PARCELNO) %>%
  filter(n > 1)

#Check for unusual or out-of-range values.
summary(housing_data$age)
summary(housing_data$structure_quality)

#Visually check for potential anomalies.
housing_data %>%
  filter(age < 0 | structure_quality < 1 | structure_quality > 10)

```

