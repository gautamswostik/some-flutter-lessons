import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/network_radio/networkradio_bloc.dart';

class NetworkAudioPlayer extends StatefulWidget {
  const NetworkAudioPlayer({Key? key}) : super(key: key);

  @override
  State<NetworkAudioPlayer> createState() => _NetworkAudioPlayerState();
}

class _NetworkAudioPlayerState extends State<NetworkAudioPlayer> {
  Duration position = const Duration();

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
          Image.network(
            'https://ichef.bbci.co.uk/images/ic/1200x675/p029j9mc.jpg',
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;

              return const LinearProgressIndicator();
            },
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<NetworkAudioBloc, NetworkAudioState>(
              builder: (context, state) {
                if (state is NetworkAudioPlaying) {
                  state.audioPlayer.onPositionChanged
                      .listen((currentPosition) {
                    setState(() {
                      position = currentPosition;
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
                BlocBuilder<NetworkAudioBloc, NetworkAudioState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        shape: const CircleBorder(),
                        minimumSize: const Size.square(80),
                      ),
                      onPressed: () async {
                        BlocProvider.of<NetworkAudioBloc>(context).add(
                          PlayNetworkAudio(),
                        );
                      },
                      child: Icon(
                        (state is NetworkAudioPaused)
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
    );
  }
}
