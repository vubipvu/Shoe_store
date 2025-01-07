class Users {
  final int? id; // ID tự tăng
  final String username; // Tên đăng nhập
  final String email; // Email
  final String password; // Mật khẩu

  Users({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  // Chuyển từ Map sang object Users
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Chuyển object Users sang Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
