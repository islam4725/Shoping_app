import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_model.dart';
import 'db_handler.dart';

class CartProvider with ChangeNotifier {
  int _count = 0;

  DBHelper db = DBHelper();

  int get count => _count;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;

  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData() async {
   _cart =  db.getCartList();
    return _cart;
  }

  void _setPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _count);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _count = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;

    notifyListeners();
  }

  void addCounter() {
    _count++;
    _setPrefItem();
    notifyListeners();
  }

  void removeCounter() {
    _count--;
    _setPrefItem();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItem();
    return _count;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItem();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItem();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItem();
    return _totalPrice;
  }
}
