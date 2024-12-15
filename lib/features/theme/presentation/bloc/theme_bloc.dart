
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/theme/data/data_source/theme_local_data_source.dart';
import 'package:ecommerce_app/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:ecommerce_app/features/theme/domain/usecases/set_theme_use_case.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  ThemeBloc() : super(const ThemeInitialize()) {
   on<SetThemeRequest>(_onSetTheme);
   on<GetThemeRequest>(_onGetTheme);
  }

  final SetThemeMode setThemeMode = sl<SetThemeMode>();
  final GetThemeMode getThemeMode = sl<GetThemeMode>();
  final ThemeLocalDataSource themeLocalDataSource = sl<ThemeLocalDataSource>();


  Future<void> _onSetTheme(SetThemeRequest event, Emitter<ThemeState> emit) async {
    debugPrint('trigger set theme');
    emit(SetThemeLoading());
    final response = await setThemeMode(SetThemeParam(theme: event.theme));
    response.fold(
        (failure) {
          debugPrint('check set theme error: $failure');
          emit(SetThemeError());
        },
        (theme) {
          debugPrint('check set theme success: ${theme.name}');
          themeLocalDataSource.setTheme(theme);
          emit(SetThemeSuccess(theme: theme));
        }
    );
  }

  Future<void> _onGetTheme(GetThemeRequest event, Emitter<ThemeState> emit) async {
    debugPrint('trigger get theme');
    emit(GetThemeLoading());
    final response = await getThemeMode(NoParams());
    response.fold(
        (failure) {
          debugPrint('check get theme error: $failure');
          emit(GetThemeError());
        },
        (theme) {
          debugPrint('check get theme success: ${theme.name}');
          emit(SetThemeSuccess(theme: theme));
        }
    );
  }
}