---
description: 'Viết bài giảng xử lý dữ liệu với pandas/numpy trong Python'
---
# Viết bài giảng Data Manipulation với Python

Viết nội dung bài giảng cho chapter **02-Data Manipulation** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Import / Export dữ liệu
```python
import pandas as pd

# Import
df_csv = pd.read_csv("data.csv", encoding="utf-8")
df_excel = pd.read_excel("data.xlsx", sheet_name="Sheet1")
df_parquet = pd.read_parquet("data.parquet")
df_json = pd.read_json("data.json")

# Import từ MSSQL
import pyodbc
conn = pyodbc.connect("DRIVER={ODBC Driver 17 for SQL Server};SERVER=...;DATABASE=...;Trusted_Connection=yes;")
df_sql = pd.read_sql("SELECT * FROM table_name", conn)

# Export
df.to_csv("output.csv", index=False, encoding="utf-8-sig")
df.to_excel("output.xlsx", index=False)
df.to_parquet("output.parquet")
```

### 2. Khám phá dữ liệu (EDA cơ bản)
```python
df.shape          # Kích thước
df.dtypes         # Kiểu dữ liệu
df.info()         # Tổng quan
df.describe()     # Thống kê mô tả
df.head(10)       # 10 dòng đầu
df.isnull().sum() # Đếm missing values
df.nunique()      # Số giá trị unique
```

### 3. Chọn và lọc dữ liệu (tương đương select, filter)
```python
# Select columns
df[["col1", "col2"]]
df.loc[:, "col1":"col5"]

# Filter rows
df.query("year >= 2020 and category == 'A'")
df[df["value"] > 100]
df.loc[df["name"].str.contains("keyword")]
```

### 4. Biến đổi dữ liệu (tương đương mutate)
```python
df = df.assign(
    new_col=lambda x: x["col1"] + x["col2"],
    year=lambda x: pd.to_datetime(x["date"]).dt.year
)
```

### 5. Tổng hợp (tương đương summarise + group_by)
```python
df.groupby("category").agg(
    mean_value=("value", "mean"),
    total=("value", "sum"),
    count=("id", "count")
).reset_index()
```

### 6. Join / Merge
```python
pd.merge(df1, df2, on="key", how="left")    # LEFT JOIN
pd.merge(df1, df2, on="key", how="inner")   # INNER JOIN
pd.merge(df1, df2, on=["key1", "key2"])      # JOIN nhiều cột
```

### 7. Reshape (tương đương pivot_longer, pivot_wider)
```python
# Wide → Long (pivot_longer)
df.melt(id_vars=["id"], value_vars=["col1", "col2"], var_name="variable", value_name="value")

# Long → Wide (pivot_wider)
df.pivot_table(index="id", columns="variable", values="value")
```

### 8. Xử lý ngày tháng (tương đương lubridate)
```python
df["date"] = pd.to_datetime(df["date"])
df["year"] = df["date"].dt.year
df["month"] = df["date"].dt.month
df["weekday"] = df["date"].dt.day_name()
df["quarter"] = df["date"].dt.quarter
```

### 9. Xử lý chuỗi (tương đương stringr)
```python
df["name"] = df["name"].str.lower()
df["name"] = df["name"].str.strip()
df["name"] = df["name"].str.replace("old", "new")
df["first_word"] = df["name"].str.split(" ").str[0]
df[df["name"].str.contains("pattern", case=False)]
```

### 10. Method chaining (tương đương pipe)
```python
result = (
    df
    .query("year >= 2020")
    .assign(ratio=lambda x: x["value"] / x["total"])
    .groupby("category")
    .agg(mean_ratio=("ratio", "mean"))
    .reset_index()
    .sort_values("mean_ratio", ascending=False)
)
```

## Quy tắc
- Giải thích bằng tiếng Việt, code bằng Python
- Đối chiếu tương đương R (dplyr/tidyr) nếu người đọc đã biết R
- Sử dụng datasets: `seaborn.load_dataset("tips")`, `seaborn.load_dataset("penguins")`
