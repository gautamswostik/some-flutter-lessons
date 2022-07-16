library custom_textfield;

import 'package:flutter/material.dart';

typedef ParamFunc = Function(String value);

class CustomTextFieldPackage extends StatefulWidget {
  const CustomTextFieldPackage({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.prefixIcon,
    required this.onChanged,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final String hintText;
  final IconData prefixIcon;
  final ValueSetter<String> onChanged;

  ///Or we can use it by making typedef
  ///final ParamFunc onChanged;
  @override
  State<CustomTextFieldPackage> createState() => _CustomTextFieldPackageState();
}

class _CustomTextFieldPackageState extends State<CustomTextFieldPackage> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 1,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        prefixIcon: Icon(widget.prefixIcon),
      ),
    );
  }
}
