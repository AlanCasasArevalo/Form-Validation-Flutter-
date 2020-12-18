import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = 'login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _backgroundBuilder(context),
        _loginForm(context),
      ]),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(child: Container(height: 180,)),
          Container(
            width: size.width * 0.8,
            padding: EdgeInsets.symmetric(vertical: 50),
            margin: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(2, 4),
                  spreadRadius: 3
                )
              ]
            ),
            child: Column(
              children: [
                Text('Ingresa', style: TextStyle(fontSize: 25),),
                SizedBox(height: 60,),
                _emailBuilder(),
                SizedBox(height: 30,),
                _passwordBuilder(),
                SizedBox(height: 30,),
                _buttonBuilder(),
              ],
            ),
          ),

          Text('¿Olvido la contraseña?'),
          SizedBox(height: 100,)
        ],
      ),
    );
  }

  Widget _emailBuilder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
          hintText: 'ejemplo@gmail.com',
          labelText: 'Correo electrónico'
        ),
      ),
    );
  }

  Widget _passwordBuilder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
          labelText: 'Contraseña'
        ),
      ),
    );
  }

  Widget _buttonBuilder() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text('Ingresar'),
      ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        elevation: 6,
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: () {

        }
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
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                'Alan Casas',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
        )
      ],
    );
  }
}
