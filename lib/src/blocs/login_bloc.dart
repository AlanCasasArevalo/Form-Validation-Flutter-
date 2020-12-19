import 'dart:async';

import 'package:flutter_form_validation/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  // 2 controladores uno para estar observando el email y otro para observar el password
  /*
  Se ha sustituido StreamController por BehaviorSubject que viene de RXDart para poder combinar ambos controladores
  y poder asi combinar los validadores
   */
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream => _passwordController.stream.transform(passwordValidator);

  // Combina los 2 validators, si ambos estan correctos enviamos un true para habilitar el boton del login
  Stream<bool> get formValidStream =>
    Observable.combineLatest2(emailStream, passwordStream, (email, password) => true);

  // Inserción de valores al stream, aunque ponga get son setters insercion de string en los campos
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}