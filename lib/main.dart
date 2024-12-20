import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo khởi tạo trước khi chạy ứng dụng
  await Firebase.initializeApp(); // Khởi tạo Firebase
  runApp(ShoeShopApp());
}

class ShoeShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Shop',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(), // Trang bắt đầu
    );
  }
}
