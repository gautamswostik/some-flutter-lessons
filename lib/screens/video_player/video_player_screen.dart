import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/screens/video_player/widgets/device_video_page.dart';
import 'package:fluuter_boilerplate/screens/video_player/widgets/file_video_chooser.dart';
import 'package:fluuter_boilerplate/screens/video_player/widgets/network_video_page.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppTexts.videoPlayer.translateTo(context)),
          bottom: TabBar(
            tabs: [
              Tab(
                text: AppTexts.networkVideo.translateTo(context),
              ),
              Tab(
                text: AppTexts.fileVideo.translateTo(context),
              ),
              Tab(
                text: AppTexts.deviceVideo.translateTo(context),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            NetworkVideoPage(),
            FileVideoChooser(),
            DeviceVideos(),
          ],
        ),
      ),
    );
  }
}
