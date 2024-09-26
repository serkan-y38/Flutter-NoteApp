import '../../../../../../core/theme/theme_utils.dart';

class ThemeState {
  final AppTheme theme;

  const ThemeState(this.theme);
}

class GetThemeSuccess extends ThemeState {
  const GetThemeSuccess(super.theme);
}

class ThemeLoading extends ThemeState {
  const ThemeLoading() : super(AppTheme.systemSetting);
}
