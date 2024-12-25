import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Shoe Store',
          style: TextStyle(
            fontFamily: 'Billabong', // Font tương tự Instagram
            fontSize: 32,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Thêm logic cho thông báo
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              'Chào mừng bạn đến Shoe Store!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Image Banner
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage('assets/images/shoe_banner.jpg'), // Thêm ảnh banner
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Featured Products
            Text(
              'Sản phẩm nổi bật',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),

            // Grid of Products
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: 4, // Số lượng sản phẩm hiển thị
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage('assets/images/shoe_$index.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sản phẩm $index',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '500,000 VND',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang Chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ Hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài Khoản',
          ),
        ],
        onTap: (index) {
          // Thêm logic chuyển tab
        },
      ),
    );
  }
}
