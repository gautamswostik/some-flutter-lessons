import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppTexts.audioPlayer.translateTo(context),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: AppTexts.networkAudio.translateTo(context),
              ),
              Tab(
                text: AppTexts.fileAudio.translateTo(context),
              ),
              Tab(
                text: AppTexts.deviceAudio.translateTo(context),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
