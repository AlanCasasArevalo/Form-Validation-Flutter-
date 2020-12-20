import 'package:flutter/material.dart';

bool isNumber(String value) {
  if (value.isEmpty) {
    return false;
  }
  final number = num.tryParse(value);
  return (number == null) ? false : true;
}

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Se ha producido un error'),
          content: Text(message),
          actions: [
            FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK'))
          ],
        );
      }
    );
}
