# Văn chương phiêu lưu ký — iOS

## Upload lên GitHub và chạy Codemagic

Workflow nhận dự án theo một trong các cấu trúc sau:

- Dự án `ios/` trực tiếp ở gốc repository.
- Toàn bộ dự án nằm trong thư mục `VanChuongPhieuLuuKy-iOS-source/` ở gốc.
- Hai file `codemagic.yaml` và `VanChuongPhieuLuuKy-iOS-source.zip` cùng nằm ở gốc; workflow sẽ tự giải nén ZIP.

Sau khi cập nhật, commit và push lên nhánh Codemagic theo dõi. Trong Codemagic, chọn nhánh đó và bấm **Check for configuration files**.

- `ios-unsigned` build rồi đóng gói IPA **không ký**; không cần provisioning profile nhưng iPhone không thể cài gói này.
- `ios-app-store` tạo IPA đã ký để đưa lên App Store Connect/TestFlight; cần cấu hình signing trước.

Workflow tự giải nén mã nguồn, dùng dự án `ios/VanChuongPhieuLuuKy.xcodeproj` và đóng gói `index.html` cùng ảnh/âm thanh ở thư mục gốc của gói nguồn.

## Ký và cài ứng dụng

Workflow cần Apple Developer Program và Apple Distribution certificate cùng App Store provisioning profile trong Codemagic cho bundle ID `vn.edu.vanchuongphieuluuky`. IPA App Store dùng cho App Store Connect/TestFlight. Cài trực tiếp lên thiết bị cần Development hoặc Ad Hoc signing và đăng ký thiết bị.

Không đưa certificate, provisioning profile, API key hay mật khẩu ký lên GitHub. Máy Windows chỉ chuẩn bị mã nguồn; Codemagic build IPA trên macOS.
