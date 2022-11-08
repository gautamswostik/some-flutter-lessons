import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StorageVideoPlayer extends StatefulWidget {
  const StorageVideoPlayer({
    Key? key,
    required this.videoPath,
  }) : super(key: key);
  final String videoPath;

  @override
  State<StorageVideoPlayer> createState() => _StorageVideoPlayerState();
}

class _StorageVideoPlayerState extends State<StorageVideoPlayer> {
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
    return SafeArea(
      child: Flexible(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: VideoPlayer(_controller),
              ),
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
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 30,
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
    );
  }
}
