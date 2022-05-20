import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/screens/app_theme/app_theme_screen.dart';
import 'package:fluuter_boilerplate/screens/audio_player/audio_player_screen.dart';
import 'package:fluuter_boilerplate/screens/image_picker/image_picker_screen.dart';
import 'package:fluuter_boilerplate/screens/localization/app_language_screen.dart';
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
                leading: Image.asset('assets/images/theme.png'),
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
                leading: Image.asset('assets/images/translation.png'),
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
                leading: Image.asset('assets/images/imagepicker.png'),
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
                leading: Image.asset('assets/images/video_player.png'),
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
                leading: Image.asset('assets/images/music.png'),
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
          ],
        ),
      ),
    );
  }
}
