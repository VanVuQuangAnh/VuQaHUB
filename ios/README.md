# Dự án iOS

## Chạy bằng Xcode

1. Trên máy Mac có Xcode 15 trở lên, mở `VanChuongPhieuLuuKy.xcodeproj`.
2. Chọn target `VanChuongPhieuLuuKy`, đặt Apple Development Team trong **Signing & Capabilities**, rồi chạy trên Simulator hoặc thiết bị đã đăng ký.
3. Giữ `index.html` và các ảnh/âm thanh ở thư mục gốc của repository. Build phase sẽ chép chúng vào ứng dụng.

## Build bằng Codemagic

`codemagic.yaml` nằm ở thư mục gốc repository. Đưa cả thư mục `ios`, file YAML, `index.html` và các tài nguyên web lên đúng repository/branch đang kết nối với Codemagic, sau đó chọn **Check for configuration files**.

Workflow `ios-app-store` cần Apple Developer Program và signing identity/profile loại **App Store** đã cấu hình trong Codemagic. Workflow tạo IPA để tải về hoặc đưa lên App Store Connect/TestFlight; IPA App Store không cài trực tiếp bằng ứng dụng Files. Muốn cài thử trên iPhone, dùng Xcode với Development signing hoặc cấu hình Ad Hoc signing và đăng ký thiết bị.
