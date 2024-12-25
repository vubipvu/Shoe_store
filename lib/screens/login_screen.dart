import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> loginUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Text(
                'Shoe store',
                style: TextStyle(
                  fontFamily: 'Billabong', // Font tương tự Instagram
                  fontSize: 50,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50),

              // Email TextField
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              SizedBox(height: 15),

              // Password TextField
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Mật khẩu',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // Login Button
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Đăng Nhập', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 15),

              // Error Message
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.green),
                ),

              // "Forgot Password" and Register Button
              TextButton(
                onPressed: () {},
                child: Text(
                  'Quên mật khẩu?',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              SizedBox(height: 20),

              // Create Account Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn chưa có tài khoản? ',
                    style: TextStyle(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: navigateToRegister,
                    child: Text(
                      'Đăng ký ngay',
                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
