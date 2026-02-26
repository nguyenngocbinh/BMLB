---
description: 'Tạo code example chuẩn Python cho bài giảng Data Science'
---
# Tạo Code Example Python

## Mô tả
Sử dụng prompt này để tạo code example Python cho một chủ đề Data Science cụ thể.

## Yêu cầu đầu vào
- Chủ đề/thuật toán cần minh họa
- Dataset sử dụng (hoặc để mặc định)
- Mức độ chi tiết (cơ bản / nâng cao)

## Template Code Example

```python
# =============================================================================
# Title: [Algorithm/Technique Name]
# Description: [Short description]
# Dataset: [Dataset name]
# =============================================================================

# --- 1. Import Packages ---
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# --- 2. Load & Explore Data ---
df = pd.read_csv("dataset.csv")  # or use built-in
print(df.info())
print(df.describe())

# --- 3. Data Preprocessing ---
clean_df = (
    df
    .dropna(subset=["target"])
    .assign(new_feature=lambda x: transformation(x["old_feature"]))
)

# --- 4. Analysis / Modeling ---
from sklearn.module import Algorithm
model = Algorithm()
model.fit(X_train, y_train)

# --- 5. Visualization ---
fig, ax = plt.subplots(figsize=(10, 6))
sns.scatterplot(data=clean_df, x="feature", y="target", ax=ax)
ax.set_title("Tiêu đề biểu đồ")
ax.set_xlabel("Tên trục X")
ax.set_ylabel("Tên trục Y")
plt.tight_layout()
plt.show()

# --- 6. Evaluation ---
from sklearn.metrics import metric_function
score = metric_function(y_test, y_pred)
print(f"Metric: {score:.4f}")
```

## Lưu ý
- Code phải chạy được (executable)
- Comments bằng tiếng Anh
- Giải thích output bằng tiếng Việt
- Chia code thành các bước rõ ràng
- Sử dụng datasets phổ biến, dễ truy cập
