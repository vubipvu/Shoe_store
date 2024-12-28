import 'package:flutter/material.dart';

class ShippingInfoScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onProceedToPayment;

  const ShippingInfoScreen({Key? key, required this.onProceedToPayment})
      : super(key: key);

  @override
  _ShippingInfoScreenState createState() => _ShippingInfoScreenState();
}

class _ShippingInfoScreenState extends State<ShippingInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _shippingInfo = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin giao hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Họ và Tên'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng nhập họ và tên' : null,
                onSaved: (value) => _shippingInfo['fullName'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng nhập số điện thoại' : null,
                onSaved: (value) => _shippingInfo['phoneNumber'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Địa chỉ'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng nhập địa chỉ' : null,
                onSaved: (value) => _shippingInfo['address'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng nhập email' : null,
                onSaved: (value) => _shippingInfo['email'] = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onProceedToPayment(_shippingInfo);
                  }
                },
                child: Text('Tiếp tục'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
