import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> registerUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_passwordController.text != _confirmPasswordController.text) {
        throw FirebaseAuthException(
          message: 'Mật khẩu không khớp!',
          code: 'password-mismatch',
        );
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
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
                'Instagram',
                style: TextStyle(
                  fontFamily: 'Billabong', // Font tương tự Instagram
                  fontSize: 50,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 50),

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
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              const SizedBox(height: 15),

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
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 15),

              // Confirm Password TextField
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Xác nhận mật khẩu',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Register Button
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Đăng Ký', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 15),

              // Error Message
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.green),
                ),

              // Login Option
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Đã có tài khoản? ',
                    style: TextStyle(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Đăng nhập ngay',
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
