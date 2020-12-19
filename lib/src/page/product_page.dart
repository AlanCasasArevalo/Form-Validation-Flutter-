import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  static final String routeName = 'product_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                _productNameBuilder(),
                SizedBox(height: 16,),
                _productPriceBuilder(),
                SizedBox(height: 16,),
                _submitButtonBuilder()
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _productNameBuilder() {
    return TextFormField (
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
    );
  }

  TextFormField _productPriceBuilder() {
    return TextFormField (
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: 'Precio'
      ),
    );
  }

  RaisedButton _submitButtonBuilder() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text('Guardar'),
        onPressed: (){}
        );
  }
}
