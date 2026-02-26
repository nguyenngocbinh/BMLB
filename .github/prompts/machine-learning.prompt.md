---
description: 'Viết bài giảng Machine Learning với Python (scikit-learn, xgboost, lightgbm)'
---
# Viết bài giảng Machine Learning với Python

Viết nội dung bài giảng cho chapter **08-Machine Learning** trong dự án BMLB.

## Phạm vi Nội dung

### 1. ML Pipeline chuẩn
```python
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline

# Split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.25, random_state=42, stratify=y  # stratify cho classification
)

# Pipeline
pipeline = Pipeline([
    ("scaler", StandardScaler()),
    ("model", SomeModel())
])
pipeline.fit(X_train, y_train)
y_pred = pipeline.predict(X_test)
```

### 2. Random Forest
```python
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor

rf = RandomForestClassifier(n_estimators=500, max_depth=10, random_state=42, n_jobs=-1)
rf.fit(X_train, y_train)

# Feature importance
import pandas as pd
feat_imp = pd.Series(rf.feature_importances_, index=feature_names).sort_values(ascending=False)
feat_imp.head(10).plot(kind="barh")
```

### 3. XGBoost
```python
import xgboost as xgb

model = xgb.XGBClassifier(
    n_estimators=500, max_depth=6, learning_rate=0.1,
    subsample=0.8, colsample_bytree=0.8,
    eval_metric="logloss", random_state=42
)
model.fit(X_train, y_train,
          eval_set=[(X_test, y_test)],
          verbose=False)

xgb.plot_importance(model, max_num_features=15)
```

### 4. LightGBM
```python
import lightgbm as lgb

model = lgb.LGBMClassifier(
    n_estimators=500, max_depth=-1, learning_rate=0.05,
    num_leaves=31, subsample=0.8, colsample_bytree=0.8,
    random_state=42
)
model.fit(X_train, y_train,
          eval_set=[(X_test, y_test)],
          callbacks=[lgb.log_evaluation(0)])
```

### 5. SVM & KNN
```python
from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier

svm = SVC(kernel="rbf", C=1.0, gamma="scale")
knn = KNeighborsClassifier(n_neighbors=5)
```

### 6. Clustering (Unsupervised)
```python
from sklearn.cluster import KMeans, DBSCAN
from sklearn.decomposition import PCA
from sklearn.metrics import silhouette_score

# K-Means
kmeans = KMeans(n_clusters=3, random_state=42, n_init=10)
labels = kmeans.fit_predict(X)
print(f"Silhouette Score: {silhouette_score(X, labels):.4f}")

# PCA for visualization
pca = PCA(n_components=2)
X_2d = pca.fit_transform(X)
```

### 7. Hyperparameter Tuning
```python
from sklearn.model_selection import GridSearchCV, RandomizedSearchCV

param_grid = {
    "model__n_estimators": [100, 300, 500],
    "model__max_depth": [3, 5, 10, None],
    "model__min_samples_split": [2, 5, 10]
}

grid = GridSearchCV(
    pipeline, param_grid, cv=5,
    scoring="f1_weighted", n_jobs=-1, verbose=1
)
grid.fit(X_train, y_train)
print(f"Best params: {grid.best_params_}")
print(f"Best score: {grid.best_score_:.4f}")
```

### 8. Model Evaluation
```python
from sklearn.metrics import (
    classification_report, confusion_matrix, roc_auc_score, roc_curve,
    mean_squared_error, mean_absolute_error, r2_score
)

# Classification
print(classification_report(y_test, y_pred))
cm = confusion_matrix(y_test, y_pred)
sns.heatmap(cm, annot=True, fmt="d", cmap="Blues")

# ROC Curve
fpr, tpr, _ = roc_curve(y_test, y_prob[:, 1])
auc = roc_auc_score(y_test, y_prob[:, 1])

# Regression
rmse = mean_squared_error(y_test, y_pred, squared=False)
mae = mean_absolute_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
```

### 9. LSTM (Deep Learning)
```python
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense, Dropout

model = Sequential([
    LSTM(64, return_sequences=True, input_shape=(timesteps, features)),
    Dropout(0.2),
    LSTM(32),
    Dropout(0.2),
    Dense(1)
])
model.compile(optimizer="adam", loss="mse")
model.fit(X_train, y_train, epochs=50, batch_size=32, validation_split=0.2)
```

## Quy tắc
- Luôn split data trước, KHÔNG dùng test data trong quá trình tuning
- Luôn dùng `random_state=42` để reproducible
- Giải thích metrics bằng tiếng Việt
- Dataset: `sklearn.datasets.load_iris()`, `load_breast_cancer()`, `fetch_california_housing()`
