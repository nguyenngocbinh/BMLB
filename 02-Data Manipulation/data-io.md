# Đọc và Ghi dữ liệu

## Tổng quan

Pandas hỗ trợ đọc/ghi dữ liệu từ nhiều định dạng khác nhau. Bảng dưới đây tóm tắt các hàm phổ biến:

| Định dạng | Đọc (Read) | Ghi (Write) |
|-----------|------------|-------------|
| CSV | `pd.read_csv()` | `df.to_csv()` |
| Excel | `pd.read_excel()` | `df.to_excel()` |
| JSON | `pd.read_json()` | `df.to_json()` |
| Parquet | `pd.read_parquet()` | `df.to_parquet()` |
| SQL | `pd.read_sql()` | `df.to_sql()` |
| Clipboard | `pd.read_clipboard()` | `df.to_clipboard()` |
| HTML | `pd.read_html()` | `df.to_html()` |
| Pickle | `pd.read_pickle()` | `df.to_pickle()` |
| Feather | `pd.read_feather()` | `df.to_feather()` |

## Đọc file CSV

### Cơ bản

```python
import pandas as pd

# Đọc file CSV đơn giản
df = pd.read_csv("data.csv")

# Chỉ định encoding (phổ biến cho tiếng Việt)
df = pd.read_csv("data.csv", encoding="utf-8")
df = pd.read_csv("data.csv", encoding="utf-8-sig")  # File có BOM

# Chỉ định separator
df = pd.read_csv("data.tsv", sep="\t")          # Tab-separated
df = pd.read_csv("data.txt", sep="|")            # Pipe-separated
```

### Các tham số hữu ích

```python
# Chọn cột cần đọc
df = pd.read_csv("data.csv", usecols=["name", "age", "city"])

# Chỉ định kiểu dữ liệu
df = pd.read_csv("data.csv", dtype={"zip_code": str, "age": int})

# Parse cột ngày tháng
df = pd.read_csv("data.csv", parse_dates=["date_col"])

# Đọc n dòng đầu tiên
df = pd.read_csv("data.csv", nrows=1000)

# Bỏ qua n dòng đầu
df = pd.read_csv("data.csv", skiprows=3)

# Chỉ định giá trị missing
df = pd.read_csv("data.csv", na_values=["NA", "N/A", "-", ""])

# Chỉ định cột index
df = pd.read_csv("data.csv", index_col="id")

# Đọc file không có header
df = pd.read_csv("data.csv", header=None, names=["col1", "col2", "col3"])
```

### Đọc file lớn theo chunks

```python
# Đọc file lớn từng phần (chunk)
chunk_size = 10_000
chunks = []

for chunk in pd.read_csv("large_file.csv", chunksize=chunk_size):
    # Xử lý từng chunk
    filtered = chunk.query("value > 100")
    chunks.append(filtered)

# Ghép các chunks lại
df = pd.concat(chunks, ignore_index=True)
```

## Ghi file CSV

```python
# Ghi cơ bản
df.to_csv("output.csv", index=False)

# Chỉ định encoding
df.to_csv("output.csv", index=False, encoding="utf-8-sig")

# Chỉ định separator
df.to_csv("output.tsv", sep="\t", index=False)

# Chỉ ghi một số cột
df.to_csv("output.csv", columns=["name", "age"], index=False)
```

## Đọc/Ghi file Excel

### Đọc Excel

```python
# Đọc sheet mặc định (sheet đầu tiên)
df = pd.read_excel("data.xlsx")

# Chỉ định sheet
df = pd.read_excel("data.xlsx", sheet_name="Sheet2")
df = pd.read_excel("data.xlsx", sheet_name=1)  # Sheet thứ 2 (0-indexed)

# Đọc tất cả sheets → dictionary of DataFrames
all_sheets = pd.read_excel("data.xlsx", sheet_name=None)
for sheet_name, sheet_df in all_sheets.items():
    print(f"Sheet: {sheet_name}, Shape: {sheet_df.shape}")

# Chỉ định vùng dữ liệu
df = pd.read_excel("data.xlsx", usecols="A:D", skiprows=2, nrows=100)
```

### Ghi Excel

```python
# Ghi đơn giản
df.to_excel("output.xlsx", index=False, sheet_name="Data")

# Ghi nhiều sheets vào 1 file
with pd.ExcelWriter("output.xlsx", engine="openpyxl") as writer:
    df1.to_excel(writer, sheet_name="Sales", index=False)
    df2.to_excel(writer, sheet_name="Products", index=False)
    df3.to_excel(writer, sheet_name="Summary", index=False)
```

::: {.callout-note}
## Lưu ý
Cần cài thêm thư viện `openpyxl` (cho `.xlsx`) hoặc `xlrd` (cho `.xls` cũ):

```bash
pip install openpyxl
```
:::

