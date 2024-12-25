import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Admin Menu', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/admin/dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Quản Lý Người Dùng'),
            onTap: () {
              Navigator.pushNamed(context, '/admin/users');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Quản Lý Sản Phẩm'),
            onTap: () {
              Navigator.pushNamed(context, '/admin/products');
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Quản Lý Đơn Hàng'),
            onTap: () {
              Navigator.pushNamed(context, '/admin/orders');
            },
          ),
        ],
      ),
    );
  }
}
