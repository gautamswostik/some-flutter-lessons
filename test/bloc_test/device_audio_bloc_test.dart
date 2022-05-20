import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/application/devide_audio/deviceaudio_bloc.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    "Testing Device Audio Bloc",
    () {
      late DeviceAudioBloc mockDeviceAudioBloc;
      late AudioPlayer mockAudioPlayer;
      setUp(() {
        mockDeviceAudioBloc = MockDeviceAudioBloc();
        mockAudioPlayer = MockAudioPlayer();
      });

      test(
        'The DeviceAudioBloc should emit DeviceAudioPaused as its initial state',
        () {
          when(mockDeviceAudioBloc.state).thenReturn(DeviceAudioPaused());

          expect(mockDeviceAudioBloc.state, isA<DeviceAudioPaused>());

          verify(mockDeviceAudioBloc.state);
        },
      );

      blocTest<DeviceAudioBloc, DeviceAudioState>(
        'Should resume and emit DeviceAudioPaused when PlayDeviceAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.PAUSED);
          when(mockAudioPlayer.resume()).thenAnswer((_) async => 1);
        },
        build: () => DeviceAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(const PlayDeviceAudio(songUrl: 'url')),
        expect: () => [isA<DeviceAudioPlaying>()],
        verify: (bloc) {
          mockAudioPlayer.resume();
        },
      );

      blocTest<DeviceAudioBloc, DeviceAudioState>(
        'Should play and emit DeviceAudioPlaying when PlayDeviceAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.STOPPED);
          when(mockAudioPlayer.play('url')).thenAnswer((_) async => 1);
        },
        build: () => DeviceAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(const PlayDeviceAudio(songUrl: 'url')),
        expect: () => [isA<DeviceAudioPlaying>()],
        verify: (bloc) {
          mockAudioPlayer.play('url');
        },
      );

      blocTest<DeviceAudioBloc, DeviceAudioState>(
        'Should pause and emit DeviceAudioPaused when PlayDeviceAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.PLAYING);
          when(mockAudioPlayer.pause()).thenAnswer((_) async => 1);
        },
        build: () => DeviceAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(const PlayDeviceAudio(songUrl: 'url')),
        expect: () => [isA<DeviceAudioPaused>()],
        verify: (bloc) {
          mockAudioPlayer.pause();
        },
      );
      blocTest<DeviceAudioBloc, DeviceAudioState>(
        'Should emit DeviceAudioPaused when StopDeviceAudio',
        setUp: () {
          when(mockAudioPlayer.stop()).thenAnswer((_) async => 1);
        },
        build: () => DeviceAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(StopDeviceAudio()),
        expect: () => [isA<DeviceAudioPaused>()],
        verify: (bloc) {
          mockAudioPlayer.stop();
        },
      );
    },
  );
}
