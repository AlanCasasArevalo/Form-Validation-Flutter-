import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/blocs/provider.dart';
import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/page/product_page.dart';
import 'package:flutter_form_validation/src/providers/products_provider.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final _productsBloc = Provider.productsBloc(context);
    _productsBloc.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: _buildProductList(_productsBloc),
      floatingActionButton: _floatingActionButtonBuilder(context),
    );
  }

  Widget _floatingActionButtonBuilder(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.pushNamed(context, ProductPage.routeName).then((value) {
              setState(() {});
            }));
  }

  Widget _buildProductList(ProductsBloc _productsBloc) {

    return StreamBuilder(
      stream: _productsBloc.getProductsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final List<ProductModel> products = snapshot.data;
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _itemBuilder(context, products[index], products, _productsBloc);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }

  Widget _itemBuilder(BuildContext context, ProductModel product, List<ProductModel> products, ProductsBloc _productsBloc) {
    return Dismissible(
      key: UniqueKey(),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (product.urlImage == null)
                  ? Image(
                      image: AssetImage('assets/no_image.png'),
                    )
                  : FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'),
                      image: NetworkImage(product.urlImage),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover),
              ListTile(
                title: Text(product.name),
                subtitle: Text('${product.price} €'),
                onTap: () => Navigator.pushNamed(context, ProductPage.routeName,
                        arguments: product)
                    .then((value) {
                  setState(() {});
                }),
              )
            ],
          ),
        ),
      ),
      background: Container(
        child: Center(
            child: Text(
          'Borrando ....',
          style: TextStyle(fontSize: 30, color: Colors.white),
        )),
        color: Colors.red,
      ),
      onDismissed: (direction) {
        _productsBloc.deleteProduct(product.id).then((value) => setState(() {
              products.remove(product);
            }));
      },
    );
  }
}
