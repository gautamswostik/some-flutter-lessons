import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/screens/app_theme/app_theme_screen.dart';
import 'package:fluuter_boilerplate/screens/audio_player/audio_player_screen.dart';
import 'package:fluuter_boilerplate/screens/camera/camera_screen.dart';
import 'package:fluuter_boilerplate/screens/image_picker/image_picker_screen.dart';
import 'package:fluuter_boilerplate/screens/localization/app_language_screen.dart';
import 'package:fluuter_boilerplate/screens/map/map_screen.dart';
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
            
          ],
        ),
      ),
    );
  }
}
