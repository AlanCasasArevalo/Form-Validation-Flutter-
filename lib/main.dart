import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/page/home_page.dart';
import 'package:flutter_form_validation/src/page/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Validation',
      initialRoute: LoginPage.routeName,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        LoginPage.routeName: (BuildContext context) => LoginPage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Container(
              child: Text('Pon_aqui_tu_titulo')
          ),
        ),
      ),
    );
  }
}
