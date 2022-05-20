part of 'deviceaudio_bloc.dart';

abstract class DeviceAudioState extends Equatable {
  const DeviceAudioState();

  @override
  List<Object> get props => [];
}

class DeviceaudioInitial extends DeviceAudioState {}

class DeviceAudioInitial extends DeviceAudioState {}

class DeviceAudioPlaying extends DeviceAudioState {
  final AudioPlayer audioPlayer;

  const DeviceAudioPlaying({
    required this.audioPlayer,
  });

  @override
  List<Object> get props => [audioPlayer];
}

class DeviceAudioPaused extends DeviceAudioState {}
