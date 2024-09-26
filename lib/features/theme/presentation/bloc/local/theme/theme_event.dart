import '../../../../../../core/theme/theme_utils.dart';

abstract class ThemeEvent {
  final AppTheme? theme;

  const ThemeEvent({this.theme});
}

class SetTheme extends ThemeEvent {
  const SetTheme(AppTheme theme) : super(theme: theme);
}

class GetTheme extends ThemeEvent {
  const GetTheme() : super();
}
