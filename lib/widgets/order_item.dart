import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/order_item.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem order;
  const OrderItemWidget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: Text('\$${order.ammount}'),
            subtitle: Text(
              DateFormat('dd yy MM hh:mm').format(order.time),
            ),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.expand_more)),
          ),
        ],
      ),
    );
  }
}
