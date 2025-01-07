class Users {
  final String tenDangNhap;
  final String matKhau;
  final String email;
  final String soDienThoai;

  Users({
    required this.tenDangNhap,
    required this.matKhau,
    required this.email,
    required this.soDienThoai,
  });

  // Chuyển đối tượng thành JSON để truyền dữ liệu
  Map<String, dynamic> toJson() {
    return {
      'tenDangNhap': tenDangNhap,
      'matKhau': matKhau,
      'email': email,
      'soDienThoai': soDienThoai,
    };
  }

  // Hàm khởi tạo từ JSON
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      tenDangNhap: json['tenDangNhap'],
      matKhau: json['matKhau'],
      email: json['email'],
      soDienThoai: json['soDienThoai'],
    );
  }
}
