import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFav;
  const ProductsGrid({Key? key, required this.isFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Products>(context);
    final productsList = isFav ? model.favItem : model.item;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: ((ctx, i) {
        final prod = productsList[i];
        return ChangeNotifierProvider.value(
          value: prod,
          child: const ProductItem(),
        );
      }),
    );
  }
}
