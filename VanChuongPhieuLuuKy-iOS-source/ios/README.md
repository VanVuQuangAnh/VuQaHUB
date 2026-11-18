# Dự án iOS

## Chạy bằng Xcode

1. Trên máy Mac có Xcode 15 trở lên, mở `VanChuongPhieuLuuKy.xcodeproj`.
2. Chọn target `VanChuongPhieuLuuKy`, đặt Apple Development Team trong **Signing & Capabilities**, rồi chạy trên Simulator hoặc thiết bị đã đăng ký.
3. Giữ `index.html` và các ảnh/âm thanh ở thư mục gốc của repository. Build phase sẽ chép chúng vào ứng dụng.

## Build bằng Codemagic

`codemagic.yaml` nằm ở thư mục gốc repository. Đưa cả thư mục `ios`, file YAML, `index.html` và các tài nguyên web lên đúng repository/branch đang kết nối với Codemagic, sau đó chọn **Check for configuration files**.

Workflow `ios-testflight` cần Apple Developer Program và signing identity/profile loại **App Store** đã cấu hình trong Codemagic. Tạo nhóm biến môi trường `app_store_connect_credentials` gồm `APP_STORE_CONNECT_PRIVATE_KEY`, `APP_STORE_CONNECT_KEY_IDENTIFIER` và `APP_STORE_CONNECT_ISSUER_ID` để Codemagic tải build lên TestFlight. Sau khi Apple xử lý/duyệt build, thêm người thử nghiệm hoặc tạo public link trong App Store Connect → **TestFlight**. IPA App Store không cài trực tiếp bằng ứng dụng Files.
