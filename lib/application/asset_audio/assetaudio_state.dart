part of 'assetaudio_bloc.dart';

abstract class AssetAudioState extends Equatable {
  const AssetAudioState();

  @override
  List<Object> get props => [];
}

class AssetaudioInitial extends AssetAudioState {}

class AssetAudioInitial extends AssetAudioState {}

class AssetAudioPlaying extends AssetAudioState {
  final AudioPlayer audioPlayer;

  const AssetAudioPlaying({
    required this.audioPlayer,
  });

  @override
  List<Object> get props => [audioPlayer];
}

class AssetAudioPaused extends AssetAudioState {}
