# Pandas cơ bản

## DataFrame là gì?

**DataFrame** là cấu trúc dữ liệu chính trong pandas — một bảng hai chiều gồm các hàng (rows) và cột (columns), tương tự bảng tính Excel hoặc bảng trong SQL.

**Series** là một cột duy nhất trong DataFrame — mảng một chiều có nhãn (index).

```
DataFrame:
         name    age    city
  0      An      25     HN
  1      Bình    30     HCM
  2      Chi     28     ĐN

Series (cột "age"):
  0    25
  1    30
  2    28
  Name: age, dtype: int64
```

## Tạo DataFrame

### Từ dictionary

```python
import pandas as pd

# Cách 1: Dictionary of lists
data = {
    "name": ["An", "Bình", "Chi", "Dũng"],
    "age": [25, 30, 28, 35],
    "city": ["Hà Nội", "HCM", "Đà Nẵng", "Huế"],
    "salary": [15_000_000, 25_000_000, 20_000_000, 18_000_000]
}
df = pd.DataFrame(data)
print(df)
```

```
   name  age     city    salary
0    An   25   Hà Nội  15000000
1  Bình   30      HCM  25000000
2   Chi   28  Đà Nẵng  20000000
3  Dũng   35      Huế  18000000
```

### Từ list of dictionaries

```python
# Cách 2: List of dictionaries (mỗi dict = 1 dòng)
records = [
    {"name": "An", "age": 25, "city": "Hà Nội"},
    {"name": "Bình", "age": 30, "city": "HCM"},
    {"name": "Chi", "age": 28, "city": "Đà Nẵng"},
]
df = pd.DataFrame(records)
print(df)
```

### Từ NumPy array

```python
import numpy as np

# Cách 3: NumPy array + column names
arr = np.random.randn(5, 3)
df = pd.DataFrame(arr, columns=["A", "B", "C"])
print(df)
```

## Thuộc tính cơ bản của DataFrame

```python
import seaborn as sns

# Load dataset mẫu
tips = sns.load_dataset("tips")

# Kích thước: (số dòng, số cột)
print(tips.shape)          # (244, 7)

# Tên các cột
print(tips.columns)        # Index(['total_bill', 'tip', 'sex', ...])

# Kiểu dữ liệu từng cột
print(tips.dtypes)

# Số dòng
print(len(tips))           # 244

# Index (nhãn dòng)
print(tips.index)
```

## Xem nhanh dữ liệu

```python
# 5 dòng đầu tiên
tips.head()

# 5 dòng cuối cùng
tips.tail()

# n dòng đầu tiên
tips.head(10)

# Lấy ngẫu nhiên n dòng
tips.sample(5)
```

## Thông tin DataFrame

### `info()` — Cấu trúc tổng quan

```python
tips.info()
```

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 244 entries, 0 to 243
Data columns (total 7 columns):
 #   Column      Non-Null Count  Dtype   
---  ------      --------------  -----   
 0   total_bill  244 non-null    float64 
 1   tip         244 non-null    float64 
 2   sex         244 non-null    category
 3   smoker      244 non-null    category
 4   day         244 non-null    category
 5   time        244 non-null    category
 6   size        244 non-null    int64   
dtypes: category(4), float64(2), int64(1)
memory usage: 7.4 KB
```

### `describe()` — Thống kê mô tả

```python
# Thống kê cho cột số
tips.describe()

# Thống kê cho tất cả cột (bao gồm chuỗi và category)
tips.describe(include="all")
```

### `value_counts()` — Đếm giá trị

```python
# Đếm số lần xuất hiện của mỗi giá trị
tips["day"].value_counts()

