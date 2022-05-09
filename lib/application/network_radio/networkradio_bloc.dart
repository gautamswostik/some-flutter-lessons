import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'networkradio_event.dart';
part 'networkradio_state.dart';

class NetworkAudioBloc extends Bloc<NetworkrAudioEvent, NetworkAudioState> {
  AudioPlayer audioPlayer;
  AudioCache audioCache;

  NetworkAudioBloc({
    required this.audioPlayer,
    required this.audioCache,
  }) : super(NetworkAudioPaused()) {
    on<NetworkrAudioEvent>((event, emit) {});
    on<PlayNetworkAudio>((event, emit) {
      emit(NetworkAudioLoading());
      if (audioPlayer.state == PlayerState.PAUSED) {
        audioPlayer.resume();
        emit(NetworkAudioPlaying(
          audioPlayer: audioPlayer,
          audioPlayerStateStream: audioPlayer.onAudioPositionChanged,
          getCurrentPosition: audioPlayer.getCurrentPosition(),
        ));
      } else if (audioPlayer.state == PlayerState.STOPPED) {
        audioPlayer.play(
          'https://stream.live.vc.bbcmedia.co.uk/bbc_radio_one',
        );
        emit(NetworkAudioPlaying(
          audioPlayer: audioPlayer,
          audioPlayerStateStream: audioPlayer.onAudioPositionChanged,
          getCurrentPosition: audioPlayer.getCurrentPosition(),
        ));
      } else if (audioPlayer.state == PlayerState.PLAYING) {
        audioPlayer.pause();
        emit(NetworkAudioPaused());
      }
    });
  }
}
