import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/providers/products_provider.dart';
import 'package:flutter_form_validation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  static final String routeName = 'product_page';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productsProvider = ProductsProvider();

  ProductModel _productModel = ProductModel();
  bool _isSaving = false;

  final _imagePicker = ImagePicker();
  PickedFile _image;

  @override
  Widget build(BuildContext context) {
    final ProductModel _productToUpdateModel =
        ModalRoute.of(context).settings.arguments;
    if (_productToUpdateModel != null) {
      _productModel = _productToUpdateModel;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: _selectPhoto),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _takePhoto),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _showImage (),
                SizedBox(
                  height: 16,
                ),
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
            }));
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
        onPressed: _isSaving ? null : _submit);
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _isSaving = true;
    });

    if ( _image != null) {
      _productModel.urlImage = await productsProvider.uploadImage(_image);
    }

    if (_productModel.id == null) {
      productsProvider.postProduct(_productModel);
      _showSnackbar('Se ha creado el producto');
    } else {
      productsProvider.updateProduct(_productModel);
      _showSnackbar('Se ha actualizado el producto');
    }

    Navigator.pop(context);
  }

  void _showSnackbar(String message) {
    final snackbar = SnackBar(
      backgroundColor: Colors.deepPurple,
      padding: EdgeInsets.all(20),
      elevation: 24,
      content: Text(message),
      duration: Duration(seconds: 1, milliseconds: 500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _showImage () {
    if(_productModel.urlImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(_productModel.urlImage),
            height: 250,
            fit: BoxFit.cover),
      );
    } else {
      return Image(
        image: AssetImage( _image?.path ?? 'assets/no_image.png'),
        height: 300,
        fit: BoxFit.cover,
      );
    }
  }

  _selectPhoto() async {
    _processImage( ImageSource.gallery );
  }

  _takePhoto() async {
    _processImage( ImageSource.camera );
  }

  _processImage( ImageSource type ) async {
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: type,
    );

    // Para manejar el error al cancelar la seleccion de una foto
    try {
      _image = PickedFile(pickedFile.path);
    } catch (e) {
      print('$e');
    }

    // Si el usuario cancelo o no selecciona una foto
    if (_image != null) {
      _productModel.urlImage = null;
    }
    setState(() {});
  }
}
