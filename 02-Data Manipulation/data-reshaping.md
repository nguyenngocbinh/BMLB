# Reshape dữ liệu

## Tổng quan

Reshape (biến đổi hình dạng) dữ liệu là quá trình chuyển đổi giữa hai dạng:

- **Dạng rộng (wide format)**: Mỗi biến là một cột riêng
- **Dạng dài (long format)**: Mỗi quan sát là một dòng riêng

```
DẠNG RỘNG (Wide):                    DẠNG DÀI (Long):
name    | math | english | physics    name   | subject  | score
An      | 8.5  | 7.0     | 9.0       An     | math     | 8.5
Bình    | 9.0  | 8.5     | 7.5       An     | english  | 7.0
Chi     | 7.0  | 9.0     | 8.0       An     | physics  | 9.0
                                      Bình   | math     | 9.0
         ← melt() ←                  Bình   | english  | 8.5
         → pivot() →                 Bình   | physics  | 7.5
                                      Chi    | math     | 7.0
                                      ...
```

Tương tự `tidyr::pivot_longer()` và `tidyr::pivot_wider()` trong R.

## Chuẩn bị dữ liệu mẫu

```python
import pandas as pd
import numpy as np

# Dữ liệu dạng rộng — điểm thi của sinh viên
scores_wide = pd.DataFrame({
    "name": ["An", "Bình", "Chi", "Dũng"],
    "math": [8.5, 9.0, 7.0, 8.0],
    "english": [7.0, 8.5, 9.0, 6.5],
    "physics": [9.0, 7.5, 8.0, 8.5]
})

print("Dạng rộng:")
print(scores_wide)
```

```
Dạng rộng:
   name  math  english  physics
0    An   8.5      7.0      9.0
1  Bình   9.0      8.5      7.5
2   Chi   7.0      9.0      8.0
3  Dũng   8.0      6.5      8.5
```

## Rộng → Dài: `melt()`

Tương tự `tidyr::pivot_longer()` trong R.

### Cơ bản

```python
# Chuyển từ dạng rộng sang dạng dài
scores_long = scores_wide.melt(
    id_vars="name",            # Cột giữ nguyên (identifier)
    var_name="subject",        # Tên cột mới chứa tên biến
    value_name="score"         # Tên cột mới chứa giá trị
)

print("Dạng dài:")
print(scores_long)
```

```
Dạng dài:
    name  subject  score
0     An     math    8.5
1   Bình     math    9.0
2    Chi     math    7.0
3   Dũng     math    8.0
4     An  english    7.0
5   Bình  english    8.5
6    Chi  english    9.0
7   Dũng  english    6.5
8     An  physics    9.0
9   Bình  physics    7.5
10   Chi  physics    8.0
11  Dũng  physics    8.5
```

### Chỉ melt một số cột

```python
# Chỉ chuyển cột math và english
scores_wide.melt(
    id_vars="name",
    value_vars=["math", "english"],  # Chỉ melt các cột này
    var_name="subject",
    value_name="score"
)
```

## Dài → Rộng: `pivot()`

Tương tự `tidyr::pivot_wider()` trong R.

### Cơ bản

```python
# Chuyển từ dạng dài sang dạng rộng
scores_back = scores_long.pivot(
    index="name",        # Cột làm index (dòng)
    columns="subject",   # Cột tạo thành các cột mới
    values="score"       # Cột chứa giá trị
)

print(scores_back)
```

```
subject  english  math  physics
name                           
An           7.0   8.5      9.0
Bình         8.5   9.0      7.5
Chi          9.0   7.0      8.0
Dũng         6.5   8.0      8.5
```

### Xử lý sau pivot

```python
# Reset index và xóa tên cột level
scores_back = (
    scores_long
    .pivot(index="name", columns="subject", values="score")
    .reset_index()
    .rename_axis(None, axis=1)  # Xóa "subject" ở tên cột
)

print(scores_back)
```

## `pivot_table()` — Pivot với tổng hợp

Khi dữ liệu có nhiều dòng trùng key, `pivot()` sẽ báo lỗi. Dùng `pivot_table()` để tổng hợp:

```python
import seaborn as sns
tips = sns.load_dataset("tips")

# Pivot table — trung bình total_bill theo day và time
pivot = tips.pivot_table(
    index="day",             # Dòng
    columns="time",          # Cột
    values="total_bill",     # Giá trị
    aggfunc="mean"           # Hàm tổng hợp
)

print(pivot.round(2))
```

