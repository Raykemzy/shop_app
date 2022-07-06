import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const Text('Total'),
                    const SizedBox(width: 20),
                    Chip(label: Text('${cart.itemTotal}'))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.entries.length,
              itemBuilder: (ctx, i) {
                final cartItem = cart.items.values.toList()[i];
                return Dismissible(
                  key: ValueKey(cart.items.keys.toList()[i]),
                  onDismissed: (direction) {
                    //if(direction == DismissDirection.endToStart){}
                    cart.removeItem(cart.items.keys.toList()[i]);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${cartItem.title}'),
                        Text('${cartItem.price}'),
                      ],
                    ),
                    trailing: Text('${cartItem.quantity}x'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
