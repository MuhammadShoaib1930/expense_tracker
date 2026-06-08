import 'package:expense_tracker/models/settings_model.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  SettingsModel settingsModel = HiveService.getSettings();
  ThemeCubit() : super(ThemeInitial()) {
    _themeCheck();
  }
  void _themeCheck() {
    emit(
      ThemeInitial(
        isDark: settingsModel.isDark,
        imagePath: settingsModel.profileImagePath,
        userName: settingsModel.userName,
      ),
    );
  }

  void themeTogle() {
    emit(ThemeInitial(isDark: HiveService.getSettings().isDark));
  }
}
