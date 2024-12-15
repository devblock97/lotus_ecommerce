part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();
  @override
  List<Object?> get props => [];

}

class ThemeInitialize extends ThemeState {
  const ThemeInitialize();
}

class SetThemeSuccess extends ThemeState {
  const SetThemeSuccess({required this.theme});
  final ThemeMode theme;
  @override
  List<Object?> get props => [theme];
 }

class SetThemeError extends ThemeState { }

class SetThemeLoading extends ThemeState { }

class GetThemeSuccess extends ThemeState {
  const GetThemeSuccess({required this.theme});
  final ThemeMode theme;

  @override
  List<Object?> get props => [theme];
}

class GetThemeError extends ThemeState { }

class GetThemeLoading extends ThemeState { }

