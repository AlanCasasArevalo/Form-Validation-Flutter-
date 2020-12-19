import 'dart:async';

import 'package:flutter_form_validation/src/blocs/validators.dart';

class LoginBloc with Validators {
  // 2 controladores uno para estar observando el email y otro para observar el password
  /*
   Se le agrega la informacion de String al Stream controller para poder escuchar mas elementos a los controladores, en caso de dejar los controladores solo como StreamController(), solo podria tener
   un observador, sin embargo poniendo el .broadcast() permitimos que pueda haber mas de un observador de estos controladores.
   */
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream => _passwordController.stream.transform(passwordValidator);

  // Inserción de valores al stream, aunque ponga get son setters insercion de string en los campos
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}