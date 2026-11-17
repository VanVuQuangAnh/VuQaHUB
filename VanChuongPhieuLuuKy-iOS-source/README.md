# Văn chương phiêu lưu ký — iOS

## Upload lên GitHub và chạy Codemagic

Nếu GitHub không tiện tải thư mục lồng nhau:

1. Giải nén `Codemagic-GitHub-upload.zip` trên máy tính.
2. Tải hai file bên trong lên **gốc repository GitHub**: `codemagic.yaml` và `VanChuongPhieuLuuKy-iOS-source.zip`. Không tải nguyên file upload ZIP lên repository.
3. Commit và push lên nhánh Codemagic đang theo dõi.
4. Trong Codemagic, chọn nhánh đó và bấm **Check for configuration files**.

- `ios-unsigned` build rồi đóng gói IPA **không ký**; không cần provisioning profile nhưng iPhone không thể cài gói này.
- `ios-app-store` tạo IPA đã ký để đưa lên App Store Connect/TestFlight; cần cấu hình signing trước.

Workflow tự giải nén mã nguồn, dùng dự án `ios/VanChuongPhieuLuuKy.xcodeproj` và đóng gói `index.html` cùng ảnh/âm thanh ở thư mục gốc của gói nguồn.

## Ký và cài ứng dụng

Workflow cần Apple Developer Program và Apple Distribution certificate cùng App Store provisioning profile trong Codemagic cho bundle ID `vn.edu.vanchuongphieuluuky`. IPA App Store dùng cho App Store Connect/TestFlight. Cài trực tiếp lên thiết bị cần Development hoặc Ad Hoc signing và đăng ký thiết bị.

Không đưa certificate, provisioning profile, API key hay mật khẩu ký lên GitHub. Máy Windows chỉ chuẩn bị mã nguồn; Codemagic build IPA trên macOS.
