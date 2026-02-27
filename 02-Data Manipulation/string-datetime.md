# Xử lý Chuỗi và Thời gian

## Phần 1: Xử lý Chuỗi (String)

Pandas cung cấp accessor `.str` để thao tác trên cột chuỗi — tương tự thư viện `stringr` trong R.

### Chuẩn bị dữ liệu

```python
import pandas as pd
import numpy as np

df = pd.DataFrame({
    "name": ["  Nguyễn Văn An  ", "trần thị bình", "LÊ VĂN CHI", "Phạm Dũng"],
    "email": ["an@gmail.com", "binh@YAHOO.COM", "chi@outlook.com", None],
    "phone": ["0912-345-678", "0987.654.321", "0365 123 456", "0901234567"],
    "address": ["123 Láng Hạ, Ba Đình, Hà Nội", "456 Nguyễn Huệ, Q1, HCM",
                "78 Bạch Đằng, Hải Châu, Đà Nẵng", "90 Lê Lợi, Huế"]
})
```

### Chuyển đổi chữ hoa/thường

```python
# Viết thường
df["name"].str.lower()
# 0      nguyễn văn an  
# 1        trần thị bình
# 2          lê văn chi
# 3           phạm dũng

# Viết hoa
df["name"].str.upper()

# Viết hoa chữ cái đầu mỗi từ (Title Case)
df["name"].str.title()
# 0    Nguyễn Văn An
# 1    Trần Thị Bình
# 2      Lê Văn Chi
# 3       Phạm Dũng

# Viết hoa chữ đầu câu
df["name"].str.capitalize()
```

### Cắt khoảng trắng (Strip)

```python
# Cắt khoảng trắng hai đầu
df["name"].str.strip()

# Cắt khoảng trắng bên trái/phải
df["name"].str.lstrip()
df["name"].str.rstrip()

# Cắt ký tự cụ thể
s = pd.Series(["###hello###", "---world---"])
s.str.strip("#-")
```

### Tìm kiếm và Kiểm tra

```python
# Chứa chuỗi con (trả về True/False)
df["name"].str.contains("Văn", na=False)

# Chứa chuỗi con — không phân biệt hoa/thường
df["name"].str.contains("văn", case=False, na=False)

# Bắt đầu / kết thúc bằng
df["email"].str.startswith("an", na=False)
df["email"].str.endswith("gmail.com", na=False)

# Tìm vị trí chuỗi con
df["address"].str.find("Hà Nội")  # Trả về index, -1 nếu không tìm thấy

# Đếm số lần xuất hiện
df["address"].str.count(",")
```

### Thay thế (Replace)

```python
# Thay thế chuỗi đơn giản
df["phone"].str.replace("-", "").str.replace(".", "").str.replace(" ", "")

# Thay thế bằng regex
df["phone_clean"] = df["phone"].str.replace(r"[^0-9]", "", regex=True)
# 0    0912345678
# 1    0987654321
# 2    0365123456
# 3    0901234567
```

### Tách chuỗi (Split)

```python
# Tách thành list
df["address"].str.split(",")
# 0    [123 Láng Hạ,  Ba Đình,  Hà Nội]
# 1      [456 Nguyễn Huệ,  Q1,  HCM]

# Tách thành các cột riêng
address_parts = df["address"].str.split(",", expand=True)
address_parts.columns = ["street", "district", "city"]
print(address_parts)

# Lấy phần tử cụ thể sau khi tách
df["city"] = df["address"].str.split(",").str[-1].str.strip()
```

### Nối chuỗi (Concatenate)

```python
# Nối 2 cột
df["full_info"] = df["name"].str.strip() + " - " + df["email"].fillna("")

# Dùng str.cat()
df["name"].str.strip().str.cat(df["phone"], sep=" | ")
```

### Trích xuất (Extract) với Regex

```python
# Trích xuất số từ chuỗi
s = pd.Series(["Giá: 150,000 VNĐ", "Giá: 2,500,000 VNĐ", "Miễn phí"])
s.str.extract(r"(\d[\d,]*)")

# Trích xuất nhiều nhóm
emails = pd.Series(["an@gmail.com", "binh@yahoo.com"])
extracted = emails.str.extract(r"(\w+)@(\w+)\.(\w+)")
extracted.columns = ["username", "domain", "tld"]
print(extracted)
```

```
  username  domain  tld
0       an   gmail  com
1     binh   yahoo  com
```

### Đệm chuỗi (Padding)

```python
# Đệm bên trái (hữu ích cho mã số)
s = pd.Series([1, 23, 456])
s.astype(str).str.zfill(5)    # 00001, 00023, 00456
s.astype(str).str.pad(5, fillchar="0")  # Tương tự

# Đệm bên phải
s.astype(str).str.pad(5, side="right", fillchar="0")
```

