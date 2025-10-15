#3.5. Test Set evaluation.

eval_model <- function(name, fit, df, target_raw, log_based = FALSE) {
  preds <- predict(fit, newdata = df)
  if (log_based) preds <- 10^preds
  tibble(Model = name,
         RMSE  = rmse(df[[target_raw]], preds),
         MAE   = mae (df[[target_raw]], preds),
         R2    = R2  (preds, df[[target_raw]]))
}

results <- bind_rows(
  eval_model("Linear (log)"      , lm_fit      , test, "SALE_PRC", TRUE ),
  eval_model("SVR‑Linear (log)"  , svr_lin_fit , test, "SALE_PRC", TRUE ),
  eval_model("SVR‑Poly  (log)"   , svr_poly_fit, test, "SALE_PRC", TRUE ),
  eval_model("SVR‑RBF   (log)"   , svr_rbf_fit , test, "SALE_PRC", TRUE ),
  eval_model("Decision Tree"     , dt_fit      , test, "SALE_PRC", FALSE),
  eval_model("Random Forest"     , rf_fit      , test, "SALE_PRC", FALSE)
)
print(results)

```

```{r}

# 3.6.  RMSE BAR‑CHART

ggplot(results, aes(x = reorder(Model, RMSE), y = RMSE)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  geom_text(aes(label = round(RMSE, 0)), hjust = -0.1, size = 3) +
  labs(title = "Test Set RMSE by Model",
       x = NULL, y = "RMSE (USD)") +
  theme_minimal()
```

