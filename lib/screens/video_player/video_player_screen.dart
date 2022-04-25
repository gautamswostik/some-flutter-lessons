import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/app_texts/gitbub_links.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await launchInBrowser(GithubLinks.videoPlayerBranch);
          },
          child: const FaIcon(FontAwesomeIcons.github),
        ),
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
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            NetworkVideoPage(),
            FileVideoChooser(),
          ],
        ),
      ),
    );
  }
}

class NetworkVideoPage extends StatefulWidget {
  const NetworkVideoPage({Key? key}) : super(key: key);

  @override
  State<NetworkVideoPage> createState() => _NetworkVideoPageState();
}

class _NetworkVideoPageState extends State<NetworkVideoPage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          !_controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                Builder(builder: (context) {
                  return AnimatedOpacity(
                    opacity: _controller.value.isPlaying ? 0 : 1,
                    duration: const Duration(milliseconds: 200),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 30,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
                VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

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

class FileVideoPlayer extends StatefulWidget {
  const FileVideoPlayer({
    Key? key,
    required this.videoPath,
  }) : super(key: key);
  final String videoPath;

  @override
  State<FileVideoPlayer> createState() => _FileVideoPlayerState();
}

class _FileVideoPlayerState extends State<FileVideoPlayer> {
  late VideoPlayerController _controller;
  String get videoPath => widget.videoPath;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
      File(videoPath),
    )..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          !_controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(_controller),
            Builder(builder: (context) {
              return AnimatedOpacity(
                opacity: _controller.value.isPlaying ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                  ),
                ),
              );
            }),
            VideoProgressIndicator(_controller, allowScrubbing: true),
          ],
        ),
      ),
    );
  }
}
