import 'package:flutter/material.dart';

mixin CustomScaffold<T extends StatefulWidget> on State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: appbarColor,
      ),
      body: body(),
    );
  }

  Widget body();

  String title = '';
  Color appbarColor = Colors.pink;
}
