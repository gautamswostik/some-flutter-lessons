import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/application/device_audio/deviceaudio_bloc.dart';
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
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.paused);
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
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.stopped);
          when(mockAudioPlayer.play(UrlSource('url')))
              .thenAnswer((_) async => 1);
        },
        build: () => DeviceAudioBloc(audioPlayer: mockAudioPlayer),
        act: (bloc) => bloc.add(const PlayDeviceAudio(songUrl: 'url')),
        expect: () => [isA<DeviceAudioPlaying>()],
        verify: (bloc) {
          mockAudioPlayer.play(UrlSource('url'));
        },
      );

      blocTest<DeviceAudioBloc, DeviceAudioState>(
        'Should pause and emit DeviceAudioPaused when PlayDeviceAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.playing);
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

      blocTest<DeviceAudioBloc, DeviceAudioState>(
        'Should emit AssetDevicePlaying when SeekDeviceAudio',
        setUp: () {
          when(mockAudioPlayer.seek(const Duration(microseconds: 1)))
              .thenAnswer((_) async => 1);
          when(mockAudioPlayer.resume()).thenAnswer((_) async => 1);
        },
        build: () => DeviceAudioBloc(
          audioPlayer: mockAudioPlayer,
        ),
        act: (bloc) => bloc.add(
            const SeekDeviceAudio(seekDuration: Duration(microseconds: 1))),
        expect: () => [isA<DeviceAudioPlaying>()],
        verify: (bloc) {
          mockAudioPlayer.seek(const Duration(microseconds: 1));
          mockAudioPlayer.resume();
        },
      );
      tearDown(() {
        mockDeviceAudioBloc.close();
        mockAudioPlayer.dispose();
      });
    },
  );
}
