import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'assetaudio_event.dart';
part 'assetaudio_state.dart';

class AssetAudioBloc extends Bloc<AssetAudioEvent, AssetAudioState> {
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  AssetAudioBloc({
    required this.audioPlayer,
    required this.audioCache,
  }) : super(AssetAudioPaused()) {
    on<AssetAudioEvent>((event, emit) {});

    on<PlayAssetAudio>(
      (event, emit) async {
        if (audioPlayer.state == PlayerState.PAUSED) {
          await audioPlayer.resume();

          emit(AssetAudioPlaying(
            audioPlayer: audioPlayer,
          ));
        } else if (audioPlayer.state == PlayerState.STOPPED) {
          String audioasset = "assets/sounds/bensound-ukulele.mp3";
          ByteData bytes =
              await rootBundle.load(audioasset); //load sound from assets
          Uint8List soundbytes = bytes.buffer
              .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
          await audioPlayer.playBytes(soundbytes);
          emit(AssetAudioPlaying(
            audioPlayer: audioPlayer,
          ));
        } else if (audioPlayer.state == PlayerState.PLAYING) {
          audioPlayer.pause();

          emit(AssetAudioPaused());
        }
      },
    );

    on<StopAssetAudio>(
      (event, emit) async {
        await audioPlayer.stop();

        emit(AssetAudioPaused());
      },
    );
  }
}
