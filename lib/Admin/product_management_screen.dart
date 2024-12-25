import 'package:flutter/material.dart';

//Tạo mới, chỉnh sửa, hoặc xóa sản phẩm.
class ProductManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản Lý Sản Phẩm')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to Add Product Screen
          },
          child: Text('Thêm Sản Phẩm'),
        ),
      ),
    );
  }
}
