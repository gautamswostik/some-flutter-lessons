import 'package:flutter/material.dart';

class AppTheme extends StatefulWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Theme'),
      ),
    );
  }
}
