import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePreviewWIdget extends StatelessWidget {
  const ImagePreviewWIdget({Key? key, required this.image}) : super(key: key);
  final XFile image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(image.path)),
            fit: BoxFit.cover,
          ),
        ),
        // child: Text('ImagePreviewWidget'),
      ),
    );
  }
}
