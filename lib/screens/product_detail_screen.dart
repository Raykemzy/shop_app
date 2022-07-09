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
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(loadedProd.title),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 200,
            height: 300,
            child: Image.network(loadedProd.imageUrl),
          ),
          Text(loadedProd.desc),
          Text('\$${loadedProd.price}'),
        ],
      ),
    );
  }
}
