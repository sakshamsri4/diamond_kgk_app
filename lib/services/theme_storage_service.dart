import 'package:hive/hive.dart';

class ThemeStorageService {
  static const String boxName = 'themeBox';
  static const String keyThemeMode = 'themeMode';

  /// Initialize the Hive box for theme settings
  static Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
  }

  /// Returns the Hive box for theme settings
  static Box get themeBox => Hive.box(boxName);

  /// Saves the current theme mode as a string ('light' or 'dark')
  static Future<void> saveThemeMode(String themeMode) async {
    await themeBox.put(keyThemeMode, themeMode);
  }

  /// Retrieves the saved theme mode, defaulting to 'light'
  static String getSavedThemeMode() {
    return themeBox.get(keyThemeMode, defaultValue: 'light');
  }
}
