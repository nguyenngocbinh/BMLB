---
description: 'Viết bài giảng Web Scraping với Python (BeautifulSoup, Scrapy, Selenium)'
---
# Viết bài giảng Web Scraping với Python

Viết nội dung bài giảng cho chapter **14-Web Scraping** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Requests - HTTP cơ bản
```python
import requests

response = requests.get("https://example.com")
print(response.status_code)   # 200
print(response.text[:500])     # HTML content

# Với headers (tránh bị block)
headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"}
response = requests.get(url, headers=headers, timeout=10)

# POST request
response = requests.post(url, json={"key": "value"})
```

### 2. BeautifulSoup - HTML Parsing
```python
from bs4 import BeautifulSoup
import requests

response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Tìm elements
title = soup.find("h1").text
links = [a["href"] for a in soup.find_all("a", href=True)]
paragraphs = [p.text for p in soup.find_all("p")]

# CSS Selector
items = soup.select("div.product-card h2.title")
prices = soup.select("span.price")

# Table → DataFrame
import pandas as pd
tables = pd.read_html(response.text)
df = tables[0]  # Lấy bảng đầu tiên
```

### 3. Scrape nhiều trang (Pagination)
```python
import time

all_data = []
for page in range(1, 11):
    url = f"https://example.com/products?page={page}"
    response = requests.get(url, headers=headers, timeout=10)
    soup = BeautifulSoup(response.text, "html.parser")

    for item in soup.select("div.product"):
        all_data.append({
            "name": item.select_one("h2").text.strip(),
            "price": item.select_one("span.price").text.strip(),
        })

    time.sleep(2)  # Rate limiting - tôn trọng server

df = pd.DataFrame(all_data)
```

### 4. Selenium - Dynamic Pages (JavaScript)
```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Setup (headless Chrome)
options = webdriver.ChromeOptions()
options.add_argument("--headless")
driver = webdriver.Chrome(options=options)

# Navigate
driver.get("https://example.com")

# Wait for element
element = WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, "div.content"))
)

# Extract data
items = driver.find_elements(By.CSS_SELECTOR, "div.item")
data = [item.text for item in items]

# Click & scroll
button = driver.find_element(By.ID, "load-more")
button.click()

driver.quit()
```

### 5. Scrapy - Web Crawling Framework
```python
# Tạo project
# scrapy startproject myproject
# scrapy genspider example example.com

import scrapy

class ProductSpider(scrapy.Spider):
    name = "products"
    start_urls = ["https://example.com/products"]

    def parse(self, response):
        for product in response.css("div.product"):
            yield {
                "name": product.css("h2::text").get(),
                "price": product.css("span.price::text").get(),
                "url": product.css("a::attr(href)").get(),
            }

        # Follow pagination
        next_page = response.css("a.next-page::attr(href)").get()
        if next_page:
            yield response.follow(next_page, self.parse)
```

### 6. Lưu dữ liệu vào MSSQL
```python
import pandas as pd
from sqlalchemy import create_engine

df = pd.DataFrame(all_data)
engine = create_engine("mssql+pyodbc://server/db?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes")
df.to_sql("scraped_data", engine, if_exists="append", index=False)
```

### 7. Đạo đức Web Scraping
```python
import urllib.robotparser

# Kiểm tra robots.txt
rp = urllib.robotparser.RobotFileParser()
rp.set_url("https://example.com/robots.txt")
rp.read()
allowed = rp.can_fetch("*", "https://example.com/products")
print(f"Allowed: {allowed}")
```

## Quy tắc Đạo đức
- ✅ Kiểm tra `robots.txt` trước khi scrape
- ✅ Thêm `time.sleep()` giữa requests (≥ 1-2 giây)
- ✅ Dùng User-Agent header thật
- ❌ KHÔNG scrape dữ liệu cá nhân
- ❌ KHÔNG DDoS server
- ❌ KHÔNG vi phạm Terms of Service

## Quy tắc Code
- Luôn dùng `try/except` cho requests
- Luôn dùng `timeout` parameter
- Rate limiting bắt buộc
- Lưu raw HTML trước khi parse (debug)
