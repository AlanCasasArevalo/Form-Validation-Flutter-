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

}