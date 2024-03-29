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
        if (audioPlayer.state == PlayerState.paused) {
          await audioPlayer.resume();
          emit(
            AssetAudioPlaying(
              audioPlayer: audioPlayer,
            ),
          );
        } else if (audioPlayer.state == PlayerState.stopped) {
          String audioasset = "assets/sounds/Sunflower_Bloom_better.mp3";
          ByteData bytes =
              await rootBundle.load(audioasset); //load sound from assets
          Uint8List soundbytes = bytes.buffer
              .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
          await audioPlayer.play(
            BytesSource(soundbytes),
          );
          emit(AssetAudioPlaying(
            audioPlayer: audioPlayer,
          ));
        } else if (audioPlayer.state == PlayerState.playing) {
          audioPlayer.pause();
          emit(AssetAudioPaused());
        }
      },
    );
    on<SeekAssetAudio>(
      (event, emit) async {
        await audioPlayer.seek(event.seekDuration);
        await audioPlayer.resume();
        emit(AssetAudioPlaying(
          audioPlayer: audioPlayer,
        ));
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
