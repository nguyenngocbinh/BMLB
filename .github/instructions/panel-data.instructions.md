---
applyTo: '07-Panel Data Models/**'
---
# Hướng dẫn Viết Nội dung Panel Data Models

## Tổng quan
Chapter 07 bao gồm các mô hình dữ liệu bảng (panel data) - dữ liệu kết hợp cả cross-sectional và time series dimensions.

## Các Mô hình Panel Data:

### 1. Pooled OLS:
$$
y_{it} = \alpha + X_{it}\beta + \epsilon_{it}
$$

### 2. Fixed Effects (FE):
$$
y_{it} = \alpha_i + X_{it}\beta + \epsilon_{it}
$$
- Within estimator
- Entity fixed effects & Time fixed effects

### 3. Random Effects (RE):
$$
y_{it} = \alpha + X_{it}\beta + u_i + \epsilon_{it}
$$
- GLS estimator

### 4. Hausman Test:
- $H_0$: Random Effects là phù hợp
- $H_1$: Fixed Effects là phù hợp

### 5. Các Mô hình Nâng cao:
- **Dynamic Panel**: GMM (Arellano-Bond, Blundell-Bond)
- **Panel VAR**
- **Panel Cointegration**

## Quy tắc Code:

### Python (`linearmodels`):
```python
import pandas as pd
import statsmodels.api as sm
from linearmodels.panel import PanelOLS, RandomEffects, PooledOLS
from linearmodels.panel import compare

# Load panel data (Grunfeld dataset)
from statsmodels.datasets import grunfeld
df = grunfeld.load_pandas().data
df = df.set_index(["firm", "year"])

# Pooled OLS
pooled = PooledOLS(df["invest"], sm.add_constant(df[["value", "capital"]]))
pooled_result = pooled.fit()
print(pooled_result.summary)

# Fixed Effects
fe_model = PanelOLS(
    df["invest"], df[["value", "capital"]], entity_effects=True
)
fe_result = fe_model.fit()
print(fe_result.summary)

# Random Effects
re_model = RandomEffects(df["invest"], sm.add_constant(df[["value", "capital"]]))
re_result = re_model.fit()
print(re_result.summary)

# So sánh mô hình
print(compare({"Pooled": pooled_result, "FE": fe_result, "RE": re_result}))
```

### Hausman Test với Python:
```python
# Hausman Test (so sánh FE và RE)
import numpy as np
from scipy import stats

b_fe = fe_result.params
b_re = re_result.params
common_cols = b_fe.index.intersection(b_re.index)

diff = b_fe[common_cols] - b_re[common_cols]
cov_diff = fe_result.cov[common_cols].loc[common_cols] - re_result.cov[common_cols].loc[common_cols]
hausman_stat = float(diff @ np.linalg.inv(cov_diff) @ diff)
p_value = 1 - stats.chi2.cdf(hausman_stat, df=len(common_cols))
print(f"Hausman statistic: {hausman_stat:.4f}, p-value: {p_value:.4f}")
```

## Datasets cho Panel Data:
- **Grunfeld**: Investment data (classic panel dataset)
- **Cigar**: Cigarette consumption
- **Crime**: Crime data
- **Wages**: Labor economics
