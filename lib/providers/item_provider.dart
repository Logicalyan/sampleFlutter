import 'package:flutter/material.dart';
import 'dart:io';

class Item {
  String name;
  double price;
  String image;
  String category;
  int quantity; // Menambahkan properti quantity

  Item({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.quantity = 1, // Default quantity adalah 1
  });
}

class Transaction {
  final double totalAmount;
  final DateTime date;

  Transaction({
    required this.totalAmount,
    required this.date,
  });
}

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];
  List<Item> _cartItems = []; // Daftar item di keranjang
  List<Transaction> _transactions = [];

  List<Item> get items => _items;
  List<Item> get cartItems => _cartItems;
  List<Transaction> get transactions => _transactions;

  void checkout(double totalPrice) {
    // Mencatat transaksi baru
    _transactions
        .add(Transaction(totalAmount: totalPrice, date: DateTime.now()));

    // Kosongkan semua item di keranjang
    _cartItems.clear();
    notifyListeners(); // Memberitahu UI untuk diperbarui
  }

  void addItemToCart(Item item) {
    _cartItems.add(item);
    notifyListeners();
  }
// Fungsi untuk menghapus item dari keranjang

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void filterByCategory(String s) {
    // Implement filtering logic if needed
  }

  void addToCart(Item item) {}
}
