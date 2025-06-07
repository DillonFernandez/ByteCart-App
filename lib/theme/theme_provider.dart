import 'package:bytecart/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier, WidgetsBindingObserver {
  ThemeData _themeData;

  ThemeProvider()
    : _themeData =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark
              ? darkMode
              : lightMode {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    updateThemeBasedOnSystemBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ThemeData get themeData => _themeData;

  set themeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  void updateThemeBasedOnSystemBrightness() {
    themeData =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark
            ? darkMode
            : lightMode;
  }

  void toggleTheme() {
    themeData = _themeData == lightMode ? darkMode : lightMode;
  }
}
