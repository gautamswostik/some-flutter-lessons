part of 'networkradio_bloc.dart';

abstract class NetworkrAudioEvent extends Equatable {
  const NetworkrAudioEvent();

  @override
  List<Object> get props => [];
}

class PlayNetworkAudio extends NetworkrAudioEvent {
  final bool isInitial;

  const PlayNetworkAudio({required this.isInitial});
  @override
  List<Object> get props => [isInitial];
}

class PauseNetworkAudio extends NetworkrAudioEvent {}
