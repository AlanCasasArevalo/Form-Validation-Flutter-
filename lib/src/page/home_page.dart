import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: Center(
        child: Container(
          child: Text('Home'),
        ),
      ),
    );
  }
}
