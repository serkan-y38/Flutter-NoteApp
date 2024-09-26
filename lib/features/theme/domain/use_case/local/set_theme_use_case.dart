import '../../repository/local/preferences_repository.dart';

class SetThemeUseCase {
  final PreferencesRepository _preferencesRepository;

  SetThemeUseCase(this._preferencesRepository);

  Future<void> call(String theme) {
    return _preferencesRepository.setTheme(theme);
  }
}
