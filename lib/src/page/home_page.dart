import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/blocs/provider.dart';
import 'package:flutter_form_validation/src/page/product_page.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: Container(),
      floatingActionButton: _floatingActionButtonBuilder(context),
    );
  }
  
  Widget _floatingActionButtonBuilder(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, ProductPage.routeName)
        );
  }
}
