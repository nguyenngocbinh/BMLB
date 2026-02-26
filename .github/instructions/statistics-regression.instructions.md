---
applyTo: '04-Basic Statistics/**,05-Regression/**'
---
# Hướng dẫn Viết Nội dung Thống kê & Hồi quy

## Tổng quan
Các chapter 04 (Basic Statistics) và 05 (Regression) chứa nội dung thống kê cơ bản và mô hình hồi quy. Nội dung phải chính xác về mặt toán học và dễ hiểu cho sinh viên.

## Quy tắc Viết Công thức Toán

### KaTeX/LaTeX Notation:
- **Inline**: `$\mu$`, `$\sigma^2$`, `$\bar{x}$`
- **Block**:
```
$$
\bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i
$$
```

### Ký hiệu Thống kê Chuẩn:
| Ký hiệu | KaTeX | Ý nghĩa |
|----------|-------|---------|
| $\mu$ | `$\mu$` | Trung bình tổng thể |
| $\bar{x}$ | `$\bar{x}$` | Trung bình mẫu |
| $\sigma^2$ | `$\sigma^2$` | Phương sai tổng thể |
| $s^2$ | `$s^2$` | Phương sai mẫu |
| $\sigma$ | `$\sigma$` | Độ lệch chuẩn tổng thể |
| $\hat{\beta}$ | `$\hat{\beta}$` | Ước lượng hệ số hồi quy |
| $R^2$ | `$R^2$` | Hệ số xác định |
| $H_0$ | `$H_0$` | Giả thuyết không |
| $H_1$ | `$H_1$` | Giả thuyết đối |
| $p$ | `$p$` | Giá trị p-value |

## Nội dung Thống kê Cơ bản (Chapter 04):

### Các chủ đề cần bao phủ:
1. **Đo lường xu hướng trung tâm**: Mean, Median, Mode
2. **Đo lường độ phân tán**: Variance, Std Dev, IQR, Range, MAD
3. **Phân phối xác suất**: Normal, Binomial, Poisson, t-distribution
4. **Kiểm định giả thuyết**: t-test, chi-squared test, ANOVA
5. **Khoảng tin cậy**: Confidence Intervals
6. **Tương quan**: Pearson, Spearman correlation

### Format Trình bày:
```markdown
## Tên Khái niệm

### Định nghĩa
Mô tả khái niệm bằng tiếng Việt...

### Công thức
$$
\text{công thức toán}
$$

### Ví dụ với Python
` ` `python
# Python code example
` ` `

### Giải thích Kết quả
Phân tích output bằng tiếng Việt...
```

## Nội dung Hồi quy (Chapter 05):

### Các chủ đề cần bao phủ:
1. **Simple Linear Regression**: $y = \beta_0 + \beta_1 x + \epsilon$
2. **Multiple Linear Regression**: $y = X\beta + \epsilon$
3. **Logistic Regression**: $\log\frac{p}{1-p} = X\beta$
4. **Polynomial Regression**
5. **Regularization**: Ridge, Lasso, Elastic Net
6. **Model Evaluation**: $R^2$, Adjusted $R^2$, RMSE, MAE, AIC, BIC
7. **Survival Analysis**: Kaplan-Meier, Cox Regression

### Assumptions cần giải thích:
- Linearity
- Independence
- Homoscedasticity
- Normality of residuals
- No multicollinearity

## Quy tắc Code Example:

### Python:
```python
import statsmodels.api as sm
import pandas as pd
from sklearn.datasets import fetch_california_housing

# Load dataset
housing = fetch_california_housing(as_frame=True)
df = housing.frame

# Fit linear regression model
X = sm.add_constant(df[["AveRooms", "AveBedrms"]])
model = sm.OLS(df["MedHouseVal"], X).fit()
print(model.summary())

# Diagnostics
import matplotlib.pyplot as plt
fig, axes = plt.subplots(2, 2, figsize=(12, 8))
sm.graphics.plot_regress_exog(model, "AveRooms", fig=fig)
plt.tight_layout()
plt.show()
```
