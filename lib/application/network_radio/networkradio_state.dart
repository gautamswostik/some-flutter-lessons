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
  final Stream<Duration> audioPlayerStateStream;
  final Future<int> getCurrentPosition; 
  const NetworkAudioPlaying({
    required this.audioPlayer,
    required this.audioPlayerStateStream,
    required this.getCurrentPosition
  });

  @override
  List<Object> get props => [audioPlayerStateStream];
}

class NetworkAudioPaused extends NetworkAudioState {}
