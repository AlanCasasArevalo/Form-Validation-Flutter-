import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  static final String routeName = 'product_page';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

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
            key: formKey,
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
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto completo';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _productPriceBuilder() {
    return TextFormField (
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: 'Precio'
      ),
      validator: (value) {
        if(utils.isNumber(value)) {
          return null;
        } else {
          return 'Solo puede poner números.';
        }
      },
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
        onPressed: _submit
        );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    print('Todo bien');
  }
}
