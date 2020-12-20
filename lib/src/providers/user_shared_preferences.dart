import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static final UserSharedPreferences _instance = UserSharedPreferences._internal();

  factory UserSharedPreferences () {
    return _instance;
  }

  UserSharedPreferences._internal();

  SharedPreferences _preferences;

  initPreferences () async {
    this._preferences = await SharedPreferences.getInstance();
  }

  get token {
    return _preferences.getString('token') ?? '';
  }

  set setToken (String token) {
    _preferences.setString('token', token ?? '');
  }
}