import 'package:flutter/material.dart';

//Quản lý danh sách người dùng, khóa/mở khóa tài khoản, hoặc xem chi tiết.
class UserManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản Lý Người Dùng')),
      body: ListView.builder(
        itemCount: 10, // Demo: 10 người dùng
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text('User $index'),
            subtitle: Text('Email: user$index@example.com'),
            trailing: Icon(Icons.more_vert),
          );
        },
      ),
    );
  }
}
