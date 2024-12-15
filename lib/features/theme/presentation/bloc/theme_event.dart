part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class SetThemeRequest extends ThemeEvent {
  const SetThemeRequest({required this.theme});
  final ThemeMode theme;

  @override
  List<Object?> get props => [theme];
}

class GetThemeRequest extends ThemeEvent {
  const GetThemeRequest();
}