import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { favorites, showAll }

class ProdOverviewScreen extends StatefulWidget {
  const ProdOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProdOverviewScreen> createState() => _ProdOverviewScreenState();
}

class _ProdOverviewScreenState extends State<ProdOverviewScreen> {
  bool _showFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text('SHOP APP'),
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.showAll) {
                  _showFav = false;
                } else {
                  _showFav = true;
                }
              });
            },
            itemBuilder: (_) => <PopupMenuItem>[
              const PopupMenuItem(
                  value: FilterOptions.showAll, child: Text('Show All')),
              const PopupMenuItem(
                  value: FilterOptions.favorites, child: Text('Favorites'))
            ],
          ),
          Consumer<Cart>(
            builder: (_, model, __) {
              return Badge(
                value: model.itemCount.toString(),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CartScreen.routeName);
        },
        child: Consumer<Cart>(builder: (_, model, __) {
          return Badge(
            value: model.itemCount.toString(),
            child: const Icon(Icons.shopping_cart),
          );
        }),
      ),
      body: ProductsGrid(isFav: _showFav),
    );
  }
}
