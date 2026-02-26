---
applyTo: '06-Timeseries/**'
---
# Hướng dẫn Viết Nội dung Chuỗi Thời gian

## Tổng quan
Chapter 06 bao gồm các mô hình và phương pháp phân tích chuỗi thời gian. Nội dung hiện có các bài về ARIMA, Holt-Winters, GARCH, STL Decomposition và Multiple Time Series Forecast.

## Các Mô hình Chuỗi Thời gian:

### 1. ARIMA (AutoRegressive Integrated Moving Average):
$$
\phi(B)(1-B)^d X_t = \theta(B) \epsilon_t
$$
- **AR(p)**: AutoRegressive component
- **I(d)**: Differencing order
- **MA(q)**: Moving Average component
- **SARIMA**: Seasonal ARIMA

### 2. Holt-Winters (Exponential Smoothing):
- **Simple Exponential Smoothing**: Level only
- **Double (Holt's)**: Level + Trend
- **Triple (Holt-Winters)**: Level + Trend + Seasonality
  - Additive: $Y_t = L_t + T_t + S_t + \epsilon_t$
  - Multiplicative: $Y_t = L_t \times T_t \times S_t \times \epsilon_t$

### 3. STL Decomposition:
- **S**easonal and **T**rend decomposition using **L**oess
- Tách chuỗi thời gian thành: Trend + Seasonal + Remainder

### 4. GARCH (Generalized AutoRegressive Conditional Heteroskedasticity):
$$
\sigma_t^2 = \omega + \sum_{i=1}^{q} \alpha_i \epsilon_{t-i}^2 + \sum_{j=1}^{p} \beta_j \sigma_{t-j}^2
$$

## Quy tắc Code:

### Python (`statsmodels`, `pmdarima`):
```python
import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.arima.model import ARIMA
from statsmodels.tsa.holtwinters import ExponentialSmoothing
from statsmodels.tsa.seasonal import STL
import pmdarima as pm

# Load sample data
from statsmodels.datasets import co2
data = co2.load().data.resample("M").mean().ffill()

# Auto ARIMA (tương tự auto.arima trong R)
model = pm.auto_arima(data, seasonal=True, m=12)
print(model.summary())

# ARIMA thủ công
arima_model = ARIMA(data, order=(1, 1, 1))
arima_result = arima_model.fit()

# Forecast
forecast = arima_result.forecast(steps=12)
plt.figure(figsize=(10, 6))
plt.plot(data, label="Observed")
plt.plot(forecast, label="Forecast", color="red")
plt.legend()
plt.title("ARIMA Forecast")
plt.show()

# Holt-Winters
hw_model = ExponentialSmoothing(
    data, trend="add", seasonal="mul", seasonal_periods=12
).fit()
hw_forecast = hw_model.forecast(12)

# STL Decomposition
stl = STL(data, period=12)
result = stl.fit()
result.plot()
plt.show()
```

## Format Bài giảng:
1. **Lý thuyết**: Giải thích khái niệm và công thức bằng tiếng Việt
2. **Trực quan**: Luôn plot dữ liệu trước khi mô hình hóa
3. **Code**: Sử dụng Python (statsmodels, pmdarima, prophet)
4. **Đánh giá**: AIC, BIC, RMSE, MAE cho model comparison
5. **Dự báo**: Hiển thị forecast với confidence interval
