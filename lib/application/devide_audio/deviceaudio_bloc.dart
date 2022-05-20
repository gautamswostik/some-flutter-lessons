import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'deviceaudio_event.dart';
part 'deviceaudio_state.dart';

class DeviceAudioBloc extends Bloc<DeviceAudioEvent, DeviceAudioState> {
  AudioPlayer audioPlayer;

  DeviceAudioBloc({
    required this.audioPlayer,
  }) : super(DeviceaudioInitial()) {
    on<DeviceAudioEvent>((event, emit) {});
    on<PlayDeviceAudio>(
      (event, emit) async {
        if (audioPlayer.state == PlayerState.PAUSED) {
          await audioPlayer.resume();

          emit(DeviceAudioPlaying(
            audioPlayer: audioPlayer,
          ));
        } else if (audioPlayer.state == PlayerState.STOPPED) {
          audioPlayer.play(
            event.songUrl,
          );
          emit(DeviceAudioPlaying(
            audioPlayer: audioPlayer,
          ));
        } else if (audioPlayer.state == PlayerState.PLAYING) {
          audioPlayer.pause();

          emit(DeviceAudioPaused());
        }
      },
    );

    on<SeekDeviceAudio>(
      (event, emit) async {
        await audioPlayer.seek(event.seekDuration);
        await audioPlayer.resume();
        emit(DeviceAudioPlaying(
          audioPlayer: audioPlayer,
        ));
      },
    );
    on<StopDeviceAudio>(
      (event, emit) async {
        await audioPlayer.stop();

        emit(DeviceAudioPaused());
      },
    );
  }
}
