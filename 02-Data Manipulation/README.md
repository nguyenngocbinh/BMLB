# Xử lý dữ liệu với Python

## Tổng quan

Xử lý dữ liệu (Data Manipulation) là bước quan trọng nhất trong quy trình phân tích dữ liệu. Chương này giới thiệu các công cụ và kỹ thuật xử lý dữ liệu bằng **Python**, tập trung vào thư viện **pandas** — công cụ mạnh mẽ nhất cho việc thao tác dữ liệu dạng bảng.

### Nội dung chương

| Chủ đề | Mô tả |
|--------|-------|
| [Pandas cơ bản](pandas-basics.md) | Tạo DataFrame, các thuộc tính và phương thức cơ bản |
| [Đọc/Ghi dữ liệu](data-io.md) | Import/Export dữ liệu từ CSV, Excel, JSON, Parquet, SQL |
| [Biến đổi dữ liệu](data-transformation.md) | Chọn cột, lọc dòng, tạo cột mới, gom nhóm, nối bảng |
| [Reshape dữ liệu](data-reshaping.md) | Chuyển đổi giữa dạng rộng và dạng dài (pivot, melt) |
| [Chuỗi và Thời gian](string-datetime.md) | Xử lý chuỗi ký tự và dữ liệu ngày tháng |

### Thư viện cần thiết

```python
import numpy as np
import pandas as pd
```

### So sánh nhanh: R (dplyr/tidyr) vs Python (pandas)

Nếu bạn đã quen với R, bảng dưới đây giúp bạn ánh xạ nhanh các thao tác tương đương:

| Thao tác | R (dplyr/tidyr) | Python (pandas) |
|----------|-----------------|-----------------|
| Chọn cột | `select()` | `df[["col1", "col2"]]` hoặc `df.filter()` |
| Lọc dòng | `filter()` | `df.query()` hoặc `df[df["col"] > x]` |
| Tạo/sửa cột | `mutate()` | `df.assign()` hoặc `df["col"] = ...` |
| Gom nhóm | `group_by() + summarise()` | `df.groupby().agg()` |
| Sắp xếp | `arrange()` | `df.sort_values()` |
| Nối bảng | `left_join()`, `inner_join()` | `pd.merge()` hoặc `df.merge()` |
| Loại trùng | `distinct()` | `df.drop_duplicates()` |
| Pivot dài → rộng | `pivot_wider()` | `df.pivot()` hoặc `df.pivot_table()` |
| Pivot rộng → dài | `pivot_longer()` | `pd.melt()` hoặc `df.melt()` |
| Xử lý chuỗi | `stringr::str_*()` | `df["col"].str.*` |
| Xử lý ngày | `lubridate::ymd()` | `pd.to_datetime()` |
| Pipe chaining | `%>%` hoặc `|>` | Method chaining với `.` |

### Method Chaining trong pandas

Một trong những kỹ thuật quan trọng nhất trong pandas là **method chaining** — nối các phương thức liên tiếp để tạo pipeline xử lý dữ liệu rõ ràng và dễ đọc:

```python
import pandas as pd
import seaborn as sns

# Load dataset
tips = sns.load_dataset("tips")

# Method chaining - tương tự pipe %>% trong R
result = (
    tips
    .query("total_bill > 10")              # Filter rows
    .assign(tip_pct=lambda x: x["tip"] / x["total_bill"] * 100)  # Add column
    .groupby("day")                         # Group by
    .agg(
        avg_tip_pct=("tip_pct", "mean"),    # Aggregate
        count=("tip_pct", "size")
    )
    .reset_index()                          # Reset index
    .sort_values("avg_tip_pct", ascending=False)  # Sort
)

print(result)
```

### Tài liệu tham khảo

- [Pandas User Guide](https://pandas.pydata.org/docs/user_guide/index.html)
- [Pandas Cheat Sheet](https://pandas.pydata.org/Pandas_Cheat_Sheet.pdf)
- [NumPy Documentation](https://numpy.org/doc/stable/)
- [Python for Data Analysis - Wes McKinney](https://wesmckinney.com/book/)

