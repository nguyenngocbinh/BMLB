---
applyTo: '11-Git/**,12-Docker/**,09-Model Deployment/**,14-Web Craping/**'
---
# Hướng dẫn Viết Nội dung DevOps & Tools

## Tổng quan
Hướng dẫn này áp dụng cho các chapter về Git, Docker, Model Deployment và Web Scraping.

## Chapter 11 - Git:

### Nội dung cần bao phủ:
1. **Git cơ bản**: init, add, commit, push, pull, clone
2. **Branching**: branch, checkout, merge, rebase
3. **Collaboration**: pull request, code review, conflict resolution
4. **Git Flow**: feature branches, release branches
5. **GitHub**: Issues, Actions, Pages
6. **.gitignore**: Patterns cho Python/Data Science projects

### Ví dụ .gitignore cho Data Science:
```gitignore
# Python
__pycache__/
*.pyc
*.pyo
.venv/
venv/
.env
*.egg-info/
dist/
build/

# Jupyter
.ipynb_checkpoints/

# Data files
*.csv
*.xlsx
*.parquet
data/

# IDE
.vscode/
.idea/

# Quarto
_site/
.quarto/

# OS
.DS_Store
Thumbs.db
```

## Chapter 12 - Docker:

### Nội dung cần bao phủ:
1. **Docker basics**: images, containers, volumes
2. **Dockerfile**: Build custom images
3. **docker-compose**: Multi-container applications
4. **Docker images**: Python, Jupyter

### Dockerfile mẫu cho Data Science:
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for MSSQL
RUN apt-get update && apt-get install -y \
    unixodbc-dev \
    curl \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

## Chapter 09 - Model Deployment:

### Nội dung cần bao phủ:
1. **FastAPI**: REST API cho Python models (ưu tiên)
2. **Flask**: Lightweight REST API alternative
3. **Streamlit**: Interactive data apps
4. **Gradio**: ML demo interfaces
5. **Docker deployment**: Containerize models
6. **Cloud platforms**: AWS, Azure, GCP basics

## Chapter 14 - Web Scraping:

### Nội dung cần bao phủ:
1. **BeautifulSoup** (Python): HTML parsing
2. **Scrapy** (Python): Web crawling framework
3. **Selenium**: Dynamic pages (headless browser)
4. **requests**: HTTP requests cơ bản
5. **Ethics**: robots.txt, rate limiting, legal considerations

### Lưu ý Đạo đức:
- Luôn kiểm tra `robots.txt`
- Thêm delay giữa các requests
- Tôn trọng Terms of Service
- Không scrape dữ liệu cá nhân