# Tỷ lệ phần trăm
tips["day"].value_counts(normalize=True)
```

## Kiểu dữ liệu (Data Types)

### Các kiểu dữ liệu phổ biến trong pandas

| Kiểu pandas | Mô tả | Ví dụ |
|-------------|--------|-------|
| `int64` | Số nguyên | `1, 2, 100` |
| `float64` | Số thực | `3.14, 2.5` |
| `object` | Chuỗi ký tự (string) | `"Hà Nội"` |
| `bool` | Logic | `True, False` |
| `datetime64` | Ngày tháng | `2024-01-15` |
| `category` | Danh mục (tiết kiệm bộ nhớ) | `"Male", "Female"` |

### Chuyển đổi kiểu dữ liệu

```python
# Chuyển sang kiểu số
df["age"] = df["age"].astype(int)
df["salary"] = pd.to_numeric(df["salary"], errors="coerce")

# Chuyển sang chuỗi
df["zip_code"] = df["zip_code"].astype(str)

# Chuyển sang datetime
df["date"] = pd.to_datetime(df["date"], format="%Y-%m-%d")

# Chuyển sang category (tiết kiệm bộ nhớ cho cột có ít giá trị unique)
df["gender"] = df["gender"].astype("category")
```

## Xử lý giá trị thiếu (Missing Values)

### Kiểm tra missing values

```python
# Kiểm tra từng ô
tips.isnull()

# Đếm missing values mỗi cột
tips.isnull().sum()

# Tỷ lệ missing (%)
(tips.isnull().sum() / len(tips) * 100).round(2)

# Có missing value nào không?
tips.isnull().any().any()
```

### Xử lý missing values

```python
# Xóa dòng có missing
df_clean = df.dropna()

# Xóa dòng chỉ khi tất cả giá trị đều missing
df_clean = df.dropna(how="all")

# Xóa dòng có missing ở cột cụ thể
df_clean = df.dropna(subset=["age", "salary"])

# Thay thế missing bằng giá trị cụ thể
df["age"] = df["age"].fillna(0)

# Thay thế bằng trung bình
df["salary"] = df["salary"].fillna(df["salary"].mean())

# Thay thế bằng trung vị
df["salary"] = df["salary"].fillna(df["salary"].median())

# Forward fill (lấy giá trị dòng trước)
df["value"] = df["value"].ffill()

# Backward fill (lấy giá trị dòng sau)
df["value"] = df["value"].bfill()
```

## Truy cập dữ liệu

### Lấy cột (Series)

```python
# Cách 1: Dot notation (chỉ dùng khi tên cột không có space/ký tự đặc biệt)
tips.total_bill

# Cách 2: Bracket notation (khuyến khích)
tips["total_bill"]

# Nhiều cột → trả về DataFrame
tips[["total_bill", "tip", "day"]]
```

### Lấy dòng theo vị trí (`iloc`)

```python
# Dòng đầu tiên (index 0)
tips.iloc[0]

# Dòng 0 đến 4
tips.iloc[0:5]

# Dòng cuối
tips.iloc[-1]

# Dòng và cột cụ thể
tips.iloc[0:5, 0:3]    # 5 dòng đầu, 3 cột đầu
```

### Lấy dòng theo nhãn (`loc`)

```python
# Theo nhãn index
tips.loc[0]

# Theo nhãn index và tên cột
tips.loc[0:4, ["total_bill", "tip"]]

# Kết hợp điều kiện
tips.loc[tips["total_bill"] > 40, ["total_bill", "tip", "day"]]
```

### So sánh `loc` vs `iloc`

| Đặc điểm | `loc` | `iloc` |
|-----------|-------|--------|
| Truy cập bằng | Nhãn (label) | Vị trí (integer) |
| Phạm vi | Inclusive cả hai đầu | Exclusive đầu cuối |
| Ví dụ | `df.loc[0:4]` → 5 dòng | `df.iloc[0:4]` → 4 dòng |

## Sao chép DataFrame

```python
# Shallow copy (thay đổi ảnh hưởng đến bản gốc)
df2 = df

# Deep copy (bản sao độc lập)
df2 = df.copy()
```

::: {.callout-tip}
## Mẹo
Luôn dùng `.copy()` khi muốn tạo bản sao để xử lý mà không ảnh hưởng đến DataFrame gốc.
:::
