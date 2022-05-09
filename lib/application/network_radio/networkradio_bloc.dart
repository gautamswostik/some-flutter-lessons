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
  }) : super(const NetworkAudioPaused(
          getDuration: 0,
        )) {
    on<NetworkrAudioEvent>((event, emit) {});
    on<PlayNetworkAudio>((event, emit) async {
      int getDuration = await audioPlayer.getDuration();
      emit(NetworkAudioLoading());
      if (audioPlayer.state == PlayerState.PAUSED) {
        audioPlayer.resume();
        emit(NetworkAudioPlaying(
          audioPlayer: audioPlayer,
          onAudioPositionChanged: audioPlayer.onAudioPositionChanged,
          getCurrentPosition: audioPlayer.getCurrentPosition(),
        ));
      } else if (audioPlayer.state == PlayerState.STOPPED) {
        audioPlayer.play(
          'https://stream.live.vc.bbcmedia.co.uk/bbc_radio_one',
        );
        emit(NetworkAudioPlaying(
          audioPlayer: audioPlayer,
          onAudioPositionChanged: audioPlayer.onAudioPositionChanged,
          getCurrentPosition: audioPlayer.getCurrentPosition(),
        ));
      } else if (audioPlayer.state == PlayerState.PLAYING) {
        audioPlayer.pause();

        emit(NetworkAudioPaused(
          getDuration: getDuration,
        ));
      }
    });
  }
}
