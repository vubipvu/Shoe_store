import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/wishlist.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'product_add_screen.dart';
import 'product_detail_screen.dart';
import '../database/database_helper.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late List<Product> _products;
  late List<Product> _filteredProducts; // Danh sách sản phẩm sau khi lọc
  late List<Product> _cartItems = [];
  late List<WishlistItem> _wishlistItems = [];
  bool _isLoading = true;
  String _searchQuery = ''; // Từ khóa tìm kiếm
  bool _isAscending = true; // Trạng thái sắp xếp giá

  @override
  void initState() {
    super.initState();
    _products = [];
    _filteredProducts = []; // Khởi tạo danh sách trống
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    final dbProducts = await DatabaseService.instance.getProducts();
    setState(() {
      _products = dbProducts;
      _filteredProducts = List.from(_products); // Gán giá trị ban đầu
      _isLoading = false;
    });
  }

  // Hàm lọc sản phẩm
  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  // Hàm sắp xếp sản phẩm theo giá
  void _sortProducts(bool isAscending) {
    setState(() {
      _isAscending = isAscending;
      _filteredProducts.sort((a, b) =>
      isAscending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    });
  }

  void _addToWishlist(Product product) {
    final isExist = _wishlistItems.any((item) => item.id == product.id);

    if (isExist) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} đã có trong danh sách yêu thích!'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _wishlistItems.add(WishlistItem(
        id: product.id!,
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.price,
      ));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thêm ${product.name} vào danh sách yêu thích!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _addToCart(Product product, double size) {
    setState(() {
      _cartItems.add(product);
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
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '${product.price} VND',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => _addToWishlist(product),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart, color: Colors.green),
                  onPressed: () => _addToCart(product, 42),
                ),
              ],
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
        title: Text(
          'Danh sách sản phẩm',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistScreen(wishlistItems: _wishlistItems),
                ),
              );
            },
          ),
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
          : Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm sản phẩm',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                _filterProducts(value);
              },
            ),
          ),
          // Nút sắp xếp
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _sortProducts(true),
                  icon: Icon(Icons.arrow_upward),
                  label: Text('Giá tăng dần'),
                ),
                TextButton.icon(
                  onPressed: () => _sortProducts(false),
                  icon: Icon(Icons.arrow_downward),
                  label: Text('Giá giảm dần'),
                ),
              ],
            ),
          ),
          // Danh sách sản phẩm
          Expanded(
            child: _filteredProducts.isEmpty
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
              itemCount: _filteredProducts.length,
              itemBuilder: (ctx, index) {
                final product = _filteredProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
