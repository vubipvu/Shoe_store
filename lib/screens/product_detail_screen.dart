import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final List<Product> cartItems;
  final Function(Product) onAddToCart;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
    required this.cartItems,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Image.network(product.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Text(
            '${product.price} VND',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              onAddToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sản phẩm đã được thêm vào giỏ hàng')),
              );
            },
            child: Text('Thêm vào giỏ hàng'),
          ),
        ],
      ),
    );
  }
}
