import 'package:flutter/material.dart';

//Xử lý trạng thái đơn hàng như đã giao, đã thanh toán, hoặc hủy.
class OrderManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản Lý Đơn Hàng')),
      body: ListView.builder(
        itemCount: 5, // Demo: 5 đơn hàng
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Đơn hàng #$index'),
            subtitle: Text('Trạng thái: Đang chờ xử lý'),
            trailing: Icon(Icons.arrow_forward),
          );
        },
      ),
    );
  }
}
