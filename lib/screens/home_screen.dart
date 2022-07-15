import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/screens/app_theme/app_theme_screen.dart';
import 'package:fluuter_boilerplate/screens/audio_player/audio_player_screen.dart';
import 'package:fluuter_boilerplate/screens/camera/camera_screen.dart';
import 'package:fluuter_boilerplate/screens/image_picker/image_picker_screen.dart';
import 'package:fluuter_boilerplate/screens/infinite_list/infinite_list_screen.dart';
import 'package:fluuter_boilerplate/screens/local_notes/local_notes_screen.dart';
import 'package:fluuter_boilerplate/screens/localization/app_language_screen.dart';
import 'package:fluuter_boilerplate/screens/map/map_screen.dart';
import 'package:fluuter_boilerplate/screens/method_channel/method_channel.dart';
import 'package:fluuter_boilerplate/screens/qr/qr_screen.dart';
import 'package:fluuter_boilerplate/screens/video_player/video_player_screen.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/app_texts/gitbub_links.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.themeValue}) : super(key: key);
  final bool themeValue;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Components'.translateTo(context)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await launchInBrowser(GithubLinks.githubLink);
        },
        child: const FaIcon(FontAwesomeIcons.github),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.moon,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.darkMode.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AppTheme(themeValue: widget.themeValue),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.language,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.localization.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AppLanguage(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.image,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.imagePicker.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ImageAndVideoPicker(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.video_collection,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.videoPlayer.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VideoPlayerScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.music_note,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.audioPlayer.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AudioPlayerScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.camera,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.camera.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CameraScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.location_history,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.map.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.qr_code,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.qr.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QrScannerScreeen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.note_add,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.localNotes.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LocalNotesScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.list,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.infiniteList.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InfiniteListScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.note_add,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(AppTexts.androidMethodChannel.translateTo(context)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MethodChannelExamples(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
