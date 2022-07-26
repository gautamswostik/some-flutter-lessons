import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/app_setup/languages/languages.dart';
import 'package:fluuter_boilerplate/application/languages/language_cubit.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class AppLanguage extends StatefulWidget {
  const AppLanguage({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLanguage> createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.languageAppTitle.translateTo(context)),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => <PopupMenuEntry>[
              ...Languages.languages
                  .map<PopupMenuEntry>(
                    (e) => PopupMenuItem(
                      child: ListTile(
                        onTap: () async {
                          BlocProvider.of<LanguageCubit>(context)
                              .toggle(e.languageCode);
                          Navigator.of(context).pop();
                        },
                        leading: const Icon(Icons.language_sharp),
                        title: Text(e.languageName.translateTo(context)),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          int num = index + 1;
          if (num % 3 == 0 && num % 5 == 0) {
            return Text(AppTexts.fizzBuzz.translateTo(context));
          } else if (num % 3 == 0) {
            return Text(AppTexts.fizz.translateTo(context));
          } else if (num % 5 == 0) {
            return Text(AppTexts.buzz.translateTo(context));
          } else {
            return Text("$num");
          }
        },
      ),
    );
  }
}
