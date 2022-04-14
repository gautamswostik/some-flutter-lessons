import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/app_setup/lessons/lessons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            ...lessons.map((lesson) {
              return Card(
                child: ListTile(
                  leading: Image.asset(lesson.image),
                  title: Text(lesson.title),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
