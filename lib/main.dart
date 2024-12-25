import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'models/product.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/product_list_screen.dart';
import 'widgets/product_card.dart';
import 'models/cart_item.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final List<CartItem> cartItems = []; // Khởi tạo danh sách giỏ hàng rỗng

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(cartItems: cartItems),
    );
  }
}