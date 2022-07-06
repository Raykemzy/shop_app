import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatefulWidget {
  final bool? isHeldDown;
  const ProductItem({Key? key, this.isHeldDown}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isHeldDown = false;
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Product>(context);
    final cartModel = Provider.of<Cart>(context);
    return Stack(
      children: [
        GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(model.title),
            leading: IconButton(
                onPressed: () {
                  model.toggleFav();
                },
                icon: Icon(
                    model.isFavorite ? Icons.favorite : Icons.favorite_border)),
            trailing: IconButton(
                onPressed: () {
                  cartModel.addItem(model.id, model.title, model.price);
                  log('${cartModel.items.values.first}');
                  log('${cartModel.items.length}');
                },
                icon: const Icon(Icons.shopping_cart)),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProdDetailsScreen.routeName,
                arguments: model.id,
              );
            },
            onLongPress: () {
              setState(() {
                isHeldDown = true;
              });
            },
            child: Image.network(
              model.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        isHeldDown == true
            ? PopupMenuItem(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 50,
                  height: 20,
                  color: Colors.black54,
                  child: InkWell(
                    onTap: () {
                      cartModel.removeItem(model.id);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
