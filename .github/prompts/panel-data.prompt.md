---
description: 'Viết bài giảng mô hình dữ liệu bảng với Python (linearmodels)'
---
# Viết bài giảng Panel Data Models với Python

Viết nội dung bài giảng cho chapter **07-Panel Data Models** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Cấu trúc dữ liệu Panel
```python
import pandas as pd

# Panel data cần multi-index: (entity, time)
df = df.set_index(["firm_id", "year"])

# Kiểm tra balanced/unbalanced panel
panel_counts = df.groupby(level=0).size()
is_balanced = panel_counts.nunique() == 1
print(f"Balanced panel: {is_balanced}")
print(f"N entities: {df.index.get_level_values(0).nunique()}")
print(f"T periods: {df.index.get_level_values(1).nunique()}")
```

### 2. Pooled OLS
$$y_{it} = \alpha + X_{it}\beta + \epsilon_{it}$$

```python
import statsmodels.api as sm
from linearmodels.panel import PooledOLS

model = PooledOLS(df["y"], sm.add_constant(df[["x1", "x2"]]))
result = model.fit(cov_type="clustered", cluster_entity=True)
print(result.summary)
```

### 3. Fixed Effects (FE)
$$y_{it} = \alpha_i + X_{it}\beta + \epsilon_{it}$$

```python
from linearmodels.panel import PanelOLS

# Entity fixed effects
fe_model = PanelOLS(df["y"], df[["x1", "x2"]], entity_effects=True)
fe_result = fe_model.fit(cov_type="clustered", cluster_entity=True)
print(fe_result.summary)

# Entity + Time fixed effects
fe_tw = PanelOLS(df["y"], df[["x1", "x2"]],
                 entity_effects=True, time_effects=True)
fe_tw_result = fe_tw.fit()
```

### 4. Random Effects (RE)
$$y_{it} = \alpha + X_{it}\beta + u_i + \epsilon_{it}$$

```python
from linearmodels.panel import RandomEffects

re_model = RandomEffects(df["y"], sm.add_constant(df[["x1", "x2"]]))
re_result = re_model.fit()
print(re_result.summary)
```

### 5. Hausman Test (FE vs RE)
```python
import numpy as np
from scipy.stats import chi2

b_fe = fe_result.params
b_re = re_result.params
common = b_fe.index.intersection(b_re.index)

diff = b_fe[common] - b_re[common]
cov_diff = fe_result.cov[common].loc[common] - re_result.cov[common].loc[common]
stat = float(diff @ np.linalg.inv(cov_diff) @ diff)
p_val = 1 - chi2.cdf(stat, df=len(common))
print(f"Hausman stat: {stat:.4f}, p-value: {p_val:.4f}")
# p < 0.05 → dùng Fixed Effects
```

### 6. So sánh mô hình
```python
from linearmodels.panel import compare

comparison = compare(
    {"Pooled": pooled_result, "FE": fe_result, "RE": re_result}
)
print(comparison)
```

### 7. Dynamic Panel (GMM) - Nâng cao
```python
# Arellano-Bond GMM estimator
# Thường dùng khi có lagged dependent variable
# y_{it} = ρ*y_{i,t-1} + X_{it}β + α_i + ε_{it}
```

## Công thức KaTeX
- Pooled OLS: $y_{it} = \alpha + X_{it}\beta + \epsilon_{it}$
- Fixed Effects: $y_{it} = \alpha_i + X_{it}\beta + \epsilon_{it}$
- Random Effects: $y_{it} = \alpha + X_{it}\beta + u_i + \epsilon_{it}$
- Hausman: $H = (\hat{\beta}_{FE} - \hat{\beta}_{RE})^T [Var(\hat{\beta}_{FE}) - Var(\hat{\beta}_{RE})]^{-1} (\hat{\beta}_{FE} - \hat{\beta}_{RE}) \sim \chi^2(k)$

## Quy tắc
- Luôn so sánh Pooled vs FE vs RE
- Dùng Hausman test để chọn FE hay RE
- Dataset: `statsmodels.datasets.grunfeld`
- Packages: `linearmodels`, `statsmodels`
