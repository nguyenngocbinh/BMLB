## Thống kê

### Nhóm đặc trưng trung tâm

- **Trung bình (Mean)**: Là giá trị trung bình của một tập dữ liệu và được ký hiệu là $\mu$. Trung bình được tính bằng công thức:

  $$\mu = \frac{\sum_{i=1}^{n} x_i}{n}$$

  Trong đó:
  - $\mu$ là giá trị trung bình.
  - $x_i$ là các giá trị trong tập dữ liệu.
  - $n$ là số lượng các giá trị trong tập dữ liệu.

- **Trị số xuất hiện nhiều nhất (Mode)**: Là giá trị xuất hiện nhiều nhất trong tập dữ liệu, tức là giá trị có tần suất lặp lại cao nhất.

- **Trung vị (Median)**: Là giá trị ở vị trí giữa của dữ liệu đã được sắp xếp theo thứ tự tăng dần hoặc giảm dần. Nó chia tập dữ liệu thành hai phần bằng nhau, với một nửa các giá trị nằm bên trái và một nửa nằm bên phải.

### Các đặc trưng về độ phân tán

- **Phương sai (Variance)**: Đo lường sự biến động của dữ liệu và được ký hiệu là $\sigma^2$. Phương sai được tính bằng công thức:

  $$\sigma^2 = \frac{\sum_{i=1}^{n} (x_i - \mu)^2}{n}$$

- **Độ lệch tiêu chuẩn (Standard Deviation)**: Là căn bậc hai của phương sai và được ký hiệu là $\sigma$. Độ lệch tiêu chuẩn được tính bằng công thức:

  $$\sigma = \sqrt{\sigma^2}$$

- **Sai số trung bình tuyệt đối (ASD hoặc MAD - Mean Absolute Deviation)**: Là trung bình của giá trị tuyệt đối của sự sai khác giữa mỗi giá trị dữ liệu và trung bình, và được tính bằng công thức:

  $$\text{ASD} = \frac{\sum_{i=1}^{n} |x_i - \mu|}{n}$$

- **Tứ phân vị và khoảng tứ phân vị (Interquartile Range - IQR)**: Tứ phân vị chia tập dữ liệu thành bốn phần bằng nhau. Khoảng tứ phân vị là sự chênh lệch giữa tứ phân vị thứ ba và tứ phân vị thứ nhất, và được tính bằng công thức:

  $$\text{IQR} = Q3 - Q1$$

  Trong đó:
  - $\text{IQR}$ là khoảng tứ phân vị.
  - $Q1$ là tứ phân vị thứ nhất (25th percentile).
  - $Q3$ là tứ phân vị thứ ba (75th percentile).

- **Khoảng biến thiên (Range)**: Là sự chênh lệch giữa giá trị lớn nhất và giá trị nhỏ nhất trong tập dữ liệu.

- **Hạng của dãy quan sát (Rank)**: Là thứ tự của giá trị dữ liệu khi chúng được sắp xếp theo thứ tự tăng dần hoặc giảm dần.

- **Hệ số biến thiên (Coefficient of Variation)**: Là tỷ lệ giữa độ lệch tiêu chuẩn và trung bình, và được tính bằng công thức:

  $$\text{Coefficient of Variation} = \frac{\sigma}{\mu}$$

Các công thức trên giúp tính toán các đặc trưng thống kê và mô tả tính trung bình và tính biến động của tập dữ liệu trong phân tích thống kê.
