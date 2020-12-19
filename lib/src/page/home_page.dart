import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Email => ${bloc.email}'),
          Divider(),
          Text('Password => ${bloc.password}'),
        ],
      )
    );
  }
}
