import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final List<Product> cartItems;
  final Function(Product, double) onAddToCart;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
    required this.cartItems,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final List<double> _sizes = [40, 40.5, 41, 42, 42.5, 43, 44]; // Danh sách size
  double? _selectedSize; // Size được chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh sản phẩm
              Image.network(
                widget.product.imageUrl,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
              SizedBox(height: 16),
              // Tên sản phẩm
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Mô tả sản phẩm
              Text(
                widget.product.description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              // Giá sản phẩm
              Text(
                '${widget.product.price.toStringAsFixed(0)} VND',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // Chọn size giày
              Text(
                'Chọn size giày:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: _sizes.map((size) {
                  return ChoiceChip(
                    label: Text(
                      size.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _selectedSize == size ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: _selectedSize == size,
                    selectedColor: Colors.black,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSize = selected ? size : null; // Cập nhật size được chọn
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              // Nút thêm vào giỏ hàng
              ElevatedButton(
                onPressed: _selectedSize == null
                    ? null
                    : () {
                  widget.onAddToCart(widget.product, _selectedSize!);
                  Navigator.pop(context); // Quay lại danh sách sản phẩm
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  _selectedSize == null ? Colors.grey : Colors.black,
                ),
                child: Text('Thêm vào giỏ hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
