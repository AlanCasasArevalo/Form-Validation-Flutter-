import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/page/product_page.dart';
import 'package:flutter_form_validation/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home_page';
  final productsProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: _buildProductList(),
      floatingActionButton: _floatingActionButtonBuilder(context),
    );
  }

  Widget _floatingActionButtonBuilder(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, ProductPage.routeName));
  }

  Widget _buildProductList() {
    return FutureBuilder(
        future: productsProvider.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return Container();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
