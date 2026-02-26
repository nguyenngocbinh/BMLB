---
applyTo: '**/*.py,**/*.ipynb'
---
# Hướng dẫn Lập trình Python cho Dự án BMLB

## Tổng quan
Dự án BMLB sử dụng **Python** là ngôn ngữ lập trình duy nhất cho phân tích dữ liệu, thống kê và machine learning. Database sử dụng **MSSQL** (Microsoft SQL Server).

## Packages Cốt lõi

### Data Manipulation:
- **pandas**: Xử lý dữ liệu dạng bảng (DataFrame)
- **numpy**: Tính toán số học, mảng
- **polars**: Alternative cho pandas (high performance)

### Visualization:
- **matplotlib**: Biểu đồ cơ bản
- **seaborn**: Statistical visualization
- **plotly**: Interactive charts

### Statistics & ML:
- **scipy**: Phân tích thống kê
- **statsmodels**: Mô hình thống kê, econometrics
- **scikit-learn**: Machine Learning framework
- **xgboost**, **lightgbm**: Gradient boosting
- **tensorflow** / **pytorch**: Deep Learning

### Time Series:
- **statsmodels.tsa**: ARIMA, SARIMAX, Holt-Winters
- **prophet**: Facebook Prophet
- **pmdarima**: Auto ARIMA

### Database & Web:
- **pyodbc**: Kết nối MSSQL (SQL Server)
- **sqlalchemy**: ORM & database connection
- **beautifulsoup4**: Web scraping
- **requests**: HTTP requests
- **scrapy**: Web crawling framework

## Quy tắc Coding Style

### PEP 8 Convention:
```python
# Variables & functions: snake_case
my_data = pd.read_csv("data.csv")
def calculate_mean(values: list[float]) -> float:
    return np.mean(values)

# Constants: UPPER_SNAKE_CASE
MAX_ITERATIONS = 1000

# Classes: PascalCase
class DataProcessor:
    pass
```

### Type Hints:
```python
from typing import Optional
import pandas as pd

def load_data(filepath: str, encoding: str = "utf-8") -> pd.DataFrame:
    """Load data from CSV file.
    
    Args:
        filepath: Path to the CSV file.
        encoding: File encoding. Defaults to "utf-8".
    
    Returns:
        DataFrame containing the loaded data.
    """
    return pd.read_csv(filepath, encoding=encoding)
```

### Import Order (PEP 8):
```python
# 1. Standard library
import os
import sys
from datetime import datetime

# 2. Third-party packages
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 3. Local imports
from utils import helper_function
```

## Code Examples cho Bài giảng:

### Data Manipulation:
```python
import pandas as pd
import numpy as np

# Load dataset
df = pd.read_csv("data.csv")

# Basic operations
df_filtered = (
    df
    .query("year >= 2020")
    .groupby("category")
    .agg(
        mean_value=("value", "mean"),
        count=("value", "count")
    )
    .reset_index()
)
```

### Visualization:
```python
import matplotlib.pyplot as plt
import seaborn as sns

# Set Vietnamese-friendly font if available
plt.rcParams['font.family'] = 'DejaVu Sans'

# Create plot
fig, ax = plt.subplots(figsize=(10, 6))
sns.boxplot(data=iris, x="species", y="sepal_length", ax=ax)
ax.set_title("Phân phối Sepal Length theo Species")
ax.set_xlabel("Loài")
ax.set_ylabel("Chiều dài đài hoa (cm)")
plt.tight_layout()
plt.show()
```

## Quarto Python Code Cells:
```
{python}
#| label: data-exploration
#| echo: true
#| warning: false
import pandas as pd
df = pd.read_csv("data.csv")
df.describe()
```

## Datasets Phổ biến:
- `sklearn.datasets.load_iris()`: Classification
- `seaborn.load_dataset("tips")`: EDA
- `seaborn.load_dataset("titanic")`: Classification
- `statsmodels.datasets`: Statistical datasets
- `sklearn.datasets.fetch_california_housing()`: Regression
