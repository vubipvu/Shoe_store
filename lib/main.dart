import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoe_shop/screens/home_screen.dart';
import 'package:shoe_shop/screens/login_screen.dart';
import 'package:shoe_shop/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo các plugin được khởi tạo

  // Lấy trạng thái màn hình khởi động
  final String initialScreen = await getInitialScreen();
  runApp(MyApp(initialScreen: initialScreen));
}

// Hàm kiểm tra trạng thái và xác định màn hình khởi động
Future<String> getInitialScreen() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  if (isLoggedIn) {
    return '/home';
  } else {
    return '/login'; // Hoặc '/register' nếu bạn muốn
  }
}

class MyApp extends StatelessWidget {
  final String initialScreen;

  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Shop',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: initialScreen, // Màn hình khởi động linh động
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
