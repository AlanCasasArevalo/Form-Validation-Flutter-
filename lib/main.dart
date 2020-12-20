import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/blocs/provider.dart';
import 'package:flutter_form_validation/src/page/home_page.dart';
import 'package:flutter_form_validation/src/page/login_page.dart';
import 'package:flutter_form_validation/src/page/register_page.dart';

import 'src/page/product_page.dart';
import 'src/providers/user_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _preference = UserSharedPreferences();
  await _preference.initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation',
        initialRoute: LoginPage.routeName,
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          ProductPage.routeName: (BuildContext context) => ProductPage(),
          RegisterPage.routeName: (BuildContext context) => RegisterPage(),
        },
        home: Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: Center(
            child: Container(child: Text('Pon_aqui_tu_titulo')),
          ),
        ),
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}
