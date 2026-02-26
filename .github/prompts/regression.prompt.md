---
description: 'Viết bài giảng mô hình hồi quy với Python (statsmodels, scikit-learn)'
---
# Viết bài giảng Regression với Python

Viết nội dung bài giảng cho chapter **05-Regression** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Simple Linear Regression (OLS)
$$y = \beta_0 + \beta_1 x + \epsilon$$

```python
import statsmodels.api as sm

X = sm.add_constant(df["x"])
model = sm.OLS(df["y"], X).fit()
print(model.summary())

# Hệ số
print(f"Intercept: {model.params[0]:.4f}")
print(f"Slope: {model.params[1]:.4f}")
print(f"R²: {model.rsquared:.4f}")
print(f"Adj R²: {model.rsquared_adj:.4f}")
```

### 2. Multiple Linear Regression
$$y = X\beta + \epsilon$$

```python
X = sm.add_constant(df[["x1", "x2", "x3"]])
model = sm.OLS(df["y"], X).fit()
print(model.summary())
```

### 3. Logistic Regression (Logit)
$$\log\frac{p}{1-p} = X\beta$$

```python
# statsmodels
model = sm.Logit(df["y"], sm.add_constant(df[["x1", "x2"]])).fit()
print(model.summary())

# scikit-learn
from sklearn.linear_model import LogisticRegression
clf = LogisticRegression(max_iter=1000)
clf.fit(X_train, y_train)
```

### 4. Probit
```python
model = sm.Probit(df["y"], sm.add_constant(df[["x1", "x2"]])).fit()
print(model.summary())
```

### 5. Regularization (Ridge, Lasso, Elastic Net)
```python
from sklearn.linear_model import Ridge, Lasso, ElasticNet
from sklearn.model_selection import cross_val_score

# Ridge (L2)
ridge = Ridge(alpha=1.0)
scores = cross_val_score(ridge, X, y, cv=5, scoring="r2")

# Lasso (L1)
lasso = Lasso(alpha=0.1)
lasso.fit(X_train, y_train)
print(f"Features selected: {sum(lasso.coef_ != 0)}")

# Elastic Net (L1 + L2)
enet = ElasticNet(alpha=0.1, l1_ratio=0.5)
```

### 6. Diagnostics (Kiểm tra giả định)
```python
import matplotlib.pyplot as plt
from statsmodels.stats.diagnostic import het_breuschpagan
from statsmodels.stats.stattools import durbin_watson
from statsmodels.stats.outliers_influence import variance_inflation_factor

# Residual plot
residuals = model.resid
fitted = model.fittedvalues
fig, axes = plt.subplots(2, 2, figsize=(12, 8))

# 1. Residuals vs Fitted
axes[0,0].scatter(fitted, residuals, alpha=0.5)
axes[0,0].axhline(0, color="red", linestyle="--")
axes[0,0].set_title("Residuals vs Fitted")

# 2. Q-Q Plot
sm.qqplot(residuals, line="45", ax=axes[0,1])

# 3. Histogram of residuals
axes[1,0].hist(residuals, bins=30, edgecolor="black")
axes[1,0].set_title("Phân phối Residuals")

plt.tight_layout()
plt.show()

# Breusch-Pagan test (heteroscedasticity)
bp_stat, bp_pvalue, _, _ = het_breuschpagan(residuals, model.model.exog)

# Durbin-Watson (autocorrelation)
dw = durbin_watson(residuals)

# VIF (multicollinearity)
vif_data = pd.DataFrame({
    "Variable": X.columns,
    "VIF": [variance_inflation_factor(X.values, i) for i in range(X.shape[1])]
})
```

### 7. Model Evaluation
```python
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

y_pred = model.predict(X_test)
print(f"RMSE: {mean_squared_error(y_test, y_pred, squared=False):.4f}")
print(f"MAE:  {mean_absolute_error(y_test, y_pred):.4f}")
print(f"R²:   {r2_score(y_test, y_pred):.4f}")
print(f"AIC:  {model.aic:.4f}")
print(f"BIC:  {model.bic:.4f}")
```

## Quy tắc
- Luôn kiểm tra assumptions sau khi fit model
- Giải thích coefficients, p-value, R² bằng tiếng Việt
- Dataset: `sklearn.datasets.fetch_california_housing()`, `statsmodels.datasets`
