import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/page/product_page.dart';
import 'package:flutter_form_validation/src/providers/products_provider.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            final List<ProductModel> products = snapshot.data;
            return ListView.builder(
              itemCount: products.length,
                itemBuilder: (context, index) {
                return _itemBuilder(context, products[index], products);
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _itemBuilder (BuildContext context, ProductModel product, List<ProductModel> products) {
    return Dismissible(
      key: UniqueKey(),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('${product.price} €'),
        onTap: () => Navigator.pushNamed(context, ProductPage.routeName),
      ),
      background: Container(
        child: Center(child: Text('Borrando ....', style: TextStyle(fontSize: 30, color: Colors.white),)),
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productsProvider.deleteProduct(product.id)
            .then((value) => setState(() {
              products.remove(product);
        })
        );
      },
    );
  }
}
