---
applyTo: '**/*.qmd,**/*.yml,_quarto.yml'
---
# Hướng dẫn Quarto cho Dự án BMLB

## Tổng quan
Dự án BMLB sử dụng **Quarto** để xây dựng website tài liệu học tập Data Science. Website được triển khai lên GitHub Pages.

## Cấu hình Quarto (`_quarto.yml`)

### Cấu trúc Website:
- **Project type**: `website`
- **Site URL**: `https://nguyenngocbinh.github.io/bmlb`
- **Theme**: `cosmo` (light/dark mode)
- **Sidebar**: Docked, có search, collapse-level 1

### Khi thêm chapter mới vào sidebar:
```yaml
# Format thêm section mới:
- section: XX-Chapter Name/README.md
  contents:
    - XX-Chapter Name/sub-topic.md
    - XX-Chapter Name/sub-topic.qmd
```

### Quy tắc YAML Front Matter:
```yaml
---
title: "Tiêu đề bài giảng bằng tiếng Việt"
---
```

## Quy tắc Viết Nội dung `.qmd`:
1. **Heading cấp 1** (`#`) cho tiêu đề chính của chapter
2. **Heading cấp 2** (`##`) cho các mục con
3. **Code blocks** phải có language tag: ` ```python `, ` ```sql `, ` ```bash `
4. **Công thức toán**: Inline `$...$`, Block `$$...$$`
5. **Hình ảnh**: Đặt trong thư mục `images/` hoặc thư mục chapter tương ứng
6. **Cross-references**: Sử dụng relative paths

## Code Cells trong Quarto:
```
# Python code cell
{python}
#| label: ten-code-chunk
#| echo: true
#| warning: false
import pandas as pd
```

## Render và Preview:
- **Local preview**: `quarto preview`
- **Render toàn bộ**: `quarto render`
- **Render 1 file**: `quarto render filename.qmd`

## Deployment:
- Sử dụng GitHub Actions (`.github/workflows/quarto-publish.yml`)
- Branch `main` → tự động render và publish lên `gh-pages`
