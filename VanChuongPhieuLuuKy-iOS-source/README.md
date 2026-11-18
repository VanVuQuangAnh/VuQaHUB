# Văn chương phiêu lưu ký — iOS

## Upload lên GitHub và chạy Codemagic

Workflow nhận dự án theo một trong các cấu trúc sau:

- Dự án `ios/` trực tiếp ở gốc repository.
- Toàn bộ dự án nằm trong thư mục `VanChuongPhieuLuuKy-iOS-source/` ở gốc.
- Hai file `codemagic.yaml` và `VanChuongPhieuLuuKy-iOS-source.zip` cùng nằm ở gốc; workflow sẽ tự giải nén ZIP.

Sau khi cập nhật, commit và push lên nhánh Codemagic theo dõi. Trong Codemagic, chọn nhánh đó và bấm **Check for configuration files**.

- `ios-testflight` tạo IPA đã ký và tải build lên App Store Connect/TestFlight.

Workflow tự giải nén mã nguồn, dùng dự án `ios/VanChuongPhieuLuuKy.xcodeproj` và đóng gói `index.html` cùng ảnh/âm thanh ở thư mục gốc của gói nguồn.

## Ký và cài ứng dụng

Workflow cần Apple Developer Program và Apple Distribution certificate cùng App Store provisioning profile trong Codemagic cho bundle ID `vn.edu.vanchuongphieuluuky`. Trong Codemagic, tạo nhóm biến môi trường `app_store_connect_credentials` gồm các biến bí mật `APP_STORE_CONNECT_PRIVATE_KEY`, `APP_STORE_CONNECT_KEY_IDENTIFIER` và `APP_STORE_CONNECT_ISSUER_ID`, rồi cấu hình certificate/profile loại App Store trong **Code signing identities**.

Workflow tải build lên TestFlight và gửi cho beta review. Sau khi Apple xử lý/duyệt build, thêm người thử nghiệm hoặc tạo public link trong App Store Connect → **TestFlight**. IPA App Store không cài trực tiếp bằng ứng dụng Files; người thử nghiệm cài qua TestFlight.

Không đưa certificate, provisioning profile, API key hay mật khẩu ký lên GitHub. Máy Windows chỉ chuẩn bị mã nguồn; Codemagic build IPA trên macOS.
