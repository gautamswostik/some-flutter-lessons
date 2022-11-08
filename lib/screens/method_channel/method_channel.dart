// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
// import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

// class MethodChannelExamples extends StatefulWidget {
//   const MethodChannelExamples({Key? key}) : super(key: key);

//   @override
//   State<MethodChannelExamples> createState() => _MethodChannelExamplesState();
// }

// class _MethodChannelExamplesState extends State<MethodChannelExamples> {
//   static const platformOne = MethodChannel('samples.flutter.dev/hello');
//   static const platformTwo = MethodChannel("samples.flutter.dev/yourname");

//   String _helloOther = 'Get hello from android';
//   String _myJoke = 'Get Joke from android';
//   Future<void> _getHelloFromOtherSide() async {
//     String hello;
//     try {
//       final String result =
//           await platformOne.invokeMethod('sendHelloFromTheOtherSide');
//       hello = result;
//     } on PlatformException catch (e) {
//       hello = e.message.toString();
//     }

//     setState(() {
//       _helloOther = hello;
//     });
//   }

//   Future<void> _getJokeFromAndroid() async {
//     String name;
//     try {
//       final String result = await platformTwo.invokeMethod('sendMyJoke');
//       name = result;
//     } on PlatformException catch (e) {
//       name = e.message.toString();
//     }

//     setState(() {
//       _myJoke = name;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppTexts.androidMethodChannel.translateTo(context)),
//       ),
//       body: Material(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: _getHelloFromOtherSide,
//                 child: const Text('Get hello from android'),
//               ),
//               Text(_helloOther),
//               ElevatedButton(
//                 onPressed: _getJokeFromAndroid,
//                 child: const Text('Get Joke from android'),
//               ),
//               Text(_myJoke),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
