---
description: 'Viết bài giảng kết nối và thao tác MSSQL với Python (pyodbc, sqlalchemy)'
---
# Viết bài giảng Database (MSSQL) với Python

Viết nội dung bài giảng cho chapter **13-Database** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Kết nối MSSQL với pyodbc
```python
import pyodbc
import os

conn = pyodbc.connect(
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={os.getenv('DB_SERVER')};"
    f"DATABASE={os.getenv('DB_NAME')};"
    f"PORT=1433;"
    f"Trusted_Connection=yes;"
)
cursor = conn.cursor()
```

### 2. Kết nối với sqlalchemy
```python
from sqlalchemy import create_engine, text
import os

engine = create_engine(
    f"mssql+pyodbc://{os.getenv('DB_SERVER')}/{os.getenv('DB_NAME')}"
    f"?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
)
```

### 3. Đọc dữ liệu (SELECT)
```python
import pandas as pd

# Simple query
df = pd.read_sql("SELECT TOP 1000 * FROM customers", conn)

# Parameterized query (tránh SQL injection)
query = "SELECT * FROM orders WHERE order_date >= ? AND status = ?"
df = pd.read_sql(query, conn, params=["2024-01-01", "completed"])

# Với sqlalchemy
with engine.connect() as connection:
    result = connection.execute(
        text("SELECT * FROM customers WHERE city = :city"),
        {"city": "Hanoi"}
    )
    df = pd.DataFrame(result.fetchall(), columns=result.keys())
```

### 4. Ghi dữ liệu (INSERT / UPDATE)
```python
# Ghi DataFrame vào SQL Server
df.to_sql("table_name", engine, if_exists="replace", index=False,
          method="multi", chunksize=1000)

# if_exists options: "fail", "replace", "append"

# Insert từng dòng
cursor.execute(
    "INSERT INTO customers (name, email) VALUES (?, ?)",
    ("Nguyen Van A", "a@email.com")
)
conn.commit()

# Bulk insert
data = [("Name1", "email1"), ("Name2", "email2")]
cursor.executemany(
    "INSERT INTO customers (name, email) VALUES (?, ?)", data
)
conn.commit()
```

### 5. SQL cơ bản cho Data Science
```sql
-- Aggregate
SELECT category, COUNT(*) AS cnt, AVG(amount) AS avg_amount
FROM orders
GROUP BY category
HAVING COUNT(*) > 10
ORDER BY avg_amount DESC;

-- JOIN
SELECT o.order_id, c.name, o.amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
WHERE o.order_date >= '2024-01-01';

-- Window functions
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY amount DESC) AS rn,
    SUM(amount) OVER (PARTITION BY category) AS category_total
FROM orders;

-- CTE
WITH monthly_sales AS (
    SELECT FORMAT(order_date, 'yyyy-MM') AS month,
           SUM(amount) AS total_sales
    FROM orders
    GROUP BY FORMAT(order_date, 'yyyy-MM')
)
SELECT *, LAG(total_sales) OVER (ORDER BY month) AS prev_month
FROM monthly_sales;
```

### 6. Stored Procedure
```python
# Gọi stored procedure
cursor.execute("EXEC sp_get_report @year=?, @month=?", (2024, 12))
rows = cursor.fetchall()

# Tạo stored procedure
create_sp = """
CREATE PROCEDURE sp_customer_summary
    @min_orders INT = 5
AS
BEGIN
    SELECT customer_id, COUNT(*) as order_count, SUM(amount) as total
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) >= @min_orders
END
"""
cursor.execute(create_sp)
conn.commit()
```

### 7. Context Manager & Best Practices
```python
# Luôn đóng connection
from contextlib import contextmanager

@contextmanager
def get_connection():
    conn = pyodbc.connect(CONNECTION_STRING)
    try:
        yield conn
    finally:
        conn.close()

# Sử dụng
with get_connection() as conn:
    df = pd.read_sql("SELECT * FROM table", conn)
```

## Quy tắc
- **LUÔN** dùng parameterized queries, KHÔNG nối string
- **LUÔN** đóng connection sau khi dùng xong
- **KHÔNG** hardcode credentials, dùng `os.getenv()` hoặc `.env`
- SQL keywords viết HOA: `SELECT`, `FROM`, `WHERE`, `JOIN`
- Dùng `chunksize` khi ghi dữ liệu lớn
