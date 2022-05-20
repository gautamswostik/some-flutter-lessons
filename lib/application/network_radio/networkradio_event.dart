part of 'networkradio_bloc.dart';

abstract class NetworkrAudioEvent extends Equatable {
  const NetworkrAudioEvent();

  @override
  List<Object> get props => [];
}

class PlayNetworkAudio extends NetworkrAudioEvent {

}

class StopNetworkAudio extends NetworkrAudioEvent {}
