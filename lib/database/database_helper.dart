import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';
import '../models/users.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  // Lấy database, nếu đã tồn tại thì trả về, nếu không thì khởi tạo
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  // Khởi tạo database
  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
      );
    } catch (e) {
      print('Lỗi khi khởi tạo database: $e');
      rethrow;
    }
  }

  // Tạo các bảng trong database
  Future<void> _createDB(Database db, int version) async {
    try {
      // Tạo bảng sản phẩm
      await db.execute('''
        CREATE TABLE products (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          price REAL NOT NULL,
          imageUrl TEXT NOT NULL,
          description TEXT NOT NULL
        )
      ''');

      // Tạo bảng người dùng
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT NOT NULL,
          email TEXT NOT NULL,
          password TEXT NOT NULL
        )
      ''');
      // Tạo bảng phản hồi
      await db.execute('''
        CREATE TABLE feedbacks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          email TEXT,
          message TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');
    } catch (e) {
      print('Lỗi khi tạo bảng: $e');
      rethrow;
    }
  }

  // Đóng database
  Future<void> close() async {
    final db = await instance.database;
    if (db.isOpen) {
      await db.close();
    }
  }

  // ** Xử lý sản phẩm **
  Future<int> createProduct(Product product) async {
    try {
      final db = await instance.database;
      return await db.insert('products', product.toMap());
    } catch (e) {
      print('Lỗi khi thêm sản phẩm: $e');
      return -1; // Trả về -1 nếu thêm thất bại
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final db = await instance.database;
      final result = await db.query('products');
      return result.map((json) => Product.fromMap(json)).toList();
    } catch (e) {
      print('Lỗi khi lấy danh sách sản phẩm: $e');
      return [];
    }
  }

  Future<int> deleteProduct(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Lỗi khi xóa sản phẩm: $e');
      return -1;
    }
  }

  // ** Xử lý người dùng **
  Future<int> createUser(Users user) async {
    try {
      final db = await instance.database;
      return await db.insert('users', user.toMap());
    } catch (e) {
      print('Lỗi khi thêm người dùng: $e');
      return -1; // Trả về -1 nếu thêm thất bại
    }
  }

  Future<List<Users>> getUsers() async {
    try {
      final db = await instance.database;
      final result = await db.query('users');
      return result.map((json) => Users.fromMap(json)).toList();
    } catch (e) {
      print('Lỗi khi lấy danh sách người dùng: $e');
      return [];
    }
  }

  Future<int> deleteUser(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Lỗi khi xóa người dùng: $e');
      return -1;
    }
  }
  // Thêm phản hồi
  Future<int> createFeedback(String? username, String? email, String message) async {
    final db = await database;
    return await db.insert('feedbacks', {
      'username': username,
      'email': email,
      'message': message,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

// Lấy danh sách phản hồi
  Future<List<Map<String, dynamic>>> getFeedbacks() async {
    final db = await database;
    return await db.query('feedbacks', orderBy: 'created_at DESC');
  }

// Xóa phản hồi
  Future<int> deleteFeedback(int id) async {
    final db = await database;
    return await db.delete(
      'feedbacks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