## Đọc/Ghi JSON

```python
# Đọc JSON
df = pd.read_json("data.json")

# Đọc JSON dạng records
df = pd.read_json("data.json", orient="records")

# Đọc JSON dạng lồng nhau (nested)
import json
with open("nested.json", "r", encoding="utf-8") as f:
    data = json.load(f)
df = pd.json_normalize(data)  # Flatten nested JSON

# Ghi JSON
df.to_json("output.json", orient="records", force_ascii=False, indent=2)
```

## Đọc/Ghi Parquet

**Parquet** là định dạng cột (columnar format) hiệu quả cho dữ liệu lớn — nhỏ hơn CSV nhiều lần và đọc/ghi nhanh hơn đáng kể.

```python
# Đọc Parquet
df = pd.read_parquet("data.parquet")

# Chỉ đọc một số cột (Parquet hỗ trợ column pruning)
df = pd.read_parquet("data.parquet", columns=["name", "age"])

# Ghi Parquet
df.to_parquet("output.parquet", index=False)

# Ghi với compression
df.to_parquet("output.parquet", compression="snappy")  # Default
df.to_parquet("output.parquet", compression="gzip")     # Nhỏ hơn
```

::: {.callout-note}
## Lưu ý
Cần cài thêm thư viện `pyarrow` hoặc `fastparquet`:

```bash
pip install pyarrow
```
:::

## Đọc/Ghi SQL Database

### Kết nối MSSQL (SQL Server)

```python
import pandas as pd
import pyodbc
from sqlalchemy import create_engine

# Cách 1: Dùng pyodbc trực tiếp
conn_str = (
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=server_name;"
    "DATABASE=db_name;"
    "UID=username;"
    "PWD=password;"
)
conn = pyodbc.connect(conn_str)

# Đọc dữ liệu bằng SQL query
df = pd.read_sql("SELECT * FROM customers WHERE city = N'Hà Nội'", conn)

# Cách 2: Dùng SQLAlchemy engine (khuyến khích)
engine = create_engine(
    "mssql+pyodbc://username:password@server_name/db_name"
    "?driver=ODBC+Driver+17+for+SQL+Server"
)

df = pd.read_sql("SELECT TOP 100 * FROM sales", engine)
```

### Ghi dữ liệu vào SQL

```python
# Ghi DataFrame vào bảng SQL
df.to_sql(
    name="table_name",
    con=engine,
    if_exists="replace",   # "append", "fail", hoặc "replace"
    index=False,
    chunksize=1000          # Ghi theo batch
)
```

| Giá trị `if_exists` | Hành vi |
|---------------------|---------|
| `"fail"` | Báo lỗi nếu bảng đã tồn tại (mặc định) |
| `"replace"` | Xóa bảng cũ, tạo bảng mới |
| `"append"` | Thêm dòng vào bảng hiện có |

### Đọc kết quả stored procedure

```python
# Đọc kết quả từ stored procedure
df = pd.read_sql("EXEC sp_get_report @year=2024", engine)
```

## Đọc từ Clipboard

Rất hữu ích khi muốn copy dữ liệu từ Excel hoặc website rồi đọc trực tiếp:

```python
# Copy dữ liệu từ Excel/Web, sau đó:
df = pd.read_clipboard()

# Với separator cụ thể
df = pd.read_clipboard(sep="\t")
```

## Đọc HTML Tables

```python
# Đọc tất cả bảng từ trang web
tables = pd.read_html("https://example.com/data-table.html")

# Lấy bảng đầu tiên
df = tables[0]

# Lọc bảng theo text match
tables = pd.read_html("https://example.com", match="Revenue")
```

## So sánh hiệu suất các định dạng

| Định dạng | Kích thước file | Tốc độ đọc | Tốc độ ghi | Ghi chú |
|-----------|----------------|-------------|-------------|---------|
| CSV | Lớn | Chậm | Chậm | Phổ biến nhất, đọc được bằng mọi công cụ |
| Parquet | Rất nhỏ | Rất nhanh | Nhanh | Tốt nhất cho dữ liệu lớn |
| Excel | Lớn | Chậm | Chậm | Tiện cho chia sẻ với người dùng cuối |
| Feather | Nhỏ | Rất nhanh | Rất nhanh | Tốt cho trao đổi giữa Python và R |
| Pickle | Nhỏ | Nhanh | Nhanh | Chỉ dùng trong Python |

::: {.callout-tip}
## Khuyến nghị
- **Lưu trữ trung gian**: Dùng **Parquet** cho hiệu suất tốt nhất
- **Chia sẻ với người khác**: Dùng **CSV** hoặc **Excel**
- **Dữ liệu lớn (> 1GB)**: Dùng **Parquet** với column pruning
- **Database**: Dùng **SQL** cho dữ liệu cần cập nhật thường xuyên
:::
