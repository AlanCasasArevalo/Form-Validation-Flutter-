import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  static final String routeName = 'product_page';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  ProductModel _productModel = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
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
                SizedBox(
                  height: 16,
                ),
                _productPriceBuilder(),
                SizedBox(
                  height: 16,
                ),
                _availableBuilder(),
                SizedBox(
                  height: 16,
                ),
                _submitButtonBuilder()
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _productNameBuilder() {
    return TextFormField(
      initialValue: _productModel.name,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto completo';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _productModel.name = value;
      },
    );
  }

  Widget _availableBuilder() {
    return SwitchListTile(
      activeColor: Colors.deepPurple,
      title: Text('Disponible'),
        value: _productModel.available,
        onChanged: (value) => setState(() {
              _productModel.available = value;
            }
        )
    );
  }

  TextFormField _productPriceBuilder() {
    return TextFormField(
      initialValue: _productModel.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (value) {
        if (utils.isNumber(value)) {
          return null;
        } else {
          return 'Solo puede poner números.';
        }
      },
      onSaved: (value) {
        _productModel.price = double.parse(value);
      },
    );
  }

  RaisedButton _submitButtonBuilder() {
    return RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.deepPurple,
        textColor: Colors.white,
        icon: Icon(Icons.save),
        label: Text('Guardar'),
        onPressed: _submit);
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
  }
}
