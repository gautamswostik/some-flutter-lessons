import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/app_setup/lessons/lessons.dart';
import 'package:fluuter_boilerplate/screens/app_theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.themeValue}) : super(key: key);
  final bool themeValue;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Image.asset('assets/images/theme.png'),
                title: const Text('Dark Mode'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AppTheme(themeValue: widget.themeValue),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
