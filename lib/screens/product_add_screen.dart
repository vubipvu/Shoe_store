import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductAddScreen extends StatefulWidget {
  final Function(Product) onAddProduct;

  const ProductAddScreen({required this.onAddProduct});

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _saveProduct() {
    final name = _nameController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final imageUrl = _imageUrlController.text;
    final description = _descriptionController.text;

    if (name.isNotEmpty && price > 0 && imageUrl.isNotEmpty) {
      final newProduct = Product(
        name: name,
        price: price,
        imageUrl: imageUrl,
        description: description,
      );
      widget.onAddProduct(newProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm sản phẩm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Tên sản phẩm'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Giá'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL hình ảnh'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Mô tả'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Thêm sản phẩm'),
            ),
          ],
        ),
      ),
    );
  }
}
