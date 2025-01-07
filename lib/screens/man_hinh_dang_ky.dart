import 'package:flutter/material.dart';
import '../models/users.dart'; // Đảm bảo rằng bạn đã import đúng mô hình Users
import '../services/dich_vu_xac_thuc.dart'; // Đảm bảo rằng bạn đã import đúng dịch vụ xác thực

class ManHinhDangKy extends StatefulWidget {
  @override
  _ManHinhDangKyState createState() => _ManHinhDangKyState();
}

class _ManHinhDangKyState extends State<ManHinhDangKy> {
  final _linkAnhController = TextEditingController();
  final _tenController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _soDienThoaiController = TextEditingController();
  final _emailController = TextEditingController();

  bool _obscureText = true; // Ẩn mật khẩu

  // Hàm thay đổi trạng thái hiển thị mật khẩu
  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Hàm đăng ký
  void _dangKy() async {
    // Giả lập đăng ký thành công
    bool thanhCong = true; // Thay thế bằng logic thực tế của bạn (gọi API, lưu vào DB)

    if (thanhCong) {
      // Hiển thị thông báo đăng ký thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng ký thành công!')),
      );

      // Chờ trong 2 giây để người dùng có thể thấy thông báo
      await Future.delayed(Duration(seconds: 2));

      // Chuyển hướng sang màn hình đăng nhập
      Navigator.pushReplacementNamed(context, '/dang-nhap');
    } else {
      // Nếu đăng ký thất bại, hiển thị thông báo thất bại
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng ký thất bại!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ĐĂNG KÝ'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nhập link ảnh
              TextField(
                controller: _linkAnhController,
                decoration: InputDecoration(
                  labelText: 'Nhập link ảnh',
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Nhập tên
              TextField(
                controller: _tenController,
                decoration: InputDecoration(
                  labelText: 'Nhập họ tên',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Nhập username
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nhập username',
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Nhập password
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Nhập password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _togglePasswordView,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Nhập số điện thoại
              TextField(
                controller: _soDienThoaiController,
                decoration: InputDecoration(
                  labelText: 'Nhập số điện thoại',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Nhập email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Nút Đăng ký
              ElevatedButton(
                onPressed: _dangKy,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                  padding: EdgeInsets.all(16),
                ),
                child: Text(
                  'ĐĂNG KÝ',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
