import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/screens/video_player/widgets/file_video_player.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';
import 'package:image_picker/image_picker.dart';

class FileVideoChooser extends StatefulWidget {
  const FileVideoChooser({Key? key}) : super(key: key);

  @override
  State<FileVideoChooser> createState() => _FileVideoChooserState();
}

class _FileVideoChooserState extends State<FileVideoChooser> {
  XFile _videos = XFile('');
  final ImagePicker _picker = ImagePicker();
  _pickeVideo() async {
    try {
      final XFile? pickedFile =
          await _picker.pickVideo(source: ImageSource.gallery);
      setState(() {
        _videos = pickedFile!;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_videos.path.isEmpty)
          const SizedBox()
        else
          FileVideoPlayer(videoPath: _videos.path),
        if (_videos.path.isEmpty)
          ElevatedButton(
            onPressed: () async {
              await _pickeVideo();
            },
            child: Text(AppTexts.chooseVideo.translateTo(context)),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
