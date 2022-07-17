import 'package:audioplayers/audioplayers.dart';
import 'package:fluuter_boilerplate/app_setup/languages/entity/language_entity.dart';
import 'package:fluuter_boilerplate/application/app_theme/theme_cubit.dart';
import 'package:fluuter_boilerplate/application/asset_audio/assetaudio_bloc.dart';
import 'package:fluuter_boilerplate/application/device_audio/deviceaudio_bloc.dart';
import 'package:fluuter_boilerplate/application/infinite_list/infinite_list_bloc.dart';
import 'package:fluuter_boilerplate/application/languages/language_cubit.dart';
import 'package:fluuter_boilerplate/application/local_notes/local_notes_bloc.dart';
import 'package:fluuter_boilerplate/application/network_radio/networkradio_bloc.dart';
import 'package:fluuter_boilerplate/infrastructure/infinite_list_repo/infinite_list_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/language_repo/language_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/local_notes_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/annotations.dart';
import 'package:uuid/uuid.dart';

@GenerateMocks([
  ThemeCubit,
  HiveInterface,
  AddThemeRepository,
  Box,
  LanguageCubit,
  LanguageRepository,
  LanguageEntity,
  NetworkAudioBloc,
  AssetAudioBloc,
  DeviceAudioBloc,
  AudioPlayer,
  AudioCache,
  LocalNoteEntity,
  LocalNotesRepository,
  Uuid,
  LocalNotesBloc,
  HiveError,
  GetPostsRepository,
  InfiniteListBloc,
])
void main() {}
