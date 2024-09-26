import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/core/theme/theme.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: MaterialTheme.lightScheme());

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: MaterialTheme.darkScheme());

enum AppTheme { themeKey, light, dark, systemSetting }

class ThemeUtils {
  static ThemeData getThemeData(AppTheme theme, BuildContext context) {
    ThemeData themeData;
    if (theme == AppTheme.dark) {
      themeData = darkTheme;
    } else if (theme == AppTheme.light) {
      themeData = lightTheme;
    } else {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        themeData = darkTheme;
      } else {
        themeData = lightTheme;
      }
    }
    _setSystemBarsColor(themeData);
    return themeData;
  }

  static void _setSystemBarsColor(ThemeData theme) {
    SystemUiOverlayStyle systemUiOverlayStyle;
    if (theme == lightTheme) {
      systemUiOverlayStyle = SystemUiOverlayStyle(
          systemNavigationBarColor: MaterialTheme.lightScheme().surface,
          statusBarColor: MaterialTheme.lightScheme().surface,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
      );
    } else {
      systemUiOverlayStyle = SystemUiOverlayStyle(
        systemNavigationBarColor: MaterialTheme.darkScheme().surface,
        statusBarColor: MaterialTheme.darkScheme().surface,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      );
    }
    _setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  static Future<void> _setSystemUIOverlayStyle(
      SystemUiOverlayStyle style) async {
    await Future.delayed(const Duration(milliseconds: 100));
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}
