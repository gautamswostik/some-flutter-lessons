import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/app_theme/theme_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppTheme extends StatefulWidget {
  const AppTheme({
    Key? key,
    required this.themeValue,
  }) : super(key: key);
  final bool themeValue;
  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _launchInBrowser(
              'https://github.com/gautamswostik/some-flutter-lessons/tree/dark-mode');
        },
        child: const FaIcon(FontAwesomeIcons.github),
      ),
      appBar: AppBar(
        title: const Text('Change Theme'),
        actions: [
          Switch(
            value: widget.themeValue,
            onChanged: (value) {
              BlocProvider.of<ThemeCubit>(context).toggleTheme(value);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          int num = index + 1;
          if (num % 3 == 0 && num % 5 == 0) {
            return const Text("FizzBuzz");
          } else if (num % 3 == 0) {
            return const Text("Fizz");
          } else if (num % 5 == 0) {
            return const Text("Buzz");
          } else {
            return Text("$num");
          }
        },
      ),
    );
  }
}
