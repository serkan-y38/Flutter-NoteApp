import '../../../domain/repository/local/preferences_repository.dart';
import '../../sources/local/prefences_source.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final PreferencesSource _preferencesSource;

  PreferencesRepositoryImpl(this._preferencesSource);

  @override
  Future<String> getTheme() {
    return _preferencesSource.getTheme();
  }

  @override
  Future<void> setTheme(String theme) {
    return _preferencesSource.setTheme(theme);
  }
}
