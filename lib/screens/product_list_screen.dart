import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_details_screen.dart';
import '../models/cart_item.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  final List<CartItem> cartItems; // Nhận danh sách giỏ hàng từ tham số

  const ProductListScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: dummyProducts.length,
        itemBuilder: (ctx, index) {
          final product = dummyProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: product,
                    cartItems: cartItems, // Truyền giỏ hàng qua màn hình chi tiết sản phẩm
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // Hiển thị hình ảnh
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      product.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, size: 50, color: Colors.red);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${product.price} VND',
                    style: TextStyle(
                      color: product.discountPrice != null ? Colors.grey : Colors.black,
                      decoration: product.discountPrice != null ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (product.discountPrice != null)
                    Text(
                      '${product.discountPrice} VND',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
