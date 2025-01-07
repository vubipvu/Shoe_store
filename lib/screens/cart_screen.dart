import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/OrderDetail.dart';
import 'checkout_screen.dart';
import 'ShippingInfoScreen.dart';
import '../models/shipping_info.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<Product, int> _quantities = {}; // Số lượng sản phẩm
  TextEditingController _voucherController = TextEditingController(); // Trường nhập mã khuyến mãi
  double _discount = 0.0; // Mức giảm giá

  @override
  void initState() {
    super.initState();
    for (var product in widget.cartItems) {
      _quantities[product] = 1; // Khởi tạo số lượng mặc định là 1
    }
  }

  // Tính tổng tiền trước và sau giảm giá
  double _calculateTotalPrice() {
    double total = widget.cartItems.fold(0.0, (sum, product) {
      final quantity = _quantities[product] ?? 1;
      return sum + (product.price * quantity);
    });
    return total - (total * _discount / 100); // Áp dụng giảm giá
  }

  // Hàm xử lý mã khuyến mãi
  void _applyVoucher(String code) {
    if (code == "DISCOUNT10") {
      setState(() {
        _discount = 10.0; // Giảm 10%
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Áp dụng mã giảm giá thành công!')),
      );
    } else if (code == "DISCOUNT20") {
      setState(() {
        _discount = 20.0; // Giảm 20%
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Áp dụng mã giảm giá thành công!')),
      );
    } else if(code == "XAKHO" ) {
      setState(() {
        _discount = 50.0; // Giảm 50%
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Áp dụng mã giảm giá thành công!')),
      );

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mã giảm giá không hợp lệ!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Giỏ hàng',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
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

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error, color: Colors.red, size: 50),
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.price} VND',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
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
                  ),
                );
              },
            ),
          ),
          // Mã khuyến mãi
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _voucherController,
                  decoration: InputDecoration(
                    labelText: 'Nhập mã giảm giá',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _applyVoucher(_voucherController.text),
                  child: Text('Áp dụng mã'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
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
                final orderDetails = widget.cartItems.map((product) {
                  return OrderDetail(
                    productName: product.name,
                    productPrice: product.price,
                    quantity: _quantities[product] ?? 1,
                  );
                }).toList();

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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
