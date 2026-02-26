---
applyTo: '13-Database/**,99-Practice/2. Scripts/**'
---
# Hướng dẫn Viết Nội dung Database

## Tổng quan
Chapter 13 bao gồm hướng dẫn kết nối và thao tác với cơ sở dữ liệu. Dự án sử dụng **MSSQL** (Microsoft SQL Server) làm hệ quản trị CSDL chính, kết nối qua **Python**.

## Kết nối Database:

### Python (pyodbc - ưu tiên cho MSSQL):
```python
import pyodbc
import pandas as pd
import os

# Connect to SQL Server
conn = pyodbc.connect(
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={os.getenv('DB_SERVER')};"
    f"DATABASE={os.getenv('DB_NAME')};"
    f"PORT=1433;"
    f"Trusted_Connection=yes;"
)

# Query data
df = pd.read_sql("SELECT * FROM table_name", conn)

# Write data
from sqlalchemy import create_engine

engine = create_engine(
    f"mssql+pyodbc://{os.getenv('DB_SERVER')}/{os.getenv('DB_NAME')}"
    f"?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
)
df.to_sql("table_name", engine, if_exists="replace", index=False)

# Close connection
conn.close()
```

### Python (sqlalchemy - ORM approach):
```python
from sqlalchemy import create_engine, text
import pandas as pd
import os

# Create engine
engine = create_engine(
    f"mssql+pyodbc://{os.getenv('DB_SERVER')}/{os.getenv('DB_NAME')}"
    f"?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
)

# Query with parameterized SQL
with engine.connect() as conn:
    result = conn.execute(
        text("SELECT * FROM table_name WHERE year = :year"),
        {"year": 2024}
    )
    df = pd.DataFrame(result.fetchall(), columns=result.keys())
```

## Quy tắc SQL:
- **Viết hoa keywords**: `SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`
- **Alias rõ ràng**: `SELECT t.name AS customer_name FROM customers t`
- **Parameterized queries**: Tránh SQL injection, KHÔNG ĐƯỢC nối string trực tiếp
- **Comments**: Giải thích logic phức tạp

## Hệ quản trị CSDL:
- **MSSQL (SQL Server)**: Hệ CSDL chính của dự án
- **SQLite**: Sử dụng cho demo/testing nhỏ khi không có SQL Server

## Security:
- **KHÔNG BAO GIỜ** hardcode credentials trong code
- Sử dụng `os.getenv()` hoặc thư viện `python-dotenv`
- Sử dụng `.env` file và thêm vào `.gitignore`
- Sử dụng parameterized queries (`text()` trong sqlalchemy) để tránh SQL injection
