# Biến đổi dữ liệu

## Chuẩn bị dữ liệu

Trong chương này, chúng ta sử dụng dataset `tips` từ thư viện **seaborn** để minh họa các thao tác biến đổi dữ liệu:

```python
import pandas as pd
import numpy as np
import seaborn as sns

# Load dataset
tips = sns.load_dataset("tips")
print(tips.head())
print(f"Shape: {tips.shape}")
```

```
   total_bill   tip     sex smoker  day    time  size
0       16.99  1.01  Female     No  Sun  Dinner     2
1       10.34  1.66    Male     No  Sun  Dinner     3
2       21.01  3.50    Male     No  Sun  Dinner     3
3       23.68  3.31    Male     No  Sun  Dinner     2
4       24.59  3.61  Female     No  Sun  Dinner     4
Shape: (244, 7)
```

## Chọn cột (Select)

Tương tự `dplyr::select()` trong R.

### Chọn cột theo tên

```python
# Chọn 1 cột → Series
tips["total_bill"]

# Chọn nhiều cột → DataFrame
tips[["total_bill", "tip", "day"]]
```

### Chọn cột với `filter()`

```python
# Chọn cột theo tên chứa chuỗi
tips.filter(like="ti")             # Cột chứa "ti": total_bill, tip, time

# Chọn cột theo regex
tips.filter(regex="^s")            # Cột bắt đầu bằng "s": sex, smoker, size

# Chọn cột theo danh sách
tips.filter(items=["total_bill", "tip", "day"])
```

### Loại bỏ cột

```python
# Loại bỏ 1 cột
tips.drop(columns="smoker")

# Loại bỏ nhiều cột
tips.drop(columns=["smoker", "time"])
```

### Chọn cột theo kiểu dữ liệu

```python
# Chỉ lấy cột số
tips.select_dtypes(include="number")

# Chỉ lấy cột category/object
tips.select_dtypes(include=["category", "object"])

# Loại bỏ cột số
tips.select_dtypes(exclude="number")
```

### Đổi tên cột

```python
# Đổi tên cụ thể
tips.rename(columns={
    "total_bill": "tong_hoa_don",
    "tip": "tien_tip",
    "size": "so_nguoi"
})

# Đổi tên tất cả cột (lowercase, thay space bằng _)
tips.rename(columns=str.lower)
tips.columns = tips.columns.str.lower().str.replace(" ", "_")
```

## Lọc dòng (Filter)

Tương tự `dplyr::filter()` trong R.

### Lọc với điều kiện đơn

```python
# Boolean indexing
tips[tips["total_bill"] > 30]

# Dùng query() — ngắn gọn hơn, giống SQL
tips.query("total_bill > 30")
```

### Lọc với nhiều điều kiện

```python
# AND: cả hai điều kiện đều đúng
tips[(tips["total_bill"] > 20) & (tips["tip"] > 3)]
tips.query("total_bill > 20 and tip > 3")

# OR: ít nhất một điều kiện đúng
tips[(tips["day"] == "Sat") | (tips["day"] == "Sun")]
tips.query("day == 'Sat' or day == 'Sun'")

# NOT: phủ định
tips[~(tips["smoker"] == "Yes")]
tips.query("smoker != 'Yes'")
```

### Lọc với `isin()`

```python
# Lọc dòng thuộc danh sách giá trị
weekend = ["Sat", "Sun"]
tips[tips["day"].isin(weekend)]
tips.query("day in @weekend")  # Dùng @ để tham chiếu biến bên ngoài

# Lọc dòng KHÔNG thuộc danh sách
tips[~tips["day"].isin(weekend)]
tips.query("day not in @weekend")
```

### Lọc với chuỗi

```python
# Cột chứa chuỗi
df[df["name"].str.contains("Nguyễn", na=False)]

# Cột bắt đầu/kết thúc bằng
df[df["name"].str.startswith("N")]
df[df["email"].str.endswith("@gmail.com")]
```

### Lọc với giá trị null

```python
# Dòng có missing value ở cột cụ thể
df[df["age"].isna()]

# Dòng KHÔNG có missing value
df[df["age"].notna()]
```

### Lọc theo vị trí

```python
# n dòng đầu
tips.head(10)

# n dòng cuối
tips.tail(10)

# Top n theo giá trị
tips.nlargest(5, "total_bill")     # 5 hóa đơn lớn nhất
tips.nsmallest(5, "total_bill")    # 5 hóa đơn nhỏ nhất
```

## Tạo/Sửa cột (Mutate)

Tương tự `dplyr::mutate()` trong R.

### Tạo cột mới

```python
# Cách 1: Gán trực tiếp
tips["tip_pct"] = tips["tip"] / tips["total_bill"] * 100

# Cách 2: Dùng assign() — hỗ trợ method chaining
tips = tips.assign(
    tip_pct=lambda x: x["tip"] / x["total_bill"] * 100,
    bill_per_person=lambda x: x["total_bill"] / x["size"]
)
```

### Tạo cột có điều kiện

