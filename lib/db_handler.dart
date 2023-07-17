import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:untitled/cart_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, intailPrice INTEGER, productPrice INTEGER, quantity INTEGER, unitTag TEXT, iamge TEXT)');
  }

  Future<Cart> insert(Cart cart) async {
    var dbClient = await db;
    await dbClient.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> qurryResult = await dbClient.query('cart');
    return qurryResult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> update(Cart cart) async {
    var dbClient = await db;
    return await dbClient.update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
