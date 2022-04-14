part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeData isDark;
  final bool isDarkValue;

  const ThemeLoaded({
    required this.isDark,
    required this.isDarkValue,
  });

  @override
  List<Object> get props => [isDark, isDarkValue];
}
