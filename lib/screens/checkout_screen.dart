import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;

  const CheckoutScreen({required this.totalPrice});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = ''; // Lưu trạng thái phương thức thanh toán

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin thanh toán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng tiền:', style: TextStyle(fontSize: 16)),
                Text('${widget.totalPrice} VND', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Phương thức thanh toán:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Thanh toán khi nhận hàng'),
              leading: Radio(
                value: 'cash',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Thanh toán qua VNPay'),
              leading: Radio(
                value: 'vnpay',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedPaymentMethod.isEmpty
                    ? null // Vô hiệu hóa nút nếu không chọn phương thức
                    : () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Thanh toán thành công'),
                      content: Text('Cảm ơn bạn đã mua hàng!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('Đóng'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedPaymentMethod.isEmpty
                      ? Colors.grey // Màu nút khi không chọn phương thức
                      : Colors.black, // Màu nút khi đã chọn phương thức
                  foregroundColor: Colors.white, // Màu chữ
                ),
                child: Text('Xác nhận thanh toán'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}