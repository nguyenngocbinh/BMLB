---
description: 'Viết bài giảng Data Science với format chuẩn Python'
---
# Viết Bài Giảng Data Science

## Mô tả
Sử dụng prompt này để viết một bài giảng/tài liệu mới cho dự án BMLB theo format chuẩn.

## Format Bài giảng Chuẩn

```markdown
# Tiêu đề Bài giảng

> Tóm tắt ngắn gọn nội dung bài giảng.

## 1. Giới thiệu
Giải thích khái niệm tổng quan bằng tiếng Việt...

## 2. Lý thuyết

### 2.1. Khái niệm cơ bản
Mô tả chi tiết...

### 2.2. Công thức toán
$$
\text{Công thức chính}
$$

Trong đó:
- $x$: mô tả biến...
- $y$: mô tả biến...

## 3. Ví dụ Thực hành

` ` `python
# Load required packages
import pandas as pd
import numpy as np

# Code example with comments
data = pd.read_csv("example_data.csv")
` ` `

## 4. Kết quả và Giải thích
Phân tích output, giải thích ý nghĩa...

## 5. Ứng dụng Thực tế
Ví dụ áp dụng trong thực tế...

## 6. Bài tập
1. Bài tập 1...
2. Bài tập 2...

## 7. Tài liệu Tham khảo
- [Reference 1](url)
```

## Quy tắc Viết
1. **Ngôn ngữ**: Tiếng Việt, thuật ngữ chuyên ngành giữ tiếng Anh
2. **Code comments**: Tiếng Anh
3. **Công thức**: KaTeX notation (`$...$` inline, `$$...$$` block)
4. **Python only**: Chỉ sử dụng Python cho code examples
5. **Datasets**: Sử dụng datasets built-in (scikit-learn, seaborn, statsmodels)
6. **Giải thích**: Luôn giải thích output/kết quả bằng tiếng Việt
