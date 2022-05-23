import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/asset_audio/assetaudio_bloc.dart';

class AssetAudioPlayer extends StatefulWidget {
  const AssetAudioPlayer({Key? key}) : super(key: key);

  @override
  State<AssetAudioPlayer> createState() => _AssetAudioPlayerState();
}

class _AssetAudioPlayerState extends State<AssetAudioPlayer> {
  Duration position = const Duration();
  Duration totalDuration = const Duration();
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/ukelele.png',
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
            fit: BoxFit.cover,
          ),
          SliderTheme(
            data: const SliderThemeData(
              trackHeight: 4,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: position.inMilliseconds.toDouble(),
              activeColor: Colors.yellow,
              inactiveColor: Colors.yellow.withOpacity(0.3),
              onChanged: (value) {
                BlocProvider.of<AssetAudioBloc>(context).add(
                  SeekAssetAudio(
                      seekDuration: Duration(milliseconds: value.toInt())),
                );
              },
              max: totalDuration.inMilliseconds.toDouble(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<AssetAudioBloc, AssetAudioState>(
              builder: (context, state) {
                if (state is AssetAudioPlaying) {
                  state.audioPlayer.onAudioPositionChanged
                      .listen((currentPosition) {
                    setState(() {
                      position = currentPosition;
                    });
                  });
                  state.audioPlayer.onDurationChanged.listen((duration) {
                    setState(() {
                      totalDuration = duration;
                    });
                  });
                  state.audioPlayer.onPlayerCompletion.listen((_) {
                    BlocProvider.of<AssetAudioBloc>(context)
                        .add(StopAssetAudio());
                    setState(() {
                      position = const Duration(milliseconds: 0);
                      totalDuration = const Duration(milliseconds: 0);
                    });
                  });
                  return Column(
                    children: [
                      Text(position.toString()),
                    ],
                  );
                }

                return Column(
                  children: [
                    Text(position.toString()),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<AssetAudioBloc, AssetAudioState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        shape: const CircleBorder(),
                        minimumSize: const Size.square(80),
                      ),
                      onPressed: () async {
                        BlocProvider.of<AssetAudioBloc>(context).add(
                          PlayAssetAudio(),
                        );
                      },
                      child: Icon(
                        (state is AssetAudioPaused)
                            ? Icons.play_arrow
                            : Icons.pause,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Text('Music by Shiki Shiroiwa'),
        ],
      ),
    );
  }
}