```python
# Dùng np.where() — tương tự ifelse() trong R
tips["is_generous"] = np.where(tips["tip_pct"] > 15, "Yes", "No")

# Dùng np.select() — nhiều điều kiện
conditions = [
    tips["tip_pct"] >= 20,
    tips["tip_pct"] >= 15,
    tips["tip_pct"] >= 10,
]
choices = ["Rất hào phóng", "Hào phóng", "Bình thường"]
tips["tip_level"] = np.select(conditions, choices, default="Ít tip")

# Dùng .map() cho ánh xạ đơn giản
day_mapping = {"Sun": "Chủ nhật", "Sat": "Thứ 7", "Thur": "Thứ 5", "Fri": "Thứ 6"}
tips["day_vn"] = tips["day"].map(day_mapping)
```

### Tạo cột bằng `apply()`

```python
# Apply function lên từng dòng
def categorize_bill(row):
    """Categorize bill based on total and size."""
    per_person = row["total_bill"] / row["size"]
    if per_person > 15:
        return "Cao"
    elif per_person > 10:
        return "Trung bình"
    else:
        return "Thấp"

tips["bill_category"] = tips.apply(categorize_bill, axis=1)
```

::: {.callout-warning}
## Cảnh báo hiệu suất
`apply()` chậm hơn nhiều so với vectorized operations (`np.where`, `np.select`). Chỉ dùng `apply()` khi logic phức tạp không thể vectorize được.
:::

### Sửa giá trị cột

```python
# Thay thế giá trị
tips["smoker"] = tips["smoker"].replace({"Yes": "Có", "No": "Không"})

# Clip giá trị (giới hạn min/max)
tips["tip_clipped"] = tips["tip"].clip(lower=1, upper=10)

# Làm tròn
tips["tip_pct_rounded"] = tips["tip_pct"].round(1)
```

## Sắp xếp (Sort)

Tương tự `dplyr::arrange()` trong R.

```python
# Sắp xếp tăng dần
tips.sort_values("total_bill")

# Sắp xếp giảm dần
tips.sort_values("total_bill", ascending=False)

# Sắp xếp theo nhiều cột
tips.sort_values(["day", "total_bill"], ascending=[True, False])

# Sắp xếp theo index
tips.sort_index()
```

## Gom nhóm và Tổng hợp (Group By + Aggregate)

Tương tự `dplyr::group_by() + summarise()` trong R.

### Cơ bản

```python
# Gom nhóm + 1 hàm tổng hợp
tips.groupby("day")["total_bill"].mean()

# Gom nhóm + nhiều hàm
tips.groupby("day")["total_bill"].agg(["mean", "median", "std", "count"])
```

### Tổng hợp nhiều cột

```python
# Dùng agg() với named aggregation
result = (
    tips
    .groupby("day")
    .agg(
        avg_bill=("total_bill", "mean"),
        avg_tip=("tip", "mean"),
        total_revenue=("total_bill", "sum"),
        num_customers=("size", "sum"),
        num_bills=("total_bill", "count")
    )
    .reset_index()
    .sort_values("avg_bill", ascending=False)
)
print(result)
```

### Gom nhóm theo nhiều cột

```python
# Group by nhiều cột
tips.groupby(["day", "time"]).agg(
    avg_bill=("total_bill", "mean"),
    count=("total_bill", "count")
).reset_index()
```

### Hàm tổng hợp phổ biến

| Hàm | Mô tả |
|-----|-------|
| `"mean"` | Trung bình |
| `"median"` | Trung vị |
| `"sum"` | Tổng |
| `"count"` | Đếm (không tính NaN) |
| `"size"` | Đếm (tính cả NaN) |
| `"min"` | Giá trị nhỏ nhất |
| `"max"` | Giá trị lớn nhất |
| `"std"` | Độ lệch chuẩn |
| `"var"` | Phương sai |
| `"first"` | Giá trị đầu tiên |
| `"last"` | Giá trị cuối cùng |
| `"nunique"` | Số giá trị unique |

### Hàm tổng hợp tùy chỉnh

```python
# Dùng lambda
tips.groupby("day")["tip"].agg(
    tip_range=lambda x: x.max() - x.min(),
    tip_iqr=lambda x: x.quantile(0.75) - x.quantile(0.25)
)
```

### Transform — giữ nguyên shape

```python
# Tạo cột mới = giá trị trung bình của nhóm
tips["avg_bill_by_day"] = tips.groupby("day")["total_bill"].transform("mean")

# Tỷ lệ so với trung bình nhóm
tips["bill_vs_avg"] = tips["total_bill"] / tips.groupby("day")["total_bill"].transform("mean")
```

## Nối bảng (Join / Merge)

Tương tự `dplyr::left_join()`, `inner_join()` trong R.

### Tạo dữ liệu mẫu

```python
# Bảng khách hàng
customers = pd.DataFrame({
    "customer_id": [1, 2, 3, 4, 5],
    "name": ["An", "Bình", "Chi", "Dũng", "Em"],
    "city": ["HN", "HCM", "ĐN", "HN", "HCM"]
})

# Bảng đơn hàng
orders = pd.DataFrame({
    "order_id": [101, 102, 103, 104, 105],
    "customer_id": [1, 2, 2, 3, 6],
    "amount": [500, 300, 700, 200, 400]
})
```

