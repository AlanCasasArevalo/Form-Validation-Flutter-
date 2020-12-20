import 'dart:convert';
import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/providers/user_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductsProvider {
  final String _firebaseBaseURL = 'YOUR_FIREBASE_URL';

  final _preference = UserSharedPreferences();

  Future<bool> postProduct(ProductModel productModel) async {
    final url = '$_firebaseBaseURL/products.json?auth=${_preference.token}';
    final response = await http.post(url, body: productModelToJson(productModel));
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> getProducts() async {
    final url = '$_firebaseBaseURL/products.json?auth=${_preference.token}';
    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    final List<ProductModel> products = List();

    if (decodedData == null || decodedData.length < 2) {
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
    final url = '$_firebaseBaseURL/products/$idToDelete.json?auth=${_preference.token}';
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

  Future<int> updateProduct (ProductModel productModel) async {
    final url = '$_firebaseBaseURL/products/${productModel.id}.json?auth=${_preference.token}';
    final response = await http.put(url, body: productModelToJson(productModel));

    if (response.statusCode > 199 && response.statusCode < 300 || response.reasonPhrase == 'OK') {
      // ok
      return 1;
    } else {
      // algo mal
      return -1;
    }
  }

  Future<String> uploadImage (PickedFile imageFile) async {
    final url = Uri.parse('http://api.cloudinary.com/v1_1/dr1lglwkr/image/upload?upload_preset=rotxcch5');
    final mimeType = mime(imageFile.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );

    final mediaType = MediaType(mimeType[0], mimeType[1]);
    final file = await http.MultipartFile.fromPath('file', imageFile.path, contentType: mediaType);

    //Se pueden subir multiples archivos simplemente agregandolos a la request.
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode > 199 && response.statusCode < 300 || response.reasonPhrase == 'OK') {
      // ok
      final responseData = json.decode(response.body);
      return responseData['secure_url'];
    } else {
      // algo mal
      print(response.body);
      return 'algo mal';
    }
  }
}