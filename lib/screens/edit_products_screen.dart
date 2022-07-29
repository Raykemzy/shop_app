import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-products';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    desc: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageFocus.addListener(updateUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageFocus.removeListener(updateUrl);
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageFocus.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void updateUrl() {
    if (!_imageFocus.hasFocus) {
      setState(() {});
    }
  }

  void saveProduct() {
    _form.currentState!.save();
    final model = Provider.of<Products>(context, listen: false);
    model.addProduct(_editedProduct);
    log(model.item.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              saveProduct();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Product Title'),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (v) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: v!,
                    desc: _editedProduct.desc,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Product Price'),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (v) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    desc: _editedProduct.desc,
                    price: double.parse(v!),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  label: Text('Product Description'),
                ),
                textInputAction: TextInputAction.newline,
                focusNode: _descriptionFocus,
                onSaved: (v) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    desc: v!,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, style: BorderStyle.solid),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Center(child: Text('Enter Image Url'))
                        : FittedBox(
                            clipBehavior: Clip.hardEdge,
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextFormField(
                      focusNode: _imageFocus,
                      controller: _imageUrlController,
                      decoration: const InputDecoration(
                        label: Text('Product Image'),
                      ),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (v) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          desc: _editedProduct.desc,
                          price: _editedProduct.price,
                          imageUrl: v!,
                        );
                      },
                      onFieldSubmitted: (_) {
                        saveProduct();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
