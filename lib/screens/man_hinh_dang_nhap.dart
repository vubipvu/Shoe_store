import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Thêm thư viện
import '../services/dich_vu_xac_thuc.dart'; // Import dịch vụ xác thực
import 'product_list_screen.dart'; // Import màn hình danh sách sản phẩm
import 'package:shoe_store/screens/man_hinh_dang_ky.dart';

class ManHinhDangNhap extends StatefulWidget {
  @override
  _ManHinhDangNhapState createState() => _ManHinhDangNhapState();
}

class _ManHinhDangNhapState extends State<ManHinhDangNhap> {
  final _tenDangNhapController = TextEditingController();
  final _matKhauController = TextEditingController();
  final DichVuXacThuc _dichVuXacThuc = DichVuXacThuc(); // Khởi tạo dịch vụ xác thực

  // Hàm đăng nhập
  void _dangNhap() async {
    bool thanhCong = await _dichVuXacThuc.dangNhap(
      _tenDangNhapController.text,
      _matKhauController.text,
    );

    // Hiển thị thông báo tùy thuộc vào kết quả đăng nhập
    if (thanhCong) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thành công!')),
      );

      // Chuyển hướng đến màn hình danh sách sản phẩm
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng Nhập'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/images/tải xuống.jpg', width: 120),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _tenDangNhapController,
              decoration: InputDecoration(
                labelText: 'Tên đăng nhập',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _matKhauController,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _dangNhap,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.orange,
              ),
              child: Text(
                'Đăng Nhập',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManHinhDangKy()),
                  );
                },
                child: Text(
                  'Chưa có tài khoản? Đăng ký ngay!',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}