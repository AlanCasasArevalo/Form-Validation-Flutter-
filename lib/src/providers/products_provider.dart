import 'dart:convert';
import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final String _firebaseBaseURL = 'YOUR_FIREBASE_URL';

  Future<bool> postProduct(ProductModel productModel) async {
    final url = '$_firebaseBaseURL/products.json';
    final response = await http.post(url, body: productModelToJson(productModel));
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> getProducts() async {
    final url = '$_firebaseBaseURL/products.json';
    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    final List<ProductModel> products = List();

    if (decodedData == null) {
      return [];
    } else {
      decodedData.forEach((id, product) {
        final tempProduct = ProductModel.fromJson(product);
        tempProduct.id = id;
        products.add(tempProduct);
      });
      return products;
    }
  }

  Future<int> deleteProduct (idToDelete) async {
    final url = '$_firebaseBaseURL/products/$idToDelete.json';
    final response = await http.delete(url);
    final decodedData = json.decode(response.body);

    if (response.statusCode > 199 && response.statusCode < 300 || response.reasonPhrase == 'OK') {
      // ok
      return 1;
    } else {
      // algo mal
      return -1;
    }
  }

}