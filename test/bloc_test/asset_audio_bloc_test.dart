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
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.paused);
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
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.stopped);
          String audioasset = "assets/sounds/Sunflower_Bloom_better.mp3";
          ByteData bytes =
              await rootBundle.load(audioasset); //load sound from assets
          Uint8List soundbytes = bytes.buffer
              .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
          when(mockAudioPlayer.play(BytesSource(soundbytes)))
              .thenAnswer((_) async => 1);
        },
        build: () => AssetAudioBloc(
            audioPlayer: mockAudioPlayer, audioCache: mockAudioCache),
        act: (bloc) => bloc.add(PlayAssetAudio()),
        expect: () => [isA<AssetAudioPlaying>()],
        verify: (bloc) async {
          String audioasset = "assets/sounds/Sunflower_Bloom_better.mp3";
          ByteData bytes =
              await rootBundle.load(audioasset); //load sound from assets
          Uint8List soundbytes = bytes.buffer
              .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
          mockAudioPlayer.play(BytesSource(soundbytes));
        },
      );

      blocTest<AssetAudioBloc, AssetAudioState>(
        'Should pause and emit AssetAudioPaused when PlayAssetAudio',
        setUp: () {
          when(mockAudioPlayer.state).thenAnswer((_) => PlayerState.playing);
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
      blocTest<AssetAudioBloc, AssetAudioState>(
        'Should emit AssetAudioPlaying when SeekAssetAudio',
        setUp: () {
          when(mockAudioPlayer.seek(const Duration(microseconds: 1)))
              .thenAnswer((_) async => 1);
          when(mockAudioPlayer.resume()).thenAnswer((_) async => 1);
        },
        build: () => AssetAudioBloc(
            audioPlayer: mockAudioPlayer, audioCache: mockAudioCache),
        act: (bloc) => bloc
            .add(const SeekAssetAudio(seekDuration: Duration(microseconds: 1))),
        expect: () => [isA<AssetAudioPlaying>()],
        verify: (bloc) {
          mockAudioPlayer.seek(const Duration(microseconds: 1));
          mockAudioPlayer.resume();
        },
      );
      tearDown(() {
        mockAssetAudioBloc.close();
        mockAudioPlayer.dispose();
      });
    },
  );
}