### Độ dài chuỗi

```python
# Đếm số ký tự
df["name"].str.len()

# Đếm số từ
df["name"].str.split().str.len()
```

### Slice chuỗi

```python
# Lấy n ký tự đầu
df["name"].str[:5]

# Lấy n ký tự cuối
df["name"].str[-3:]

# Lấy từ vị trí 2 đến 6
df["name"].str[2:7]
```

## Phần 2: Xử lý Ngày tháng (Datetime)

Pandas cung cấp kiểu dữ liệu `datetime64` và accessor `.dt` — tương tự thư viện `lubridate` trong R.

### Tạo dữ liệu datetime

```python
import pandas as pd
from datetime import datetime, timedelta

# Tạo từ chuỗi
dates = pd.to_datetime(["2024-01-15", "2024-06-30", "2024-12-25"])

# Tạo DataFrame mẫu
df = pd.DataFrame({
    "date_str": ["15/01/2024", "30/06/2024", "25/12/2024", "01/03/2025"],
    "datetime_str": ["2024-01-15 08:30:00", "2024-06-30 14:45:00",
                     "2024-12-25 00:00:00", "2025-03-01 23:59:59"],
    "value": [100, 200, 150, 300]
})
```

### Chuyển đổi sang datetime

```python
# Tự động nhận diện format
df["date"] = pd.to_datetime(df["date_str"])

# Chỉ định format cụ thể (nhanh hơn cho dữ liệu lớn)
df["date"] = pd.to_datetime(df["date_str"], format="%d/%m/%Y")
df["datetime"] = pd.to_datetime(df["datetime_str"], format="%Y-%m-%d %H:%M:%S")

# Xử lý lỗi chuyển đổi
df["date"] = pd.to_datetime(df["date_str"], errors="coerce")  # NaT nếu lỗi
df["date"] = pd.to_datetime(df["date_str"], errors="ignore")  # Giữ nguyên nếu lỗi
```

### Các format phổ biến

| Format code | Ý nghĩa | Ví dụ |
|-------------|---------|-------|
| `%Y` | Năm 4 chữ số | 2024 |
| `%y` | Năm 2 chữ số | 24 |
| `%m` | Tháng (01-12) | 06 |
| `%d` | Ngày (01-31) | 15 |
| `%H` | Giờ 24h (00-23) | 14 |
| `%I` | Giờ 12h (01-12) | 02 |
| `%M` | Phút (00-59) | 30 |
| `%S` | Giây (00-59) | 45 |
| `%p` | AM/PM | PM |
| `%A` | Tên ngày (tiếng Anh) | Monday |
| `%B` | Tên tháng (tiếng Anh) | January |

### Trích xuất thành phần thời gian

```python
df["datetime"] = pd.to_datetime(df["datetime_str"])

# Năm, tháng, ngày
df["year"] = df["datetime"].dt.year
df["month"] = df["datetime"].dt.month
df["day"] = df["datetime"].dt.day

# Giờ, phút, giây
df["hour"] = df["datetime"].dt.hour
df["minute"] = df["datetime"].dt.minute
df["second"] = df["datetime"].dt.second

# Ngày trong tuần (0=Monday, 6=Sunday)
df["day_of_week"] = df["datetime"].dt.dayofweek
df["day_name"] = df["datetime"].dt.day_name()  # "Monday", "Tuesday", ...

# Tuần trong năm
df["week"] = df["datetime"].dt.isocalendar().week

# Ngày trong năm
df["day_of_year"] = df["datetime"].dt.dayofyear

# Quý
df["quarter"] = df["datetime"].dt.quarter

# Kiểm tra cuối tháng
df["is_month_end"] = df["datetime"].dt.is_month_end
df["is_month_start"] = df["datetime"].dt.is_month_start
```

### Tính toán với datetime

```python
# Khoảng cách giữa 2 ngày
df["today"] = pd.Timestamp.now()
df["days_ago"] = (df["today"] - df["datetime"]).dt.days

# Cộng/trừ thời gian
df["next_week"] = df["datetime"] + pd.Timedelta(days=7)
df["next_month"] = df["datetime"] + pd.DateOffset(months=1)
df["next_year"] = df["datetime"] + pd.DateOffset(years=1)

# Timedelta
td = pd.Timedelta(hours=5, minutes=30)
df["new_time"] = df["datetime"] + td
```

### Format datetime thành chuỗi

```python
# Chuyển datetime → chuỗi
df["date_formatted"] = df["datetime"].dt.strftime("%d/%m/%Y")
df["datetime_formatted"] = df["datetime"].dt.strftime("%d-%m-%Y %H:%M")
df["vn_format"] = df["datetime"].dt.strftime("Ngày %d tháng %m năm %Y")
```

