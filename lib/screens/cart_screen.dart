import 'package:flutter/material.dart';
import '../models/product.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tính tổng tiền trong giỏ hàng
    final totalPrice = cartItems.fold(0.0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Giỏ hàng trống.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text('${product.price} VND'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Thêm logic xóa nếu cần
                    },
                  ),
                );
              },
            ),
          ),
          // Hiển thị tổng tiền
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$totalPrice VND',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Nút Thanh toán
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: cartItems.isEmpty
                  ? null
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(totalPrice: totalPrice),
                  ),
                );
              },
              child: Text('Thanh toán'),
            ),
          ),
        ],
      ),
    );
  }
}
