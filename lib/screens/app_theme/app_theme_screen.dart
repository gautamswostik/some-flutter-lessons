import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/app_theme/theme_cubit.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/app_texts/gitbub_links.dart';
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
          await _launchInBrowser(GithubLinks.darkModeBranch);
        },
        child: const FaIcon(FontAwesomeIcons.github),
      ),
      appBar: AppBar(
        title: const Text(AppTexts.darkModeAppTitle),
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
            return const Text(AppTexts.fizzBuzz);
          } else if (num % 3 == 0) {
            return const Text(AppTexts.fizz);
          } else if (num % 5 == 0) {
            return const Text(AppTexts.buzz);
          } else {
            return Text("$num");
          }
        },
      ),
    );
  }
}
