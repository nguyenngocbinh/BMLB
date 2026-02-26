---
description: 'Viết bài giảng triển khai mô hình ML với FastAPI/Streamlit/Docker'
---
# Viết bài giảng Model Deployment với Python

Viết nội dung bài giảng cho chapter **09-Model Deployment** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Lưu & Load mô hình
```python
import joblib
import pickle

# Save model
joblib.dump(model, "model.joblib")

# Load model
model = joblib.load("model.joblib")

# Hoặc dùng pickle
with open("model.pkl", "wb") as f:
    pickle.dump(model, f)
```

### 2. FastAPI - REST API
```python
# app.py
from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np

app = FastAPI(title="ML Prediction API")

# Load model khi khởi động
model = joblib.load("model.joblib")

class PredictionInput(BaseModel):
    feature1: float
    feature2: float
    feature3: float

class PredictionOutput(BaseModel):
    prediction: float
    probability: float = None

@app.post("/predict", response_model=PredictionOutput)
def predict(input_data: PredictionInput):
    features = np.array([[input_data.feature1, input_data.feature2, input_data.feature3]])
    prediction = model.predict(features)[0]
    proba = model.predict_proba(features)[0].max() if hasattr(model, "predict_proba") else None
    return PredictionOutput(prediction=prediction, probability=proba)

@app.get("/health")
def health_check():
    return {"status": "healthy"}
```

```bash
# Chạy server
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

### 3. Streamlit - Data App
```python
# streamlit_app.py
import streamlit as st
import pandas as pd
import joblib

st.title("🔮 Dự đoán với ML Model")
st.sidebar.header("Nhập dữ liệu")

# Input widgets
feature1 = st.sidebar.slider("Feature 1", 0.0, 100.0, 50.0)
feature2 = st.sidebar.number_input("Feature 2", value=25.0)
feature3 = st.sidebar.selectbox("Feature 3", ["A", "B", "C"])

# Prediction
model = joblib.load("model.joblib")
if st.button("Dự đoán"):
    input_data = pd.DataFrame({"f1": [feature1], "f2": [feature2], "f3": [feature3]})
    prediction = model.predict(input_data)
    st.success(f"Kết quả dự đoán: {prediction[0]}")
```

```bash
streamlit run streamlit_app.py
```

### 4. Docker Deployment
```dockerfile
# Dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
```

```yaml
# docker-compose.yml
version: "3.8"
services:
  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - MODEL_PATH=/app/model.joblib
    volumes:
      - ./models:/app/models
```

### 5. Requirements file
```text
# requirements.txt
fastapi==0.104.1
uvicorn==0.24.0
scikit-learn==1.3.2
pandas==2.1.3
numpy==1.26.2
joblib==1.3.2
streamlit==1.28.2
```

### 6. MLflow (Model Registry) - Nâng cao
```python
import mlflow
import mlflow.sklearn

mlflow.set_experiment("my_experiment")

with mlflow.start_run():
    model.fit(X_train, y_train)
    mlflow.log_param("n_estimators", 100)
    mlflow.log_metric("accuracy", accuracy)
    mlflow.sklearn.log_model(model, "model")
```

## Quy tắc
- Luôn có `/health` endpoint để kiểm tra API
- Input validation với Pydantic (FastAPI)
- KHÔNG hardcode model path, dùng environment variables
- requirements.txt phải pin version cụ thể
