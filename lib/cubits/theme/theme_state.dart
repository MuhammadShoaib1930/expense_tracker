part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {
  final bool isDark;
  final String imagePath;
  final String userName;
  const ThemeInitial({this.isDark=false,this.imagePath="",this.userName="Guest"});
  @override
  List<Object> get props => [isDark, imagePath, userName];
}
