part of 'deviceaudio_bloc.dart';

abstract class DeviceAudioEvent extends Equatable {
  const DeviceAudioEvent();

  @override
  List<Object> get props => [];
}

class PlayDeviceAudio extends DeviceAudioEvent {
  final String songUrl;

  const PlayDeviceAudio({required this.songUrl});

  @override
  List<Object> get props => [songUrl];
}

class SeekDeviceAudio extends DeviceAudioEvent {
  final Duration seekDuration;

  const SeekDeviceAudio({required this.seekDuration});

  @override
  List<Object> get props => [seekDuration];
}

class StopDeviceAudio extends DeviceAudioEvent {}
