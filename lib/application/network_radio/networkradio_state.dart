part of 'networkradio_bloc.dart';

abstract class NetworkAudioState extends Equatable {
  const NetworkAudioState();

  @override
  List<Object> get props => [];
}

class NetworkAudioInitial extends NetworkAudioState {}

class NetworkAudioLoading extends NetworkAudioState {}

class NetworkAudioPlaying extends NetworkAudioState {
  final AudioPlayer audioPlayer;
  final Stream<Duration> onAudioPositionChanged;
  final Future<int> getCurrentPosition;
  const NetworkAudioPlaying({
    required this.audioPlayer,
    required this.onAudioPositionChanged,
    required this.getCurrentPosition,
  });

  @override
  List<Object> get props => [onAudioPositionChanged];
}

class NetworkAudioPaused extends NetworkAudioState {
  final int getDuration;

  const NetworkAudioPaused({required this.getDuration});

  @override
  List<Object> get props => [getDuration];
}
