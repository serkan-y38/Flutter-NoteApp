import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/theme/theme_utils.dart';

class PreferencesSource {
  final SharedPreferences _sharedPreferences;

  PreferencesSource(this._sharedPreferences);

  Future<void> setTheme(String theme) async {
    await _sharedPreferences.setString(AppTheme.themeKey.name, theme);
  }

  Future<String> getTheme() async {
    return _sharedPreferences.getString(AppTheme.themeKey.name) ??
        AppTheme.systemSetting.name;
  }
}
