import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/screens/audio_player/widgets/file_audio_player.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';

class DeviceAudioFile extends StatefulWidget {
  const DeviceAudioFile({Key? key}) : super(key: key);

  @override
  State<DeviceAudioFile> createState() => _DeviceAudioFileState();
}

class _DeviceAudioFileState extends State<DeviceAudioFile> {
  List<FileSystemEntity> mapAudioFiles = [];
  Future<List<FileSystemEntity>> loadAudio() async {
    storagePermissionHandler();
    String path = '/storage/emulated/0/Music';

    if (await Directory(path).exists()) {
      final dirFiles = await Directory(path)
          .list(recursive: false, followLinks: false)
          .toList();

      List<FileSystemEntity> audioFiles =
          dirFiles.where((f) => f.path.contains('.mp3')).toList();

      for (FileSystemEntity fileaudio in audioFiles) {
        if (mapAudioFiles.isEmpty) {
          mapAudioFiles.clear();
        }
        setState(() {
          mapAudioFiles.add(fileaudio);
        });
      }
    }
    return mapAudioFiles;
  }

  @override
  void initState() {
    loadAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: mapAudioFiles.length,
        padding: const EdgeInsets.only(bottom: 75),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FileAudioPlayer(
                    audioPath: mapAudioFiles[index].path,
                  ),
                ),
              );
            },
            title: Card(
              child: ListTile(
                title: Text(
                  mapAudioFiles[index]
                      .path
                      .split('/storage/emulated/0/Music/')
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
