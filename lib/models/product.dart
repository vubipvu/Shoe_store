class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? discountPrice;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.discountPrice,
    required this.images,
  });
}

List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Giày thể thao Pastel',
    imageUrl: 'assets/images/2e5ab954a73887186705482d7063be1a.jpg',
    price: 1200000,
    discountPrice: 900000,
    images: [
      'assets/images/2e5ab954a73887186705482d7063be1a.jpg',
    ],
  ),
  Product(
    id: '2',
    name: 'Giày thể thao',
    imageUrl: 'assets/images/Giay-Nike-Air-Force-1-Custom-Grey-Blue-Navy-Panda.jpg',
    price: 1400000,
    images: [
      'assets/images/Giay-Nike-Air-Force-1-Custom-Grey-Blue-Navy-Panda.jpg',
    ],
  ),
  Product(
    id: '3',
    name: 'Giày trắng phối xanh',
    imageUrl: 'assets/images/z2473245349367_b7ff66cc0212f22b930215b674d0f4a2-scaled.jpg',
    price: 1500000,
    discountPrice: 1200000,
    images: [
      'assets/images/z2473245349367_b7ff66cc0212f22b930215b674d0f4a2-scaled.jpg',
    ],
  ),
  Product(
    id: '4',
    name: 'Giay-Nike-Air-Force-1',
    imageUrl: 'assets/images/Giay-Nike-Air-Jordan-1-High-OG-Denim-DM9036-104.jpg',
    price: 2000000,
    discountPrice: 1800000,
    images: [
      'assets/images/Giay-Nike-Air-Jordan-1-High-OG-Denim-DM9036-104.jpg',
    ],
  ),
  Product(
    id: '5',
    name: 'Giày-Nike-AF1-trắng',
    imageUrl: 'assets/images/Giày-Nike-AF1-trắng-vệt-den-rep-11-hình-2.jpeg',
    price: 1000000,
    images: [
      'assets/images/Giày-Nike-AF1-trắng-vệt-den-rep-11-hình-2.jpeg',
    ],
  ),
  Product(
    id: '6',
    name: 'nike-air-max',
    imageUrl: 'assets/images/nike-air-max-720-hong-full-nu.jpg',
    price: 1200000,
    images: [
      'assets/images/nike-air-max-720-hong-full-nu.jpg',
    ],
  ),
];


