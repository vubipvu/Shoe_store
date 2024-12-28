import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/OrderDetail.dart'; // Model chi tiết đơn hàng
import 'checkout_screen.dart';
import 'ShippingInfoScreen.dart'; // Màn hình thông tin giao hàng
import 'package:shoe_store/models/shipping_info.dart';
class CartScreen extends StatefulWidget {
  final List<Product> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Danh sách số lượng sản phẩm, mặc định mỗi sản phẩm có số lượng là 1
  final Map<Product, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    for (var product in widget.cartItems) {
      _quantities[product] = 1; // Khởi tạo số lượng mặc định là 1
    }
  }

  // Tính tổng tiền theo số lượng
  double _calculateTotalPrice() {
    return widget.cartItems.fold(0.0, (sum, product) {
      final quantity = _quantities[product] ?? 1;
      return sum + (product.price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: widget.cartItems.isEmpty
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
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                final quantity = _quantities[product] ?? 1;

                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${product.price} VND'),
                      Row(
                        children: [
                          Text('Số lượng:'),
                          SizedBox(width: 10),
                          DropdownButton<int>(
                            value: quantity,
                            items: List.generate(10, (i) => i + 1)
                                .map(
                                  (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ),
                            )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _quantities[product] = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.cartItems.remove(product);
                        _quantities.remove(product);
                      });
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
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_calculateTotalPrice().toStringAsFixed(0)} VND',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Nút Thanh toán
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: widget.cartItems.isEmpty
                  ? null
                  : () {
                // Chuẩn bị chi tiết đơn hàng
                final orderDetails =
                widget.cartItems.map((product) {
                  return OrderDetail(
                    productName: product.name,
                    productPrice: product.price,
                    quantity: _quantities[product] ?? 1,
                  );
                }).toList();

                // Điều hướng đến ShippingInfoScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShippingInfoScreen(
                      onProceedToPayment: (shippingInfo) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                              shippingInfo: shippingInfo,
                              totalPrice: _calculateTotalPrice(),
                              orderDetails: orderDetails,
                            ),
                          ),
                        );
                      },
                    ),
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
