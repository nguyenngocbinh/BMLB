---
description: 'Viết bài giảng trực quan hóa dữ liệu với matplotlib/seaborn/plotly'
---
# Viết bài giảng Data Visualization với Python

Viết nội dung bài giảng cho chapter **03-Data Visualization** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Matplotlib cơ bản
```python
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(10, 6))
ax.plot(x, y, marker="o", label="Series 1")
ax.set_title("Tiêu đề biểu đồ")
ax.set_xlabel("Trục X")
ax.set_ylabel("Trục Y")
ax.legend()
plt.tight_layout()
plt.show()
```

### 2. Seaborn (statistical visualization)
```python
import seaborn as sns

# Categorical
sns.barplot(data=df, x="category", y="value", hue="group")
sns.boxplot(data=df, x="category", y="value")
sns.violinplot(data=df, x="category", y="value")
sns.countplot(data=df, x="category")

# Distribution
sns.histplot(data=df, x="value", kde=True, bins=30)
sns.kdeplot(data=df, x="value", hue="group")

# Relationship
sns.scatterplot(data=df, x="x", y="y", hue="group", size="value")
sns.lineplot(data=df, x="date", y="value", hue="group")
sns.heatmap(df.corr(), annot=True, cmap="coolwarm", fmt=".2f")

# Regression
sns.regplot(data=df, x="x", y="y")
sns.lmplot(data=df, x="x", y="y", hue="group", col="category")

# Pairwise
sns.pairplot(df, hue="species", diag_kind="kde")
```

### 3. Plotly (interactive charts)
```python
import plotly.express as px

fig = px.scatter(df, x="x", y="y", color="group", size="value",
                 hover_data=["name"], title="Interactive Scatter")
fig.show()

fig = px.line(df, x="date", y="value", color="category")
fig.show()

fig = px.bar(df, x="category", y="value", color="group", barmode="group")
fig.show()
```

### 4. Subplots & Multiple Axes
```python
fig, axes = plt.subplots(2, 2, figsize=(14, 10))
sns.histplot(df["col1"], ax=axes[0, 0])
sns.boxplot(data=df, x="cat", y="val", ax=axes[0, 1])
sns.scatterplot(data=df, x="x", y="y", ax=axes[1, 0])
sns.heatmap(corr_matrix, ax=axes[1, 1], annot=True)
plt.tight_layout()
plt.show()
```

### 5. Customization
```python
# Theme / Style
sns.set_theme(style="whitegrid", palette="Set2", font_scale=1.2)
plt.rcParams["font.family"] = "DejaVu Sans"
plt.rcParams["figure.dpi"] = 150

# Color palettes
sns.color_palette("husl", 8)
sns.color_palette("coolwarm", as_cmap=True)
```

## Loại biểu đồ theo mục đích
| Mục đích | Biểu đồ |
|----------|---------|
| Phân phối | `histplot`, `kdeplot`, `boxplot`, `violinplot` |
| So sánh | `barplot`, `countplot`, `boxplot` |
| Quan hệ | `scatterplot`, `regplot`, `heatmap` |
| Xu hướng | `lineplot`, `relplot` |
| Thành phần | `pie` (matplotlib), `sunburst` (plotly) |

## Quy tắc
- Mỗi biểu đồ phải có title, xlabel, ylabel bằng tiếng Việt
- Luôn dùng `plt.tight_layout()` trước `plt.show()`
- Ưu tiên seaborn cho statistical plots, plotly cho interactive
- Dataset: `seaborn.load_dataset("tips")`, `seaborn.load_dataset("penguins")`, `seaborn.load_dataset("iris")`