### Tạo dãy ngày (Date Range)

```python
# Dãy ngày liên tục
dates = pd.date_range(start="2024-01-01", end="2024-12-31", freq="D")

# Dãy theo tháng
months = pd.date_range(start="2024-01-01", periods=12, freq="MS")  # Đầu tháng
months = pd.date_range(start="2024-01-01", periods=12, freq="ME")  # Cuối tháng

# Dãy theo quý
quarters = pd.date_range(start="2024-01-01", periods=4, freq="QS")

# Dãy ngày làm việc (business days)
bdays = pd.date_range(start="2024-01-01", periods=20, freq="B")
```

### Các tần suất phổ biến

| Freq | Mô tả |
|------|--------|
| `D` | Hàng ngày |
| `B` | Ngày làm việc |
| `W` | Hàng tuần |
| `MS` | Đầu tháng |
| `ME` | Cuối tháng |
| `QS` | Đầu quý |
| `QE` | Cuối quý |
| `YS` | Đầu năm |
| `YE` | Cuối năm |
| `h` | Hàng giờ |
| `min` | Hàng phút |

### Resampling — Gom nhóm theo thời gian

```python
# Tạo dữ liệu time series
np.random.seed(42)
ts = pd.DataFrame({
    "date": pd.date_range("2024-01-01", periods=365, freq="D"),
    "sales": np.random.randint(100, 1000, 365),
    "visitors": np.random.randint(50, 500, 365)
})
ts = ts.set_index("date")

# Gom nhóm theo tuần
weekly = ts.resample("W").sum()

# Gom nhóm theo tháng
monthly = ts.resample("ME").agg(
    total_sales=("sales", "sum"),
    avg_sales=("sales", "mean"),
    max_visitors=("visitors", "max")
)

# Gom nhóm theo quý
quarterly = ts.resample("QE").sum()
```

### Lọc theo khoảng thời gian

```python
# Set index là datetime
ts = ts.set_index("date") if "date" in ts.columns else ts

# Lọc theo năm
ts.loc["2024"]

# Lọc theo tháng cụ thể
ts.loc["2024-06"]

# Lọc theo khoảng
ts.loc["2024-03":"2024-06"]

# Lọc bằng between
mask = df["date"].between("2024-01-01", "2024-06-30")
df[mask]
```

## Ví dụ tổng hợp

```python
import pandas as pd
import numpy as np

# Dữ liệu giao dịch
np.random.seed(42)
n = 1000
transactions = pd.DataFrame({
    "transaction_id": range(1, n + 1),
    "customer_name": np.random.choice(
        ["Nguyễn Văn An", "Trần Thị Bình", "lê văn chi",
         "  PHẠM DŨNG  ", "hoàng em"], n
    ),
    "date": pd.date_range("2024-01-01", periods=n, freq="6h"),
    "amount": np.random.exponential(500_000, n).round(-3),
    "description": np.random.choice(
        ["Mua hàng online", "Thanh toán hóa đơn",
         "Chuyển khoản", "Rút tiền ATM"], n
    )
})

# Pipeline xử lý
result = (
    transactions
    .assign(
        # Chuẩn hóa tên
        customer_clean=lambda x: x["customer_name"].str.strip().str.title(),
        # Trích xuất họ
        last_name=lambda x: x["customer_clean"].str.split().str[0],
        # Trích xuất thông tin thời gian
        month=lambda x: x["date"].dt.to_period("M"),
        day_name=lambda x: x["date"].dt.day_name(),
        is_weekend=lambda x: x["date"].dt.dayofweek >= 5,
        # Format ngày
        date_vn=lambda x: x["date"].dt.strftime("%d/%m/%Y")
    )
    # Lọc giao dịch trên 200k
    .query("amount >= 200_000")
    # Tổng hợp theo tháng và khách hàng
    .groupby(["month", "customer_clean"])
    .agg(
        total_amount=("amount", "sum"),
        avg_amount=("amount", "mean"),
        num_transactions=("amount", "count")
    )
    .reset_index()
    .sort_values(["month", "total_amount"], ascending=[True, False])
)

print(result.head(10))
```

::: {.callout-tip}
## Tóm tắt accessor trong pandas

| Accessor | Áp dụng cho | Ví dụ |
|----------|-------------|-------|
| `.str` | Cột chuỗi (`object`, `string`) | `df["name"].str.upper()` |
| `.dt` | Cột datetime (`datetime64`) | `df["date"].dt.year` |
| `.cat` | Cột category | `df["grade"].cat.codes` |

Hãy nhớ chuyển đổi kiểu dữ liệu phù hợp trước khi sử dụng accessor!
:::
