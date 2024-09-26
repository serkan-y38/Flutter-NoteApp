import '../../repository/local/preferences_repository.dart';

class GetThemeUseCase {
  final PreferencesRepository _preferencesRepository;

  GetThemeUseCase(this._preferencesRepository);

  Future<String> call() {
    return _preferencesRepository.getTheme();
  }
}
