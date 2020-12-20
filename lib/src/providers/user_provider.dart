import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  final String _firebaseToken = 'YOUR_FIREBASE_API_JEY';

  Future registerUser(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken';
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(url, body: json.encode(authData));
    print(response);
    Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (response.statusCode > 199 && response.statusCode < 300 ||
        response.reasonPhrase == 'OK') {
      if (decodedResponse.containsKey('idToken')) {
        return {'ok': true, 'token': decodedResponse['idToken']};
      } else {
        return {'ok': false, 'token': decodedResponse['error']['message']};
      }
    } else {
      return {'ok': false, 'token': decodedResponse['error']['message']};
    }
  }
}
