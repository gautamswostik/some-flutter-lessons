part of 'networkradio_bloc.dart';

abstract class NetworkAudioState extends Equatable {
  const NetworkAudioState();

  @override
  List<Object> get props => [];
}

class NetworkAudioInitial extends NetworkAudioState {}

class NetworkAudioPlaying extends NetworkAudioState {
  final AudioPlayer audioPlayer;

  const NetworkAudioPlaying({
    required this.audioPlayer,
  });

  @override
  List<Object> get props => [audioPlayer];
}

class NetworkAudioPaused extends NetworkAudioState {}
