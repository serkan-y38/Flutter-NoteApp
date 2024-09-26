
abstract class PreferencesRepository {
  Future<void> setTheme(String theme);

  Future<String> getTheme();
}
