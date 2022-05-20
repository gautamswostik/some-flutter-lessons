part of 'assetaudio_bloc.dart';

abstract class AssetAudioEvent extends Equatable {
  const AssetAudioEvent();

  @override
  List<Object> get props => [];
}

class PlayAssetAudio extends AssetAudioEvent {}

class SeekAssetAudio extends AssetAudioEvent {
  final Duration seekDuration;

  const SeekAssetAudio({required this.seekDuration});

  @override
  List<Object> get props => [seekDuration];
}

class StopAssetAudio extends AssetAudioEvent {}
