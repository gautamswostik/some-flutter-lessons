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
  Duration length = const Duration();
  int pp = 0;
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
            child: BlocListener<NetworkAudioBloc, NetworkAudioState>(
              // listenWhen: (previous, current) {
              //   return current is NetworkAudioPlaying;
              // },
              listener: (context, state) {
                if (state is NetworkAudioPlaying) {
                  state.audioPlayer.onAudioPositionChanged
                      .listen((currentPosition) {
                    setState(() {
                      position = currentPosition;
                    });
                  });

                  state.audioPlayerStateStream.listen((currentPosition) {
                    setState(() {
                      length = currentPosition;
                    });
                  });

                  setState(() async {
                    pp = await state.audioPlayer.getCurrentPosition() ~/ 1000;
                  });

                  // setState(() async {
                  //   // position = e / vent;
                  //   pp = await state.getCurrentPosition;
                  //   // length = event.duration;
                  // });
                  // state.audioPlayerStateStream.listen((event) {
                  //   setState(() async {
                  //     position = event;
                  //     await state.getCurrentPosition.then(
                  //       (value) async => value = pp,
                  //     );
                  //     // length = event.duration;
                  //   });
                  // });
                }
              },
              child: Column(
                children: [
                  Text(position.toString()),
                  Text(length.toString()),
                  Text(pp.toString()),
                ],
              ),
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
                      child: (state is NetworkAudioLoading)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Icon(
                              (state is NetworkAudioPaused)
                                  ? Icons.play_arrow
                                  : Icons.pause,
                            ),
                    );
                  },
                ),
                // IconButton(
                //   onPressed: () async {
                //     await audioPlayer.notificationService
                //         .startHeadlessService();
                //     await audioPlayer.notificationService.platformChannelInvoke
                //         .call('s', {'s': 's'});
                //     audioPlayer.play(
                //       'https://stream.live.vc.bbcmedia.co.uk/bbc_nepali_radio',
                //     );
                //   },
                //   icon: const Icon(Icons.play_arrow),
                // ),
                // IconButton(
                //   onPressed: () {
                //     audioPlayer.pause();
                //   },
                //   icon: const Icon(Icons.pause),
                // ),
                // IconButton(
                //   onPressed: () {
                //     audioPlayer.stop();
                //   },
                //   icon: const Icon(Icons.stop),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget notification() {
  //   return TabWrapper(
  //     children: [
  //       const Text("Play notification sound: 'messenger.mp3':"),
  //       Btn(
  //         txt: 'Play',
  //         onPressed: () =>
  //             audioCache.play('messenger.mp3', isNotification: true),
  //       ),
  //       const Text('Notification Service'),
  //       Btn(
  //         txt: 'Notification',
  //         onPressed: () async {
  //           await advancedPlayer.notificationService.startHeadlessService();
  //           await advancedPlayer.notificationService.setNotification(
  //             title: 'My Song',
  //             albumTitle: 'My Album',
  //             artist: 'My Artist',
  //             imageUrl: 'Image URL or blank',
  //             forwardSkipInterval: const Duration(seconds: 30),
  //             backwardSkipInterval: const Duration(seconds: 30),
  //             duration: const Duration(minutes: 3),
  //             elapsedTime: const Duration(seconds: 15),
  //             enableNextTrackButton: true,
  //             enablePreviousTrackButton: true,
  //           );

  //           await advancedPlayer.play(
  //             kUrl2,
  //             isLocal: false,
  //           );
  //         },
  //       ),
  //       Btn(
  //         txt: 'Clear Notification',
  //         onPressed: () async {
  //           await advancedPlayer.stop();
  //           await advancedPlayer.notificationService.clearNotification();
  //         },
  //       ),
  //     ],
  //   );
  // }
}
