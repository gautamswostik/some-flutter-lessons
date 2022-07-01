import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'networkradio_event.dart';
part 'networkradio_state.dart';

class NetworkAudioBloc extends Bloc<NetworkrAudioEvent, NetworkAudioState> {
  AudioPlayer audioPlayer;

  NetworkAudioBloc({
    required this.audioPlayer,
  }) : super(NetworkAudioPaused()) {
    on<NetworkrAudioEvent>((event, emit) {});
    on<PlayNetworkAudio>(
      (event, emit) async {
        if (audioPlayer.state == PlayerState.paused) {
          await audioPlayer.resume();

          emit(NetworkAudioPlaying(
            audioPlayer: audioPlayer,
          ));
        } else if (audioPlayer.state == PlayerState.stopped) {
          audioPlayer.play(UrlSource(
            'https://stream.live.vc.bbcmedia.co.uk/bbc_radio_one',
          ));
          emit(NetworkAudioPlaying(
            audioPlayer: audioPlayer,
          ));
        } else if (audioPlayer.state == PlayerState.playing) {
          audioPlayer.pause();

          emit(NetworkAudioPaused());
        }
      },
    );
    on<StopNetworkAudio>(
      (event, emit) async {
        await audioPlayer.stop();

        emit(NetworkAudioPaused());
      },
    );
  }
}
