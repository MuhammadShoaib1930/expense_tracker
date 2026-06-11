import 'package:hive_flutter/hive_flutter.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class SettingsModel extends HiveObject {
  @HiveField(0)
  final bool isDark;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final String profileImagePath;
  @HiveField(3)
  final int token;
  SettingsModel({
    required this.isDark,
    required this.userName,
    required this.profileImagePath,
    required this.token,
  });

  SettingsModel copyWith({
    bool? isDark,
    String? userName,
    String? profileImagePath,
    int? token,
  }) {
    return SettingsModel(
      isDark: isDark ?? this.isDark,
      userName: userName ?? this.userName,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      token: token ?? this.token,
    );
  }
}
