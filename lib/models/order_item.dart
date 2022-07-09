import 'package:shop_app/models/cart_item.dart';

class OrderItem {
  final String id;
  final double ammount;
  final List<CartItem> products;
  final DateTime time;

  OrderItem({
    required this.id,
    required this.ammount,
    required this.products,
    required this.time,
  });
}
