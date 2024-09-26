import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/theme/presentation/bloc/local/theme/theme_event.dart';
import 'package:note_app/features/theme/presentation/bloc/local/theme/theme_state.dart';
import '../../../../../../core/theme/theme_utils.dart';
import '../../../../domain/use_case/local/get_theme_use_case.dart';
import '../../../../domain/use_case/local/set_theme_use_case.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase _getThemeUseCase;
  final SetThemeUseCase _setThemeUseCase;

  ThemeBloc(this._setThemeUseCase, this._getThemeUseCase)
      : super(const ThemeLoading()) {
    on<GetTheme>(onGetTheme);
    on<SetTheme>(onSetTheme);
  }

  Future<void> onGetTheme(GetTheme event, Emitter<ThemeState> emitter) async {
    final theme = await _getThemeUseCase.call();
    if (theme == AppTheme.dark.name) {
      emitter(const GetThemeSuccess(AppTheme.dark));
    } else if (theme == AppTheme.light.name) {
      emitter(const GetThemeSuccess(AppTheme.light));
    } else {
      emitter(const GetThemeSuccess(AppTheme.systemSetting));
    }
  }

  Future<void> onSetTheme(SetTheme event, Emitter<ThemeState> emitter) async {
    await _setThemeUseCase.call(event.theme!.name);
    emitter(GetThemeSuccess(event.theme!));
  }
}
