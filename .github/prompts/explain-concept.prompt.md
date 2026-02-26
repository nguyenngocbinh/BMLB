---
description: 'Giải thích khái niệm thống kê/toán học với công thức KaTeX'
---
# Giải thích Khái niệm Thống kê / Toán học

## Mô tả
Sử dụng prompt này để tạo giải thích chi tiết cho một khái niệm thống kê hoặc toán học, bao gồm công thức KaTeX, ví dụ trực quan, và code minh họa.

## Yêu cầu đầu vào
- Tên khái niệm (ví dụ: "Linear Regression", "Bayes' Theorem", "ANOVA")
- Mức độ chi tiết (cơ bản / trung cấp / nâng cao)

## Template Giải thích

```markdown
## [Tên Khái niệm]

### Định nghĩa
[Giải thích bằng tiếng Việt, giữ thuật ngữ tiếng Anh]

### Công thức

$$
\text{Công thức chính}
$$

Trong đó:
- $\text{biến 1}$: Giải thích...
- $\text{biến 2}$: Giải thích...

### Trực giác (Intuition)
Giải thích ý tưởng đằng sau công thức bằng ngôn ngữ đơn giản...

### Ví dụ Tính toán
Cho dữ liệu: $x = \{x_1, x_2, ..., x_n\}$

Bước 1: ...
Bước 2: ...
Kết quả: ...

### Code Minh họa

` ` `python
# Compute [concept]
result = function_name(data)
` ` `

### Ứng dụng
- Lĩnh vực 1: mô tả...
- Lĩnh vực 2: mô tả...

### Lưu ý / Giả định
- Điều kiện 1...
- Điều kiện 2...
```

## Quy tắc Viết Công thức
1. **Inline**: `$\mu$`, `$\sigma^2$`, `$\hat{\beta}$`
2. **Block**: `$$...$$` cho công thức dài
3. **Ký hiệu chuẩn**: Theo convention thống kê quốc tế
4. **Giải thích ký hiệu**: Luôn giải thích mỗi ký hiệu trong công thức
5. **Từng bước**: Trình bày từng bước derivation khi cần thiết
