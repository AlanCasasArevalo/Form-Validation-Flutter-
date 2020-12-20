import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/providers/products_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc {
  final _productsController = BehaviorSubject<List<ProductModel>>();
  final _loadController = BehaviorSubject<bool>();

  final _productsProvider = ProductsProvider();

  Stream<List<ProductModel>> get getProductsStream => _productsController.stream;
  Stream<bool> get loading => _loadController.stream;

  void getProducts () async {
    final products = await _productsProvider.getProducts();
    _productsController.sink.add(products);
  }

  void postProduct (ProductModel productModel) async {
    _loadController.sink.add(true);
    await _productsProvider.postProduct(productModel);
    _loadController.sink.add(false);
  }

  void updateProduct (ProductModel productModel) async {
    _loadController.sink.add(true);
    await _productsProvider.updateProduct(productModel);
    _loadController.sink.add(false);
  }

  void deleteProduct (String idToDelete) async {
    _loadController.sink.add(true);
    await _productsProvider.deleteProduct(idToDelete);
    _loadController.sink.add(false);
  }

  Future<String> uploadImage (PickedFile imageFile) async {
    _loadController.sink.add(true);
    final imageUrl = await _productsProvider.uploadImage(imageFile);
    _loadController.sink.add(false);

    return imageUrl;
  }

  dispose(){
    _productsController?.close();
    _loadController?.close();
  }
}