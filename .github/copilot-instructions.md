---
applyTo: '**/*'
---
Instruction chung cho dự án BMLB (Quick read for Data Sciences) - Cung cấp nguyên tắc và quy tắc cơ bản mà AI phải tuân theo khi làm việc với dự án này.

# Quy tắc và Nguyên tắc chung cho Dự án BMLB

## 1. **Tổng quan Dự án**:
- **Tên dự án**: BMLB - Quick read for Data Sciences
- **Mô tả**: Tài liệu giảng dạy/học tập Data Science bằng tiếng Việt
- **Công nghệ chính**: Quarto website, Python, MSSQL
- **Triển khai**: GitHub Pages via GitHub Actions
- **URL**: https://nguyenngocbinh.github.io/bmlb
- **Repo**: https://github.com/nguyenngocbinh/bmlb

## 2. **Ngôn ngữ và Giao tiếp**:
- **Ngôn ngữ phản hồi**: Tất cả phản hồi, giải thích, tài liệu phải được viết bằng **tiếng Việt**
- **Ngôn ngữ code**: Tên variables, functions, classes, comments trong code phải sử dụng **tiếng Anh**
- **Nội dung bài giảng**: Viết bằng tiếng Việt, thuật ngữ chuyên ngành giữ nguyên tiếng Anh
- **Công thức toán**: Sử dụng KaTeX/LaTeX notation

## 3. **Nguyên tắc Thiết kế Code**:

### **SOLID Principles**:
- **S**ingle Responsibility: Mỗi class/function chỉ có một trách nhiệm duy nhất
- **O**pen/Closed: Mở cho extension, đóng cho modification
- **L**iskov Substitution: Subclasses phải có thể thay thế base classes
- **I**nterface Segregation: Tách biệt interfaces thành các phần nhỏ cụ thể
- **D**ependency Inversion: Phụ thuộc vào abstractions, không phải concrete implementations

### **Clean Code Principles**:
- **Readability**: Code phải dễ đọc và hiểu
- **Simplicity**: Giữ code đơn giản, tránh over-engineering
- **DRY** (Don't Repeat Yourself): Tránh duplicate code
- **KISS** (Keep It Simple, Stupid): Giữ mọi thứ đơn giản
- **YAGNI** (You Aren't Gonna Need It): Không implement tính năng chưa cần thiết

## 4. **Cấu trúc Dự án BMLB**:

### **Cấu trúc Thư mục**:
```
BMLB/
├── _quarto.yml           # Cấu hình Quarto website
├── index.qmd             # Trang chủ
├── 01-Introduction/      # Giới thiệu Data Science
├── 02-Data Manipulation/ # Xử lý dữ liệu (pandas, numpy)
├── 03-Data Visualization/# Trực quan hóa dữ liệu
├── 04-Basic Statistics/  # Thống kê cơ bản
├── 05-Regression/        # Mô hình hồi quy
├── 06-Timeseries/        # Chuỗi thời gian
├── 07-Panel Data Models/ # Mô hình dữ liệu bảng
├── 08-Machine Learning/  # Học máy
├── 09-Model Deployment/  # Triển khai mô hình
├── 10-Publication/       # Xuất bản báo cáo
├── 11-Git/               # Version control
├── 12-Docker/            # Containerization
├── 13-Database/          # Cơ sở dữ liệu
├── 14-Web Craping/       # Web scraping
├── 15-Blogdown/          # Tạo blog
├── 99-Practice/          # Bài thực hành
├── dev/                  # Templates
└── images/               # Hình ảnh
```

### **Quy tắc Đặt tên File**:
- README.md: File chính cho mỗi chapter
- File .qmd: Tài liệu Quarto
- File .md: Tài liệu Markdown thuần
- File .py: Script Python
- File .ipynb: Jupyter Notebook

### **Quy tắc Thêm Chapter Mới**:
1. Tạo thư mục với format `XX-Tên Chapter/`
2. Tạo README.md làm trang chính
3. Cập nhật `_quarto.yml` sidebar contents
4. Cập nhật README.md gốc với mô tả chapter

## 5. **Documentation Principles**:

### **Viết Nội dung Bài giảng**:
- Mỗi chapter bắt đầu với heading level 1 (`#`)
- Giải thích khái niệm trước, rồi đến ví dụ code
- Sử dụng code blocks với language tag (`python`, `sql`, `bash`)
- Công thức toán dùng KaTeX: inline `$formula$`, block `$$formula$$`
- Thêm ví dụ thực tế minh họa cho mỗi khái niệm

### **Code Examples**:
- Luôn thêm comments giải thích trong code (tiếng Anh)
- Sử dụng **Python** là ngôn ngữ duy nhất cho code examples
- Database: sử dụng **MSSQL** (Microsoft SQL Server) làm hệ quản trị CSDL chính
- Sử dụng datasets phổ biến (scikit-learn, seaborn, statsmodels built-in datasets)
- Output phải được hiển thị rõ ràng

## 6. **Version Control Principles**:

### **Git Commit Convention**:
```
[type]: mô tả thay đổi bằng tiếng Việt

Types:
- feat: thêm tính năng mới / chapter mới
- fix: sửa lỗi nội dung hoặc code
- docs: cập nhật documentation
- style: thay đổi formatting
- refactor: tái cấu trúc nội dung
- chore: cập nhật build tools, dependencies
```

## 7. **Security Principles**:
- **Không commit**: Passwords, API keys, sensitive data
- **Environment variables**: Sử dụng .env files cho config
- **.gitignore**: Đảm bảo ignore các file nhạy cảm

## 8. **Performance & Quality**:
- **Code kiểm tra**: Đảm bảo tất cả code snippets chạy được
- **Links hợp lệ**: Kiểm tra tất cả hyperlinks
- **Hình ảnh tối ưu**: Compress hình ảnh trước khi commit
- **Quarto render**: Test render locally trước khi push
