// lib/main.dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_add_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'models/cart_item.dart';
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
      home: ProductListScreen(),
    );
  }
}
