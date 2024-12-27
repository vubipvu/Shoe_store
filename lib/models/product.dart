class Product {
  final int? id; // ID sẽ được SQLite tự động tăng
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    this.id, // Mặc định là null nếu không truyền
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }
}
