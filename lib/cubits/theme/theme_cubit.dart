import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(theme: ThemeData.light()));
  void themeDark() {
    emit(ThemeInitial(theme: ThemeData.dark()));
  }

  void themeLight() {
    emit(ThemeInitial(theme: ThemeData.light()));
  }
}
