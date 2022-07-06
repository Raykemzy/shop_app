import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProdDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  const ProdDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final model = Provider.of<Products>(context, listen: false);
    final loadedProd = model.findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProd.title),
      ),
    );
  }
}
