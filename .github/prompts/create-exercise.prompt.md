---
description: 'Tạo bài tập thực hành Data Science'
---
# Tạo Bài tập Thực hành Data Science

## Mô tả
Sử dụng prompt này để tạo bài tập thực hành cho sinh viên/người học, đặt trong thư mục `99-Practice/`.

## Yêu cầu đầu vào
- Chủ đề bài tập (liên quan chapter nào)
- Mức độ khó (cơ bản / trung cấp / nâng cao)

## Template Bài tập

```markdown
# Bài tập: [Tên bài tập]

> **Chủ đề**: [Chapter liên quan]
> **Mức độ**: ⭐ Cơ bản / ⭐⭐ Trung cấp / ⭐⭐⭐ Nâng cao
> **Thời gian dự kiến**: XX phút

## Mục tiêu
Sau khi hoàn thành bài tập này, bạn sẽ:
1. Hiểu được...
2. Biết cách...
3. Áp dụng được...

## Dataset
- **Tên**: [Dataset name]
- **Nguồn**: [Built-in hoặc URL download]
- **Mô tả**: Mô tả ngắn...

## Yêu cầu

### Phần 1: Khám phá Dữ liệu (EDA)
1. Load dataset và hiển thị 5 dòng đầu tiên
2. Kiểm tra kiểu dữ liệu và missing values
3. Tạo summary statistics

### Phần 2: Xử lý Dữ liệu
4. Xử lý missing values
5. Tạo feature mới
6. Lọc dữ liệu theo điều kiện

### Phần 3: Phân tích / Mô hình
7. Xây dựng mô hình
8. Đánh giá kết quả
9. Trực quan hóa kết quả

### Phần 4: Bonus (Nâng cao)
10. Câu hỏi mở rộng...

## Gợi ý
<details>
<summary>Gợi ý cho câu 1</summary>
Sử dụng `df.head()` trong Python.
</details>

## Đáp án Tham khảo
[Cung cấp đáp án trong file riêng hoặc collapsible section]
```

## Quy tắc Tạo Bài tập
1. **Thực tế**: Sử dụng datasets và scenarios thực tế
2. **Tiến trình**: Từ dễ đến khó
3. **Rõ ràng**: Yêu cầu cụ thể, không mơ hồ
4. **Python**: Sử dụng Python làm ngôn ngữ duy nhất
5. **Gợi ý**: Cung cấp hints cho câu khó
6. **Đáp án**: Có đáp án tham khảo
