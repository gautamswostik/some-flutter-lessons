part of 'assetaudio_bloc.dart';

abstract class AssetAudioEvent extends Equatable {
  const AssetAudioEvent();

  @override
  List<Object> get props => [];
}

class PlayAssetAudio extends AssetAudioEvent {}

class StopAssetAudio extends AssetAudioEvent {}
