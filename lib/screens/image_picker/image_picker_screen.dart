import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/app_texts/gitbub_links.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageAndVideoPicker extends StatefulWidget {
  const ImageAndVideoPicker({Key? key}) : super(key: key);

  @override
  State<ImageAndVideoPicker> createState() => _ImageAndVideoPickerState();
}

class _ImageAndVideoPickerState extends State<ImageAndVideoPicker> {
  final List<XFile> _images = [];
  final List<XFile> _videos = [];
  final ImagePicker _picker = ImagePicker();

  _pickeOneImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _images.add(pickedFile!);
      });
    } catch (e) {
      rethrow;
    }
  }

  _pickeMultipleImage() async {
    try {
      final List<XFile>? pickedFileList = await _picker.pickMultiImage();

      for (int i = 0; i <= pickedFileList!.length; i++) {
        setState(() {
          _images.add(pickedFileList[i]);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  _pickVideo() async {
    try {
      final XFile? pickedFile =
          await _picker.pickVideo(source: ImageSource.gallery);
      setState(() {
        _videos.add(pickedFile!);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await launchInBrowser(GithubLinks.imagePickerBranch);
        },
        child: const FaIcon(FontAwesomeIcons.github),
      ),
      appBar: AppBar(
        title: Text(AppTexts.imagePicker.translateTo(context)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _images.clear();
                _videos.clear();
              });
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_images.isEmpty)
              const SizedBox()
            else
              Wrap(
                spacing: 10,
                children: _images
                    .map(
                      (e) => Image.file(
                        File(e.path),
                        height: 100,
                        width: 100,
                      ),
                    )
                    .toList(),
              ),
            if (_videos.isEmpty)
              const SizedBox()
            else
              Wrap(
                spacing: 10,
                children: _videos
                    .map(
                      (e) => Text(e.name),
                    )
                    .toList(),
              ),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _pickeOneImage();
                    },
                    child: Text(AppTexts.chooseImage.translateTo(context)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _pickeMultipleImage();
                    },
                    child:
                        Text(AppTexts.chooseMultipleImage.translateTo(context)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _pickVideo();
                    },
                    child: Text(AppTexts.chooseVideo.translateTo(context)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
