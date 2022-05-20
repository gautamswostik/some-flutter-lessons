import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/application/network_radio/networkradio_bloc.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    "Testing Network Audio Bloc",
    () {
      late NetworkAudioBloc mockNetworkAudioBloc;
      late AudioPlayer mockAudioPlayer;
      setUp(() {
        mockNetworkAudioBloc = MockNetworkAudioBloc();
        mockAudioPlayer = MockAudioPlayer();
      });

      test(
        'The NetworkAudioBloc should emit NetworkAudioPaused as its initial state',
        () {
          when(mockNetworkAudioBloc.state).thenReturn(NetworkAudioPaused());

          expect(mockNetworkAudioBloc.state, isA<NetworkAudioPaused>());

          verify(mockNetworkAudioBloc.state);
        },
      );

      blocTest<NetworkAudioBloc, NetworkAudioState>(
        'Should resume and emit NetworkAudioPaused when PlayNetworkAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.PAUSED);
          when(mockAudioPlayer.resume()).thenAnswer((_) async => 1);
        },
        build: () => NetworkAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(PlayNetworkAudio()),
        expect: () => [isA<NetworkAudioPlaying>()],
        verify: (bloc) {
          mockAudioPlayer.resume();
        },
      );

      blocTest<NetworkAudioBloc, NetworkAudioState>(
        'Should play and emit NetworkAudioPlaying when PlayNetworkAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.STOPPED);
          when(mockAudioPlayer
                  .play('https://stream.live.vc.bbcmedia.co.uk/bbc_radio_one'))
              .thenAnswer((_) async => 1);
        },
        build: () => NetworkAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(PlayNetworkAudio()),
        expect: () => [isA<NetworkAudioPlaying>()],
        verify: (bloc) {
          mockAudioPlayer
              .play('https://stream.live.vc.bbcmedia.co.uk/bbc_radio_one');
        },
      );

      blocTest<NetworkAudioBloc, NetworkAudioState>(
        'Should pause and emit NetworkAudioPaused when PlayNetworkAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.PLAYING);
          when(mockAudioPlayer.pause()).thenAnswer((_) async => 1);
        },
        build: () => NetworkAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(PlayNetworkAudio()),
        expect: () => [isA<NetworkAudioPaused>()],
        verify: (bloc) {
          mockAudioPlayer.pause();
        },
      );
      blocTest<NetworkAudioBloc, NetworkAudioState>(
        'Should emit NetworkAudioPaused when StopNetworkAudio',
        setUp: () {
          when(mockAudioPlayer.stop()).thenAnswer((_) async => 1);
        },
        build: () => NetworkAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(StopNetworkAudio()),
        expect: () => [isA<NetworkAudioPaused>()],
        verify: (bloc) {
          mockAudioPlayer.stop();
        },
      );
    },
  );
}
