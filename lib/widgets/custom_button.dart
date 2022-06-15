import 'package:flutter/material.dart';

class CustomCircularButtonWithIcon extends StatelessWidget {
  const CustomCircularButtonWithIcon({
    Key? key,
    required this.buttonIcon,
    required this.onPressed,
  }) : super(key: key);
  final IconData buttonIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shape: const CircleBorder(),
        minimumSize: const Size.square(60),
      ),
      onPressed: onPressed,
      child: Icon(buttonIcon),
    );
  }
}
