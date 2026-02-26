---
description: 'Viết bài giảng chuỗi thời gian với Python (statsmodels, pmdarima)'
---
# Viết bài giảng Time Series với Python

Viết nội dung bài giảng cho chapter **06-Timeseries** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Xử lý dữ liệu chuỗi thời gian
```python
import pandas as pd

# Tạo datetime index
df["date"] = pd.to_datetime(df["date"])
df = df.set_index("date")
df = df.asfreq("M")  # Monthly frequency

# Kiểm tra missing
df = df.ffill()  # Forward fill
```

### 2. Phân tích & Trực quan
```python
import matplotlib.pyplot as plt
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf

# Plot time series
fig, axes = plt.subplots(3, 1, figsize=(12, 10))
axes[0].plot(ts)
axes[0].set_title("Chuỗi thời gian gốc")
plot_acf(ts, ax=axes[1], lags=40)
plot_pacf(ts, ax=axes[2], lags=40)
plt.tight_layout()
plt.show()
```

### 3. Kiểm định tính dừng (Stationarity)
```python
from statsmodels.tsa.stattools import adfuller, kpss

# ADF test: H₀: chuỗi có unit root (non-stationary)
adf_result = adfuller(ts)
print(f"ADF Statistic: {adf_result[0]:.4f}")
print(f"p-value: {adf_result[1]:.4f}")

# KPSS test: H₀: chuỗi là stationary
kpss_result = kpss(ts, regression="c")
print(f"KPSS Statistic: {kpss_result[0]:.4f}")
print(f"p-value: {kpss_result[1]:.4f}")
```

### 4. STL Decomposition
```python
from statsmodels.tsa.seasonal import STL

stl = STL(ts, period=12)
result = stl.fit()
result.plot()
plt.show()
# Trend, Seasonal, Residual
```

### 5. ARIMA / SARIMA
$$\phi(B)(1-B)^d X_t = \theta(B)\epsilon_t$$

```python
from statsmodels.tsa.arima.model import ARIMA
import pmdarima as pm

# Auto ARIMA (tự chọn p, d, q)
auto_model = pm.auto_arima(
    ts, seasonal=True, m=12,
    stepwise=True, suppress_warnings=True,
    information_criterion="aic"
)
print(auto_model.summary())

# Manual ARIMA
model = ARIMA(ts, order=(1, 1, 1), seasonal_order=(1, 1, 1, 12))
result = model.fit()
print(result.summary())

# Forecast
forecast = result.forecast(steps=12)
```

### 6. Exponential Smoothing (Holt-Winters)
```python
from statsmodels.tsa.holtwinters import ExponentialSmoothing

# Triple Exponential Smoothing
hw_model = ExponentialSmoothing(
    ts, trend="add", seasonal="mul", seasonal_periods=12
).fit(optimized=True)

forecast = hw_model.forecast(12)

# Plot
fig, ax = plt.subplots(figsize=(12, 6))
ax.plot(ts, label="Observed")
ax.plot(hw_model.fittedvalues, label="Fitted", alpha=0.7)
ax.plot(forecast, label="Forecast", color="red")
ax.legend()
ax.set_title("Holt-Winters Forecast")
plt.show()
```

### 7. GARCH (biến động giá)
```python
from arch import arch_model

# Fit GARCH(1,1)
model = arch_model(returns, vol="Garch", p=1, q=1, dist="normal")
result = model.fit(disp="off")
print(result.summary())

# Conditional volatility
result.plot()
plt.show()
```

### 8. Đánh giá mô hình
```python
from sklearn.metrics import mean_squared_error, mean_absolute_error
import numpy as np

rmse = np.sqrt(mean_squared_error(y_test, y_pred))
mae = mean_absolute_error(y_test, y_pred)
mape = np.mean(np.abs((y_test - y_pred) / y_test)) * 100
print(f"RMSE: {rmse:.4f}")
print(f"MAE:  {mae:.4f}")
print(f"MAPE: {mape:.2f}%")
print(f"AIC:  {result.aic:.4f}")
print(f"BIC:  {result.bic:.4f}")
```

## Quy tắc
- Luôn plot dữ liệu trước → kiểm tra tính dừng → phân rã → mô hình hóa
- Giải thích ACF/PACF để chọn p, q
- Dataset: `statsmodels.datasets.co2`, `statsmodels.datasets.sunspots`, `yfinance` cho financial data