```
time    Dinner  Lunch
day                  
Fri      19.66  12.85
Sat      20.44    NaN
Sun      21.41    NaN
Thur     18.79  17.66
```

### Nhiều hàm tổng hợp

```python
# Nhiều aggregation functions
pivot = tips.pivot_table(
    index="day",
    columns="time",
    values="total_bill",
    aggfunc=["mean", "count", "sum"],
    margins=True,           # Thêm dòng/cột tổng
    margins_name="Tổng"
)

print(pivot.round(2))
```

### Nhiều cột giá trị

```python
# Pivot nhiều cột giá trị cùng lúc
pivot = tips.pivot_table(
    index="day",
    columns="smoker",
    values=["total_bill", "tip"],
    aggfunc="mean"
)

print(pivot.round(2))
```

## `stack()` và `unstack()`

Thao tác trên MultiIndex — di chuyển level giữa index và columns.

### `stack()` — Columns → Index (rộng → dài)

```python
# Tạo dữ liệu ví dụ
df = pd.DataFrame(
    {"Q1": [100, 200], "Q2": [150, 250], "Q3": [180, 220]},
    index=["HN", "HCM"]
)

print("Trước stack:")
print(df)

# Stack: chuyển columns vào index
stacked = df.stack()
print("\nSau stack:")
print(stacked)
```

```
Trước stack:
      Q1   Q2   Q3
HN   100  150  180
HCM  200  250  220

Sau stack:
HN   Q1    100
     Q2    150
     Q3    180
HCM  Q1    200
     Q2    250
     Q3    220
dtype: int64
```

### `unstack()` — Index → Columns (dài → rộng)

```python
# Unstack: ngược lại của stack
unstacked = stacked.unstack()
print("Sau unstack:")
print(unstacked)
```

## `crosstab()` — Bảng chéo

Tạo bảng tần suất chéo giữa hai biến categorical:

```python
# Bảng đếm tần suất
ct = pd.crosstab(tips["day"], tips["smoker"])
print(ct)

# Bảng tỷ lệ (%)
ct_pct = pd.crosstab(tips["day"], tips["smoker"], normalize="index") * 100
print(ct_pct.round(1))

# Bảng với tổng hợp giá trị
ct_agg = pd.crosstab(
    tips["day"], tips["smoker"],
    values=tips["total_bill"],
    aggfunc="mean"
)
print(ct_agg.round(2))
```

## `explode()` — Tách list thành dòng

Khi một ô chứa list, `explode()` tách mỗi phần tử thành một dòng riêng:

```python
df = pd.DataFrame({
    "student": ["An", "Bình"],
    "courses": [["Math", "CS", "Physics"], ["Math", "English"]]
})

print("Trước explode:")
print(df)

print("\nSau explode:")
print(df.explode("courses"))
```

```
Trước explode:
  student              courses
0      An  [Math, CS, Physics]
1    Bình       [Math, English]

Sau explode:
  student  courses
0      An     Math
0      An       CS
0      An  Physics
1    Bình     Math
1    Bình  English
```

## Ví dụ thực tế: Báo cáo doanh thu

```python
import pandas as pd
import numpy as np

# Dữ liệu doanh thu theo tháng
np.random.seed(42)
sales = pd.DataFrame({
    "region": np.repeat(["Bắc", "Trung", "Nam"], 12),
    "month": list(range(1, 13)) * 3,
    "revenue": np.random.randint(100, 500, 36) * 1_000_000,
    "cost": np.random.randint(50, 300, 36) * 1_000_000
})

# Tạo bảng tóm tắt: doanh thu trung bình theo quý và vùng
sales["quarter"] = "Q" + ((sales["month"] - 1) // 3 + 1).astype(str)

summary = (
    sales
    .pivot_table(
        index="region",
        columns="quarter",
        values="revenue",
        aggfunc="sum"
    )
    .assign(total=lambda x: x.sum(axis=1))
    .sort_values("total", ascending=False)
)

print("Bảng doanh thu theo quý (đơn vị: triệu VNĐ):")
print((summary / 1_000_000).round(0))
```

::: {.callout-tip}
## Khi nào dùng dạng nào?

- **Dạng dài (long)**: Phù hợp cho phân tích thống kê, vẽ biểu đồ (seaborn/plotly), lưu vào database
- **Dạng rộng (wide)**: Phù hợp cho báo cáo, pivot table, hiển thị cho người đọc
- **Quy tắc chung**: Phân tích → dạng dài, Trình bày → dạng rộng
:::
