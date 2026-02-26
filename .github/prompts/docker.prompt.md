---
description: 'Viết bài giảng Docker cho Data Science & ML Deployment'
---
# Viết bài giảng Docker cho Data Science

Viết nội dung bài giảng cho chapter **12-Docker** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Docker cơ bản
```bash
# Pull image
docker pull python:3.11-slim

# Run container
docker run -it python:3.11-slim bash
docker run -d -p 8000:8000 --name my-api my-image

# Quản lý container
docker ps                    # Containers đang chạy
docker ps -a                 # Tất cả containers
docker stop my-api
docker rm my-api
docker logs my-api

# Quản lý image
docker images
docker rmi image_name
```

### 2. Dockerfile cho Python Data Science
```dockerfile
FROM python:3.11-slim

# Install system deps for MSSQL
RUN apt-get update && apt-get install -y \
    curl gnupg2 unixodbc-dev \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
```

### 3. Dockerfile cho Jupyter
```dockerfile
FROM python:3.11-slim
RUN pip install jupyterlab pandas numpy matplotlib seaborn scikit-learn
WORKDIR /notebooks
EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
```

### 4. Docker Compose
```yaml
# docker-compose.yml
version: "3.8"
services:
  api:
    build: .
    ports:
      - "8000:8000"
    env_file:
      - .env
    depends_on:
      - db
    restart: unless-stopped

  db:
    image: mcr.microsoft.com/mssql/server:2022-latest
    environment:
      ACCEPT_EULA: "Y"
      MSSQL_SA_PASSWORD: "${DB_PASSWORD}"
    ports:
      - "1433:1433"
    volumes:
      - mssql_data:/var/opt/mssql

  jupyter:
    build:
      context: .
      dockerfile: Dockerfile.jupyter
    ports:
      - "8888:8888"
    volumes:
      - ./notebooks:/notebooks

volumes:
  mssql_data:
```

### 5. Docker Volumes (lưu trữ dữ liệu)
```bash
# Mount thư mục local
docker run -v $(pwd)/data:/app/data my-image

# Named volumes
docker volume create my_data
docker run -v my_data:/app/data my-image
```

### 6. Multi-stage Build (tối ưu image size)
```dockerfile
# Stage 1: Build
FROM python:3.11 AS builder
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Stage 2: Production
FROM python:3.11-slim
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH
COPY . /app
WORKDIR /app
CMD ["python", "app.py"]
```

### 7. .dockerignore
```
__pycache__
*.pyc
.env
.git
.vscode
data/
*.csv
*.xlsx
.quarto/
_site/
```

## Quy tắc
- Dùng `python:3.11-slim` (không dùng full image)
- `.env` file cho credentials, KHÔNG bake vào image
- Luôn có `.dockerignore`
- `docker-compose` khi cần nhiều services
- MSSQL container: `mcr.microsoft.com/mssql/server:2022-latest`
