import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/device_audio/deviceaudio_bloc.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class FileAudioPlayer extends StatefulWidget {
  const FileAudioPlayer({
    Key? key,
    required this.audioPath,
  }) : super(key: key);
  final String audioPath;

  @override
  State<FileAudioPlayer> createState() => _FileAudioPlayerState();
}

class _FileAudioPlayerState extends State<FileAudioPlayer> {
  Duration position = const Duration();
  Duration totalDuration = const Duration();

  @override
  void initState() {
    BlocProvider.of<DeviceAudioBloc>(context)
        .add(PlayDeviceAudio(songUrl: widget.audioPath));
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<DeviceAudioBloc>(context).add(StopDeviceAudio());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppTexts.deviceAudio.translateTo(context),
          ),
        ),
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
                  BlocProvider.of<DeviceAudioBloc>(context).add(
                    SeekDeviceAudio(
                        seekDuration: Duration(milliseconds: value.toInt())),
                  );
                },
                max: totalDuration.inMilliseconds.toDouble(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<DeviceAudioBloc, DeviceAudioState>(
                builder: (context, state) {
                  if (state is DeviceAudioPlaying) {
                    state.audioPlayer.onPositionChanged
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
                    state.audioPlayer.onSeekComplete.listen((_) {
                      BlocProvider.of<DeviceAudioBloc>(context)
                          .add(StopDeviceAudio());
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
                  BlocBuilder<DeviceAudioBloc, DeviceAudioState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          shape: const CircleBorder(),
                          minimumSize: const Size.square(80),
                        ),
                        onPressed: () async {
                          BlocProvider.of<DeviceAudioBloc>(context).add(
                            PlayDeviceAudio(songUrl: widget.audioPath),
                          );
                        },
                        child: Icon(
                          (state is DeviceAudioPaused)
                              ? Icons.play_arrow
                              : Icons.pause,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
