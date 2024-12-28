import 'package:flutter/material.dart';
import 'package:shoe_store/models/OrderDetail.dart';
import 'ShippingInfoScreen.dart';
class CheckoutScreen extends StatefulWidget {
  final double totalPrice;
  final List<OrderDetail> orderDetails;
  final Map<String, dynamic>? shippingInfo; // Thông tin giao hàng

  const CheckoutScreen({
    Key? key,
    required this.totalPrice,
    required this.orderDetails,
    this.shippingInfo,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = ''; // Trạng thái phương thức thanh toán

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thanh toán thành công'),
        content: Text('Cảm ơn bạn đã mua hàng!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Đóng hộp thoại
              Navigator.popUntil(context, (route) => route.isFirst); // Quay lại màn hình đầu tiên (ProductListScreen)
            },
            child: Text('Đóng'),
          ),
        ],
      ),
    );
  }

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
            if (widget.shippingInfo != null) ...[
              Text(
                'Thông tin giao hàng:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Họ và Tên: ${widget.shippingInfo!['fullName']}'),
              Text('Số điện thoại: ${widget.shippingInfo!['phoneNumber']}'),
              Text('Địa chỉ: ${widget.shippingInfo!['address']}'),
              Text('Tỉnh/Thành: ${widget.shippingInfo!['province']}'),
              Text('Quận/Huyện: ${widget.shippingInfo!['district']}'),
              Text('Phường/Xã: ${widget.shippingInfo!['ward']}'),
              Text('Email: ${widget.shippingInfo!['email']}'),
              Text('Ghi chú: ${widget.shippingInfo!['notes'] ?? 'Không có'}'),
              SizedBox(height: 20),
            ],
            Text(
              'Chi tiết đơn hàng:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.orderDetails.length,
                itemBuilder: (context, index) {
                  final detail = widget.orderDetails[index];
                  return ListTile(
                    title: Text(detail.productName),
                    subtitle: Text('${detail.productPrice.toStringAsFixed(0)} VND'),
                    trailing: Text('Số lượng: ${detail.quantity}'),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${widget.totalPrice.toStringAsFixed(0)} VND',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Phương thức thanh toán:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Thanh toán bằng tiền mặt'),
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
                    ? null
                    : () {
                  // Xử lý thanh toán
                  _showSuccessDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedPaymentMethod.isEmpty
                      ? Colors.grey
                      : Colors.black,
                  foregroundColor: Colors.white,
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
