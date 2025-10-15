##3. Modelling Phase:
```{r}
#3.1 Installing and loading of neccessary packages for model training.

# Install packages.
install.packages(c("e1071", "randomForest", "rpart","Metrics"))
#install.packages("randomForest") 
install.packages("caret", dependencies = TRUE)
install.packages("doParallel", dependencies = TRUE)
install.packages("LiblineaR")


#Loading of libraries
library(e1071)           # SVM back‑end
library(randomForest)
library(rpart)
library(Metrics)         # rmse, mae
library(doParallel)
library(LiblineaR)
```

```{r}
#3.2. Data Split. The "housing_model" already contains both the raw target and the log transformed one.
#The train-test split is set to 80/20

set.seed(42)
idx   <- createDataPartition(housing_model$SALE_PRC, p = 0.80, list = FALSE)
train <- housing_model[idx,  ]
test  <- housing_model[-idx, ]

#Parallel backend (uses all except one core)

cores <- parallel::detectCores() - 1
cl <- makePSOCKcluster(cores)
registerDoParallel(cl)

#Common re-sampling + verbosity
ctrl <- trainControl(
  method      = "cv",
  number      = 5,          # reduce folds from 10 to 5  (reduces run time by 50%)
  verboseIter = TRUE,
  allowParallel = TRUE
)
```

```{r}
# 3.3. Model Training
#?train
# 3.3.1. Multiple Linear Regression (log target).

system.time(
  lm_fit <- train(
    log_SALE_PRC ~ . -SALE_PRC, data = train,
    method = "lm",
    trControl = ctrl)
)
```

```{r}
# 3.3.2. SVR – linear with fast linear back end to speed up training process

lin_grid <- expand.grid(cost = c(0.25, 1, 4, 16))   # 4 C values
system.time(
  svr_lin_fit <- train(
    log_SALE_PRC ~ . -SALE_PRC, data = train,
    method    = "svmLinear2",   # Liblinear
    tuneGrid  = lin_grid,
    trControl = ctrl)
)
```

```{r}
# 3.3.3.  SVR – polynomial kernel
poly_grid <- expand.grid(degree = 2:3, scale = 0.01, C = 2^(0:4))
system.time(
  svr_poly_fit <- train(
    log_SALE_PRC ~ . -SALE_PRC, data = train,
    method    = "svmPoly",
    tuneGrid  = poly_grid,
    trControl = ctrl)
)
```

```{r}
# 3.3.4  SVR – radial (RBF) kernel
system.time(
  svr_rbf_fit <- train(
    log_SALE_PRC ~ . -SALE_PRC, data = train,
    method      = "svmRadial",
    tuneLength  = 8,            # default 10 changed to  8 to reduce run time
    trControl   = ctrl)
)
```

```{r}
# 3.3.5  Decision Tree (raw target)
system.time(
  dt_fit <- train(
    SALE_PRC ~ . -log_SALE_PRC, data = train,
    method      = "rpart",
    tuneLength  = 20,
    trControl   = ctrl)
)
```

```{r}
# 3.3.6  Random Forest (raw target) with live tree count
system.time(
  rf_fit <- train(
    SALE_PRC ~ . -log_SALE_PRC, data = train,
    method    = "rf",
    ntree     = 500,
    do.trace  = 50,        # prints progress every 50 trees
    trControl = ctrl)
)
```

```{r}
# 3.4. Stopping of parallel clustering.
stopCluster(cl)
registerDoSEQ()
```

