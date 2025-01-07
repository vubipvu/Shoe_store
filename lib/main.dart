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
      },
    );
  }
}

class ManHinhDangKy extends StatefulWidget {
  @override
  _ManHinhDangKyState createState() => _ManHinhDangKyState();
}

class _ManHinhDangKyState extends State<ManHinhDangKy> {
  int _selectedIndex = 0; // Theo dõi tab đã chọn

  // Danh sách các màn hình
  final List<Widget> _pages = [
    ProductListScreen(), // Trang chủ sản phẩm
    CartScreen(cartItems: []), // Giỏ hàng
  ];

  // Hàm xử lý khi người dùng chọn tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoe Store'),
      ),
      body: _pages[_selectedIndex], // Hiển thị trang tương ứng với tab đã chọn
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Icon cho Trang chủ
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // Icon cho Giỏ hàng
            label: 'Giỏ hàng',
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.yellow, // Màu nền của BottomNavigationBar
      ),
    );
  }
}