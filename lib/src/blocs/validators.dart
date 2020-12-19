import 'dart:async';

class Validators {
  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      password.length > 5 ? sink.add(password) : sink.addError('La contraseña necesita ser mayor de 6 caracteres');
    }
  );

  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      regExp.hasMatch(email) ? sink.add(email) : sink.addError('El email es incorrecto, por favor coloque un email valido');
    }
  );
}