import 'package:flutter/material.dart';

import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            title: const Text('Hello there'),
          ),
          ListTile(
            leading: const Text('Shop'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Text('Your Orders'),
            onTap: () {
              Navigator.pushNamed(context, OrderScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
