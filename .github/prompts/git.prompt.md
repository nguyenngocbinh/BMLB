---
description: 'Viết bài giảng Git & GitHub cho Data Science projects'
---
# Viết bài giảng Git & GitHub

Viết nội dung bài giảng cho chapter **11-Git** trong dự án BMLB.

## Phạm vi Nội dung

### 1. Git cơ bản
```bash
# Khởi tạo
git init
git clone https://github.com/user/repo.git

# Workflow cơ bản
git status
git add .                    # Stage tất cả
git add file.py              # Stage 1 file
git commit -m "feat: thêm tính năng mới"
git push origin main

# Xem lịch sử
git log --oneline --graph
git diff
git diff --staged
```

### 2. Branching & Merging
```bash
# Tạo và chuyển branch
git branch feature/new-chapter
git checkout -b feature/new-chapter   # Tạo + chuyển

# Merge
git checkout main
git merge feature/new-chapter
git branch -d feature/new-chapter     # Xóa branch đã merge

# Rebase (nâng cao)
git checkout feature-branch
git rebase main
```

### 3. Xử lý xung đột (Conflict Resolution)
```bash
# Khi merge conflict xảy ra:
# 1. Mở file bị conflict
# 2. Tìm và sửa markers: <<<<<<< ======= >>>>>>>
# 3. Stage và commit
git add conflicted_file.py
git commit -m "fix: giải quyết conflict"
```

### 4. Git cho Data Science
```bash
# .gitignore cho Python DS project
echo "__pycache__/" >> .gitignore
echo "*.pyc" >> .gitignore
echo ".env" >> .gitignore
echo "data/" >> .gitignore
echo ".ipynb_checkpoints/" >> .gitignore
echo "_site/" >> .gitignore
echo ".quarto/" >> .gitignore

# Large files → Git LFS
git lfs install
git lfs track "*.csv"
git lfs track "*.parquet"
```

### 5. GitHub Workflow
```bash
# Fork → Clone → Branch → Commit → Push → Pull Request

# Pull Request flow
git checkout -b feature/add-ml-chapter
# ... code changes ...
git add .
git commit -m "feat: thêm chapter Machine Learning"
git push origin feature/add-ml-chapter
# → Mở Pull Request trên GitHub
```

### 6. GitHub Actions (CI/CD)
```yaml
# .github/workflows/quarto-publish.yml
on:
  push:
    branches: main
jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: quarto-dev/quarto-actions/setup@v2
      - uses: actions/setup-python@v5
        with:
          python-version: "3.11"
      - run: pip install -r requirements.txt
      - uses: quarto-dev/quarto-actions/publish@v2
        with:
          target: gh-pages
```

### 7. Commit Convention
```
feat: thêm chapter mới về Machine Learning
fix: sửa lỗi công thức regression
docs: cập nhật README với mô tả mới
style: format lại code theo PEP 8
refactor: tái cấu trúc chapter Statistics
chore: cập nhật dependencies
```

## Quy tắc
- Commit messages bằng tiếng Việt (phần mô tả), prefix tiếng Anh
- Branch names bằng tiếng Anh, dùng kebab-case
- KHÔNG commit data files, credentials, `.env`
