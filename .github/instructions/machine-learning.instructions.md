---
applyTo: '08-Machine Learning/**'
---
# Hướng dẫn Viết Nội dung Machine Learning

## Tổng quan
Chapter 08 bao gồm các thuật toán Machine Learning phổ biến. Các chủ đề hiện có: XGBoost, LightGBM, Random Forest, LSTM.

## Các Thuật toán Cần Bao phủ:

### Supervised Learning:
1. **Linear/Logistic Regression** (đã có ở Chapter 05)
2. **Decision Tree / Random Forest**
3. **Gradient Boosting**: XGBoost, LightGBM, CatBoost
4. **Support Vector Machine (SVM)**
5. **K-Nearest Neighbors (KNN)**
6. **Neural Networks / Deep Learning (LSTM, etc.)**

### Unsupervised Learning:
1. **K-Means Clustering**
2. **Hierarchical Clustering**
3. **PCA (Principal Component Analysis)**
4. **DBSCAN**

### Model Evaluation:
- **Classification**: Accuracy, Precision, Recall, F1-Score, AUC-ROC, Confusion Matrix
- **Regression**: RMSE, MAE, $R^2$, Adjusted $R^2$
- **Cross-Validation**: k-fold, Stratified k-fold
- **Bias-Variance Tradeoff**

## Format Viết Bài cho Mỗi Thuật toán:

```markdown
# Tên Thuật toán

## Giới thiệu
Mô tả ngắn gọn thuật toán...

## Lý thuyết
### Ý tưởng chính
### Công thức toán học
### Ưu điểm và Nhược điểm

## Ví dụ Thực hành

### Với Python (scikit-learn)
` ` `python
from sklearn.ensemble import RandomForestClassifier
# Code example
` ` `

## Đánh giá Mô hình
## Hyperparameter Tuning
## Kết luận
```

## Quy tắc Code ML:

### Python (scikit-learn):
```python
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline
from sklearn.metrics import classification_report

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.25, random_state=42, stratify=y
)

# Pipeline with preprocessing
pipeline = Pipeline([
    ("scaler", StandardScaler()),
    ("model", RandomForestClassifier(n_estimators=100, random_state=42))
])

# Hyperparameter Tuning
param_grid = {
    "model__n_estimators": [100, 200, 500],
    "model__max_depth": [5, 10, None],
    "model__min_samples_split": [2, 5, 10]
}

grid_search = GridSearchCV(
    pipeline, param_grid, cv=5, scoring="f1_weighted", n_jobs=-1
)
grid_search.fit(X_train, y_train)

# Evaluate
y_pred = grid_search.predict(X_test)
print(classification_report(y_test, y_pred))
print(f"Best params: {grid_search.best_params_}")
```

## Datasets cho ML:
- **Classification**: `sklearn.datasets.load_iris()`, `seaborn.load_dataset("titanic")`, `sklearn.datasets.load_breast_cancer()`
- **Regression**: `sklearn.datasets.fetch_california_housing()`, `seaborn.load_dataset("tips")`
- **Clustering**: `sklearn.datasets.make_blobs()`, `sklearn.datasets.make_moons()`
- **Time Series**: `statsmodels.datasets.co2`, `statsmodels.datasets.sunspots`
