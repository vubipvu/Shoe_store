import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'product_add_screen.dart';
import 'product_detail_screen.dart';
import 'product_list_screen.dart';
import '../database/database_helper.dart';
import 'package:shoe_store/screens/man_hinh_dang_nhap.dart';
import 'rules_screen.dart';
import 'feedback_screen.dart';
import 'feedback_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> _products = [];
  late List<Product> _cartItems = [];
  bool _isLoading = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    final dbProducts = await DatabaseService.instance.getProducts();
    setState(() {
      _products = dbProducts;
      _isLoading = false;
    });
  }

  Widget _buildBanner() {
    return Container(
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage('https://i.ytimg.com/vi/CXSko9ySpyo/maxresdefault.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalProductList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Sản phẩm nổi bật',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 240,
          child: _products.isEmpty
              ? Center(child: Text('Không có sản phẩm nào.'))
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _products.length,
            itemBuilder: (ctx, index) {
              final product = _products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        product: product,
                        cartItems: _cartItems,
                        onAddToCart: (p, size) {
                          setState(() => _cartItems.add(p));
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 180,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          product.imageUrl,
                          height: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.error,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${product.price} VND',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDiscountSection() {
    final List<Map<String, String>> discountCodes = [
      {'code': 'DISCOUNT20', 'description': 'Giảm 20% cho tất cả đơn hàng'},
      {'code': 'DISCOUNT10', 'description': 'Giảm 10% không giới hạn đơn hàng '},
      {'code': 'XAKHO', 'description': 'Xả xập kho với voucher giảm 50%'},
    ];

    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mã giảm giá',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: discountCodes.map((discount) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          discount['code']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          discount['description']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.copy, color: Colors.blueAccent),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: discount['code']!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đã sao chép mã: ${discount['code']}'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
      child: Column(
        children: [
          _buildBanner(),
          _buildHorizontalProductList(),
          _buildDiscountSection(), // Thêm mã giảm giá dưới danh sách sản phẩm
          _buildShopIntroduction(),
        ],
      ),
    );
  }

  Widget _buildShopIntroduction() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shoe_Store',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Chào mừng bạn đến với Shoe Store! Chúng tôi chuyên cung cấp các mẫu giày hiện đại, phong cách và chất lượng cao. Với nhiều năm kinh nghiệm, chúng tôi cam kết mang đến sự hài lòng cho khách hàng.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Địa chỉ: 123 Đường ABC, Quận 1, TP.HCM\nHotline: 0123 456 789\nEmail: support@shoestore.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trang chủ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }
}
