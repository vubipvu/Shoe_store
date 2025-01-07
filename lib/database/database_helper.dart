import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models//users.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();
  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imageUrl TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  Future<int> createProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final result = await db.query('products');
    return result.map((json) => Product.fromMap(json)).toList();
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class TroLyCoSoDuLieu {
  static const String _baseUrl = 'https://your-api-endpoint.com';

  // Hàm đăng ký người dùng
  Future<bool> dangKy(Users nguoiDung) async {
    final url = Uri.parse('$_baseUrl/dangky');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(nguoiDung.toJson()),
      );
      return response.statusCode == 201; // Trả về true nếu đăng ký thành công
    } catch (e) {
      print('Lỗi đăng ký: $e');
      return false;
    }
  }

  // Hàm đăng nhập
  Future<bool> dangNhap(String tenDangNhap, String matKhau) async {
    final url = Uri.parse('$_baseUrl/dangnhap');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tenDangNhap': tenDangNhap,
          'matKhau': matKhau,
        }),
      );
      return response.statusCode == 200; // Trả về true nếu đăng nhập thành công
    } catch (e) {
      print('Lỗi đăng nhập: $e');
      return false;
    }
  }
}
