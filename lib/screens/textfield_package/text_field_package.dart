import 'package:custom_textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class PackageTextField extends StatefulWidget {
  const PackageTextField({Key? key}) : super(key: key);

  @override
  State<PackageTextField> createState() => _PackageTextFieldState();
}

class _PackageTextFieldState extends State<PackageTextField> {
  @override
  void initState() {
    textEditingController.addListener(() {
      print(textEditingController.text);
    });
    super.initState();
  }

  final TextEditingController textEditingController = TextEditingController();
  String onChangedString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.customPackage.translateTo(context)),
      ),
      body: Column(
        children: [
          Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFieldPackage(
                textEditingController: textEditingController,
                hintText: 'Type Something',
                prefixIcon: Icons.bookmark_add_rounded,
                onChanged: (value) {
                  setState(() {
                    onChangedString = value;
                  });
                },
              ),
            ),
          ),
          Center(
            child: Text(onChangedString),
          ),
        ],
      ),
    );
  }
}
