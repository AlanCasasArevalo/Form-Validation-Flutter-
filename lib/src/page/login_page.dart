import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = 'login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _backgroundBuilder(context),
      ]),
    );
  }

  Widget _backgroundBuilder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _purpleBackground = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(130, 70, 178, 1),
      ])),
    );

    final _bubble = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.06)),
    );

    return Stack(
      children: [
        _purpleBackground,
        Positioned(top: 90, left: 30, child: _bubble),
        Positioned(top: 10, right: 30, child: _bubble),
        Positioned(top: 200, right: 70, child: _bubble),
        Container(
          padding: EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100,),
              SizedBox(height: 10, width: double.infinity,),
              Text('Alan Casas', style: TextStyle(color: Colors.white, fontSize: 25),),
            ],
          ),
        )
      ],
    );
  }
}
