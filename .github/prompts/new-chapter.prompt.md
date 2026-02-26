---
description: 'Tạo chapter mới cho dự án BMLB với đầy đủ cấu trúc'
---
# Tạo Chapter Mới cho BMLB

## Mô tả
Sử dụng prompt này để tạo một chapter mới cho dự án BMLB (Quick read for Data Sciences).

## Yêu cầu đầu vào
- Số thứ tự chapter (XX)
- Tên chapter (tiếng Anh)
- Mô tả ngắn (tiếng Việt)

## Các bước thực hiện

### Bước 1: Tạo thư mục và file README.md
Tạo thư mục `XX-Tên Chapter/` và file `README.md` bên trong:

```markdown
# XX-Tên Chapter

> Mô tả ngắn gọn bằng tiếng Việt về nội dung chapter.

## Nội dung

### 1. Chủ đề con 1
- Giải thích khái niệm...

### 2. Chủ đề con 2
- Giải thích khái niệm...

## Tài liệu Tham khảo
- [Link 1](url)
- [Link 2](url)
```

### Bước 2: Cập nhật `_quarto.yml`
Thêm section mới vào sidebar contents:
```yaml
- section: XX-Tên Chapter/README.md
```

### Bước 3: Cập nhật `README.md` gốc
Thêm mô tả chapter mới vào file README.md ở thư mục gốc:
```markdown
## XX-Tên Chapter
- Mô tả 1
- Mô tả 2
- Mô tả 3
```

### Bước 4: Cập nhật `index.qmd`
Thêm mô tả chapter vào trang chủ.
