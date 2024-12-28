import 'package:flutter/material.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'product_add_screen.dart';
import 'product_detail_screen.dart';
import '../database/database_helper.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late List<Product> _products;
  late List<Product> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _products = [];
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    final dbProducts = await ProductDatabase.instance.getProducts();
    setState(() {
      _products = dbProducts;
      _isLoading = false;
    });
  }

  Future<void> _addProduct(Product product) async {
    await ProductDatabase.instance.createProduct(product);
    _loadProducts();
  }

  Future<void> _deleteProduct(int id) async {
    await ProductDatabase.instance.deleteProduct(id);
    _loadProducts();
  }

  void _addToCart(Product product, double size) {
    setState(() {
      _cartItems.add(product); // Bạn có thể lưu thêm thông tin size nếu cần
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã thêm ${product.name} (size $size) vào giỏ hàng!')),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              product: product,
              cartItems: _cartItems,
              onAddToCart: _addToCart,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(Icons.error, size: 50, color: Colors.red),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      // Hiển thị hộp thoại xác nhận trước khi xóa
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Xóa sản phẩm'),
                          content: Text('Bạn có chắc chắn muốn xóa sản phẩm này không?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: Text('Xóa'),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await _deleteProduct(product.id!);
                      }
                    },
                  ),
                ],
              ),
            ),
            // Giá sản phẩm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${product.price} VND',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (_cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        _cartItems.length.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: _cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _products.isEmpty
          ? Center(
        child: Text(
          'Không có sản phẩm nào.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemCount: _products.length,
        itemBuilder: (ctx, index) {
          final product = _products[index];
          return _buildProductCard(product);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductAddScreen(onAddProduct: _addProduct),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
