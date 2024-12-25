import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final List<CartItem> cartItems;

  const ProductDetailsScreen({
    required this.product,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.black,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cột bên trái: Slider hình ảnh
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: product.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Xử lý thay đổi hình chính
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      product.images[index],
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

          // Cột bên phải: Thông tin sản phẩm
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      product.images[0],
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Yêu thích
                        },
                        icon: Icon(Icons.star_border),
                        label: Text("Được đánh giá cao"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${product.discountPrice ?? product.price} VND',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Sự rạng rỡ vẫn tồn tại trên đôi giày Nike Air Force 1 ’07, đôi giày bóng rổ nguyên bản mang đến luồng gió mới cho những gì bạn biết rõ nhất: lớp phủ được khâu bền chắc, lớp hoàn thiện sạch sẽ và độ lấp lánh hoàn hảo giúp bạn tỏa sáng.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  // Chi tiết thêm
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Màu sắc hiển thị: Trắng/Trắng'),
                        Text('- Kiểu dáng: CW2288-111'),
                        Text('- Quốc gia/Khu vực xuất xứ: Ấn Độ, Việt Nam'),
                      ],
                    ),
                  ),

                  // Nút thêm vào giỏ hàng
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Thêm sản phẩm vào giỏ hàng
                              cartItems.add(
                                CartItem(
                                  id: product.id,
                                  name: product.name,
                                  imageUrl: product.imageUrl,
                                  price: product.discountPrice ?? product.price,
                                  quantity: 1,
                                ),
                              );

                              // Chuyển đến màn hình giỏ hàng
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CartScreen(cartItems: cartItems),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("Thêm vào túi"),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Thêm vào danh sách yêu thích
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
