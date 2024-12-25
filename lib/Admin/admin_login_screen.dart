import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email Admin'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Xử lý đăng nhập
              },
              child: Text('Đăng Nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
