part of 'networkradio_bloc.dart';

abstract class NetworkAudioState extends Equatable {
  const NetworkAudioState();

  @override
  List<Object> get props => [];
}

class NetworkAudioInitial extends NetworkAudioState {}

class NetworkAudioPlaying extends NetworkAudioState {
  final AudioPlayer audioPlayer;
  // final Stream<Duration> onAudioPositionChanged;

  const NetworkAudioPlaying({
    required this.audioPlayer,
    // required this.onAudioPositionChanged,
  });

  // @override
  // List<Object> get props => [onAudioPositionChanged];
}

class NetworkAudioPaused extends NetworkAudioState {}