### Các loại join

```python
# INNER JOIN — chỉ giữ dòng khớp ở cả 2 bảng
pd.merge(customers, orders, on="customer_id", how="inner")

# LEFT JOIN — giữ tất cả dòng bảng trái
pd.merge(customers, orders, on="customer_id", how="left")

# RIGHT JOIN — giữ tất cả dòng bảng phải
pd.merge(customers, orders, on="customer_id", how="right")

# FULL OUTER JOIN — giữ tất cả dòng cả 2 bảng
pd.merge(customers, orders, on="customer_id", how="outer")

# CROSS JOIN — tích Descartes
pd.merge(customers, orders, how="cross")
```

### Minh họa các loại join

```
customers:                   orders:
customer_id | name           order_id | customer_id | amount
1           | An             101      | 1           | 500
2           | Bình           102      | 2           | 300
3           | Chi            103      | 2           | 700
4           | Dũng           104      | 3           | 200
5           | Em             105      | 6           | 400

INNER JOIN:  customer_id 1, 2, 3 (có ở cả hai bảng)
LEFT JOIN:   customer_id 1, 2, 3, 4, 5 (tất cả bên trái)
RIGHT JOIN:  customer_id 1, 2, 3, 6 (tất cả bên phải)
OUTER JOIN:  customer_id 1, 2, 3, 4, 5, 6 (tất cả)
```

### Join với tên cột khác nhau

```python
# Khi tên cột khóa khác nhau
pd.merge(
    customers, orders,
    left_on="customer_id",
    right_on="cust_id",
    how="left"
)
```

### Join theo index

```python
# Join dựa trên index
pd.merge(df1, df2, left_index=True, right_index=True)

# Hoặc dùng join()
df1.join(df2, how="left")
```

## Ghép bảng (Concat)

Khác với `merge()` (nối ngang theo key), `concat()` ghép bảng theo chiều dọc hoặc ngang.

```python
# Ghép theo chiều dọc (xếp chồng) — tương tự UNION trong SQL
df_all = pd.concat([df_2023, df_2024], ignore_index=True)

# Ghép theo chiều ngang
df_combined = pd.concat([df_info, df_scores], axis=1)
```

## Loại bỏ trùng lặp (Distinct)

Tương tự `dplyr::distinct()` trong R.

```python
# Loại bỏ dòng trùng hoàn toàn
tips.drop_duplicates()

# Loại bỏ trùng theo cột cụ thể
tips.drop_duplicates(subset=["day", "time"])

# Giữ dòng cuối cùng (mặc định giữ dòng đầu)
tips.drop_duplicates(subset=["day", "time"], keep="last")

# Loại bỏ tất cả bản trùng (không giữ bản nào)
tips.drop_duplicates(subset=["day", "time"], keep=False)

# Đếm số giá trị unique
tips["day"].nunique()     # 4
tips["day"].unique()      # array(['Sun', 'Sat', 'Thur', 'Fri'])
```

## Window Functions

Tương tự window functions trong SQL.

```python
# Đánh số thứ tự trong nhóm
tips["rank_in_day"] = tips.groupby("day")["total_bill"].rank(ascending=False)

# Cumulative sum trong nhóm
tips["cumsum_bill"] = tips.groupby("day")["total_bill"].cumsum()

# Shift (lấy giá trị dòng trước/sau)
tips["prev_bill"] = tips.groupby("day")["total_bill"].shift(1)

# Rolling average
tips["rolling_avg"] = tips["total_bill"].rolling(window=5).mean()

# Percent change
tips["pct_change"] = tips["total_bill"].pct_change()
```

## Ví dụ tổng hợp: Pipeline hoàn chỉnh

```python
import pandas as pd
import seaborn as sns

# Load data
tips = sns.load_dataset("tips")

# Pipeline phân tích
result = (
    tips
    # Thêm cột tính toán
    .assign(
        tip_pct=lambda x: (x["tip"] / x["total_bill"] * 100).round(1),
        bill_per_person=lambda x: (x["total_bill"] / x["size"]).round(1),
        is_weekend=lambda x: x["day"].isin(["Sat", "Sun"])
    )
    # Lọc bữa tối
    .query("time == 'Dinner'")
    # Gom nhóm theo ngày
    .groupby(["day", "is_weekend"])
    .agg(
        avg_bill=("total_bill", "mean"),
        avg_tip_pct=("tip_pct", "mean"),
        avg_per_person=("bill_per_person", "mean"),
        num_tables=("total_bill", "count")
    )
    .reset_index()
    # Sắp xếp
    .sort_values("avg_tip_pct", ascending=False)
    # Làm tròn
    .round(2)
)

print(result)
```

::: {.callout-tip}
## Mẹo Method Chaining
- Bọc toàn bộ pipeline trong ngoặc `()` để viết trên nhiều dòng
- Mỗi bước xử lý trên một dòng riêng để dễ đọc
- Dùng `lambda` trong `assign()` để tham chiếu cột vừa tạo
- Đặt `reset_index()` sau `groupby().agg()` để chuyển kết quả thành DataFrame phẳng
:::
