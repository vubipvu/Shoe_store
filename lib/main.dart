// lib/main.dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_add_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'models/cart_item.dart';
import 'models/shipping_info.dart';
import 'screens/ShippingInfoScreen.dart';
import 'package:shoe_store/models/users.dart';
import 'screens/man_hinh_dang_ky.dart';
import 'screens/man_hinh_dang_nhap.dart';
import 'services/dich_vu_xac_thuc.dart';
import 'widgets/nut_tuy_chinh.dart';
import 'models/users.dart';
import 'screens/home_screen.dart';
import 'screens/user_list_screen.dart';
import 'screens/rules_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/feedback_list_screen.dart';
void main() async {
  // Đảm bảo Flutter bindings được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Store',
      home: HomeScreen(), // Chạy màn hình đăng ký đầu tiên
      debugShowCheckedModeBanner: false,
      routes: {
        '/dang-nhap': (context) => ManHinhDangNhap(), // Đăng nhập
        '/dang-ky': (context) => ManHinhDangKy(), // Đăng ký
        '/product-list': (context) => ProductListScreen(), // Màn hình sản phẩm
        '/cart': (context) => CartScreen(cartItems: []), // Giỏ hàng
        '/rules': (context) => RulesScreen(), // Thêm trang Quy định
        '/feedback': (context) => AddFeedbackScreen(),
        '/feedback-list': (context) => FeedbackScreen(), // Danh sách phản hồi

      },
    );
  }
}

