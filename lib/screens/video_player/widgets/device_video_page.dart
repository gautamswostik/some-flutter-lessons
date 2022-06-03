import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/screens/video_player/widgets/device_video_player_screen.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';

class DeviceVideos extends StatefulWidget {
  const DeviceVideos({Key? key}) : super(key: key);

  @override
  State<DeviceVideos> createState() => _DeviceVideosState();
}

class _DeviceVideosState extends State<DeviceVideos> {
  List<FileSystemEntity> mapVideoFiles = [];
  Future<List<FileSystemEntity>> loadVideo() async {
    storagePermissionHandler();
    String path = '/storage/emulated/0/DCIM/Camera';

    if (await Directory(path).exists()) {
      final dirFiles = await Directory(path)
          .list(recursive: false, followLinks: false)
          .toList();

      List<FileSystemEntity> videoFiles =
          dirFiles.where((f) => f.path.contains('.mp4')).toList();

      for (FileSystemEntity fv in videoFiles) {
        if (mapVideoFiles.isEmpty) {
          mapVideoFiles.clear();
        }
        setState(() {
          mapVideoFiles.add(fv);
        });
      }
    }
    return mapVideoFiles;
  }

  @override
  void initState() {
    loadVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: mapVideoFiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StorageVideoPlayer(
                    videoPath: mapVideoFiles[index].path,
                  ),
                ),
              );
            },
            title: Card(
              child: ListTile(
                title: Text(
                  mapVideoFiles[index]
                      .path
                      .split('/storage/emulated/0/DCIM/Camera/')
                      .last,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
