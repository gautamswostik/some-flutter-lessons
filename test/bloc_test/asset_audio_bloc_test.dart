import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fluuter_boilerplate/application/asset_audio/assetaudio_bloc.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group(
    "Testing Asset Audio Bloc",
    () {
      late AssetAudioBloc mockAssetAudioBloc;
      late AudioPlayer mockAudioPlayer;
      late AudioCache mockAudioCache;
      setUp(() {
        mockAssetAudioBloc = MockAssetAudioBloc();
        mockAudioPlayer = MockAudioPlayer();
        mockAudioCache = MockAudioCache();
      });

      test(
        'The AssetAudioBloc should emit AssetAudioPaused as its initial state',
        () {
          when(mockAssetAudioBloc.state).thenReturn(AssetAudioPaused());

          expect(mockAssetAudioBloc.state, isA<AssetAudioPaused>());

          verify(mockAssetAudioBloc.state);
        },
      );

      blocTest<AssetAudioBloc, AssetAudioState>(
        'Should resume and emit AssetAudioPaused when PlayAssetAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.PAUSED);
          when(mockAudioPlayer.resume()).thenAnswer((_) async => 1);
        },
        build: () => AssetAudioBloc(
            audioPlayer: mockAudioPlayer, audioCache: mockAudioCache),
        act: (bloc) => bloc.add(PlayAssetAudio()),
        expect: () => [isA<AssetAudioPlaying>()],
        verify: (bloc) {
          mockAudioPlayer.resume();
        },
      );

      blocTest<AssetAudioBloc, AssetAudioState>(
        'Should play and emit AssetAudioPlaying when PlayAssetAudio',
        setUp: () async {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.STOPPED);
          String audioasset = "assets/sounds/bensound-ukulele.mp3";
          ByteData bytes =
              await rootBundle.load(audioasset); //load sound from assets
          Uint8List soundbytes = bytes.buffer
              .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
          when(mockAudioPlayer.playBytes(soundbytes))
              .thenAnswer((_) async => 1);
        },
        build: () => AssetAudioBloc(
            audioPlayer: mockAudioPlayer, audioCache: mockAudioCache),
        act: (bloc) => bloc.add(PlayAssetAudio()),
        expect: () => [isA<AssetAudioPlaying>()],
        verify: (bloc) async {
          String audioasset = "assets/sounds/bensound-ukulele.mp3";
          ByteData bytes =
              await rootBundle.load(audioasset); //load sound from assets
          Uint8List soundbytes = bytes.buffer
              .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
          mockAudioPlayer.playBytes(soundbytes);
        },
      );

      blocTest<AssetAudioBloc, AssetAudioState>(
        'Should pause and emit AssetAudioPaused when PlayAssetAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.PLAYING);
          when(mockAudioPlayer.pause()).thenAnswer((_) async => 1);
        },
        build: () => AssetAudioBloc(
            audioPlayer: mockAudioPlayer, audioCache: mockAudioCache),
        act: (bloc) => bloc.add(PlayAssetAudio()),
        expect: () => [isA<AssetAudioPaused>()],
        verify: (bloc) {
          mockAudioPlayer.pause();
        },
      );
      blocTest<AssetAudioBloc, AssetAudioState>(
        'Should emit AssetAudioPaused when StopAssetAudio',
        setUp: () {
          when(mockAudioPlayer.stop()).thenAnswer((_) async => 1);
        },
        build: () => AssetAudioBloc(
            audioPlayer: mockAudioPlayer, audioCache: mockAudioCache),
        act: (bloc) => bloc.add(StopAssetAudio()),
        expect: () => [isA<AssetAudioPaused>()],
        verify: (bloc) {
          mockAudioPlayer.stop();
        },
      );
    },
  );
}
