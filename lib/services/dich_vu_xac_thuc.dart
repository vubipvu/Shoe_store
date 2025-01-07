import '../database/database_helper.dart';
import '../models/users.dart';

class DichVuXacThuc {
  // Hàm đăng ký người dùng
  Future<bool> dangKy(Users nguoiDung) async {
    try {
      // Giả lập việc đăng ký, bạn có thể thay thế phần này bằng gọi API thật sự
      print('Đang đăng ký người dùng: ${nguoiDung.username}');

      // Giả sử đăng ký thành công, trả về true
      return true;
    } catch (e) {
      // Xử lý lỗi
      print('Đăng ký thất bại: $e');
      return false;
    }
  }
  Future<bool> dangNhap(String tenDangNhap, String matKhau) async {
    // Mô phỏng đăng nhập, bạn có thể thay bằng gọi API thực tế
    await Future.delayed(Duration(seconds: 2)); // Giả lập thời gian chờ

    // Kiểm tra nếu tên đăng nhập và mật khẩu chính xác
    if (tenDangNhap == "admin" && matKhau == "admin123") {
      return true; // Đăng nhập thành công
    } else {
      return false; // Đăng nhập thất bại
    }
  }

}