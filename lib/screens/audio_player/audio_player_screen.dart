import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/asset_audio/assetaudio_bloc.dart';
import 'package:fluuter_boilerplate/application/network_radio/networkradio_bloc.dart';
import 'package:fluuter_boilerplate/screens/audio_player/widgets/asset_audio_player.dart';
import 'package:fluuter_boilerplate/screens/audio_player/widgets/device_audio_player.dart';
import 'package:fluuter_boilerplate/screens/audio_player/widgets/network_audio_player.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/app_texts/gitbub_links.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  static final List<Widget> _widgetOptions = <Widget>[
    const NetworkAudioPlayer(),
    const AssetAudioPlayer(),
    const DeviceAudioFile(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1 || index == 2) {
        BlocProvider.of<NetworkAudioBloc>(context).add(StopNetworkAudio());
      }
      if (index == 0 || index == 2) {
        BlocProvider.of<AssetAudioBloc>(context).add(StopAssetAudio());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<NetworkAudioBloc>(context).add(StopNetworkAudio());
        BlocProvider.of<AssetAudioBloc>(context).add(StopAssetAudio());
        return true;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.info_outline),
                label: AppTexts.networkAudio.translateTo(context),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.list),
                label: AppTexts.asserAudio.translateTo(context),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.book),
                label: AppTexts.deviceAudio.translateTo(context),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          ),
          appBar: AppBar(
            title: Text(
              AppTexts.audioPlayer.translateTo(context),
            ),
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
      ),
    );
  }
}
