import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  int count = 0;
  final String id;
  final String title;
  final String desc;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFav() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  int itemQuantity() {
    return count++;
  }
}
