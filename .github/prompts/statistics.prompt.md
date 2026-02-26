---
description: 'Viết bài giảng thống kê cơ bản với Python (scipy, statsmodels)'
---
# Viết bài giảng Basic Statistics với Python

Viết nội dung bài giảng cho chapter **04-Basic Statistics** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Đặc trưng trung tâm (Central Tendency)
```python
import numpy as np
from scipy import stats

data = np.array([...])

mean_val = np.mean(data)             # Trung bình
median_val = np.median(data)         # Trung vị
mode_val = stats.mode(data).mode     # Mode
```

### 2. Đặc trưng phân tán (Dispersion)
```python
variance = np.var(data, ddof=1)      # Phương sai mẫu (s²)
std_dev = np.std(data, ddof=1)       # Độ lệch chuẩn mẫu (s)
mad = np.mean(np.abs(data - mean_val))  # MAD
iqr = np.percentile(data, 75) - np.percentile(data, 25)  # IQR
data_range = np.ptp(data)            # Range
cv = std_dev / mean_val              # Hệ số biến thiên
```

### 3. Đặc trưng dạng phân phối
```python
skewness = stats.skew(data)          # Hệ số bất đối xứng
kurtosis = stats.kurtosis(data)      # Hệ số nhọn
```

### 4. Phân phối xác suất
```python
from scipy.stats import norm, binom, poisson, t

# Normal distribution
x = np.linspace(-4, 4, 100)
y = norm.pdf(x, loc=0, scale=1)     # PDF
p = norm.cdf(1.96)                   # CDF: P(X ≤ 1.96)
z = norm.ppf(0.975)                  # Inverse CDF (quantile)

# Binomial
binom.pmf(k=3, n=10, p=0.5)

# Poisson
poisson.pmf(k=5, mu=3)

# t-distribution
t.ppf(0.975, df=29)
```

### 5. Ước lượng khoảng tin cậy (Confidence Interval)
```python
from scipy.stats import sem, t

n = len(data)
mean = np.mean(data)
se = sem(data)                       # Standard error
ci = t.interval(confidence=0.95, df=n-1, loc=mean, scale=se)
print(f"95% CI: ({ci[0]:.4f}, {ci[1]:.4f})")
```

### 6. Kiểm định giả thuyết (Hypothesis Testing)
```python
from scipy.stats import ttest_1samp, ttest_ind, ttest_rel
from scipy.stats import chi2_contingency, f_oneway, mannwhitneyu

# One-sample t-test: H₀: μ = μ₀
stat, p_value = ttest_1samp(data, popmean=50)

# Two-sample t-test: H₀: μ₁ = μ₂
stat, p_value = ttest_ind(group1, group2)

# Paired t-test
stat, p_value = ttest_rel(before, after)

# Chi-squared test of independence
chi2, p_value, dof, expected = chi2_contingency(contingency_table)

# One-way ANOVA: H₀: μ₁ = μ₂ = μ₃
stat, p_value = f_oneway(group1, group2, group3)

# Mann-Whitney U test (non-parametric)
stat, p_value = mannwhitneyu(group1, group2)
```

### 7. Kiểm định phân phối chuẩn
```python
from scipy.stats import shapiro, normaltest, kstest

# Shapiro-Wilk test
stat, p_value = shapiro(data)

# D'Agostino-Pearson test
stat, p_value = normaltest(data)

# Kolmogorov-Smirnov test
stat, p_value = kstest(data, "norm", args=(np.mean(data), np.std(data)))
```

### 8. Phân tích phương sai (ANOVA)
```python
from scipy.stats import f_oneway
import statsmodels.api as sm
from statsmodels.formula.api import ols

# One-way ANOVA
model = ols("value ~ C(group)", data=df).fit()
anova_table = sm.stats.anova_lm(model, typ=2)
print(anova_table)

# Post-hoc test (Tukey HSD)
from statsmodels.stats.multicomp import pairwise_tukeyhsd
tukey = pairwise_tukeyhsd(df["value"], df["group"], alpha=0.05)
print(tukey)
```

## Công thức KaTeX quan trọng
- Trung bình: $\bar{x} = \frac{1}{n}\sum_{i=1}^{n} x_i$
- Phương sai mẫu: $s^2 = \frac{1}{n-1}\sum_{i=1}^{n}(x_i - \bar{x})^2$
- Standard Error: $SE = \frac{s}{\sqrt{n}}$
- CI 95%: $\bar{x} \pm t_{\alpha/2, n-1} \cdot SE$
- t-statistic: $t = \frac{\bar{x} - \mu_0}{s / \sqrt{n}}$

## Quy tắc
- Mỗi khái niệm: Định nghĩa → Công thức KaTeX → Code Python → Giải thích kết quả
- Dataset: `scipy.stats` generators, `seaborn.load_dataset("tips")`
- Luôn giải thích p-value và cách diễn giải kết quả kiểm định bằng tiếng Việt
