import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends ChangeNotifier {
  static const _themeModeKey = 'theme_mode';
  static const _languageKey = 'language';
  static const _notificationsKey = 'notifications_enabled';
  static const _unitSystemKey = 'unit_system';

  AppController._({
    required SharedPreferences preferences,
    required ThemeMode themeMode,
    required String language,
    required bool notificationsEnabled,
    required String unitSystem,
  }) : _preferences = preferences,
       _themeMode = themeMode,
       _language = language,
       _notificationsEnabled = notificationsEnabled,
       _unitSystem = unitSystem;

  final SharedPreferences _preferences;

  ThemeMode _themeMode;
  String _language;
  bool _notificationsEnabled;
  String _unitSystem;

  ThemeMode get themeMode => _themeMode;
  String get language => _language;
  bool get notificationsEnabled => _notificationsEnabled;
  String get unitSystem => _unitSystem;

  static Future<AppController> create() async {
    final preferences = await SharedPreferences.getInstance();

    return AppController._(
      preferences: preferences,
      themeMode: _themeModeFromString(
        preferences.getString(_themeModeKey) ?? 'system',
      ),
      language: preferences.getString(_languageKey) ?? 'Francais',
      notificationsEnabled: preferences.getBool(_notificationsKey) ?? true,
      unitSystem: preferences.getString(_unitSystemKey) ?? 'Metrique',
    );
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _preferences.setString(_themeModeKey, _themeModeToString(mode));
    notifyListeners();
  }

  Future<void> updateLanguage(String language) async {
    _language = language;
    await _preferences.setString(_languageKey, language);
    notifyListeners();
  }

  Future<void> updateNotifications(bool enabled) async {
    _notificationsEnabled = enabled;
    await _preferences.setBool(_notificationsKey, enabled);
    notifyListeners();
  }

  Future<void> updateUnitSystem(String unitSystem) async {
    _unitSystem = unitSystem;
    await _preferences.setString(_unitSystemKey, unitSystem);
    notifyListeners();
  }
  static ThemeMode _themeModeFromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
