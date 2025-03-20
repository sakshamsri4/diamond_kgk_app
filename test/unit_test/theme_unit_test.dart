import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diamond_kgk_app/bloc/theme/theme_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Ensure the test binding is initialized.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up a mock for path_provider to avoid MissingPluginException.
  const MethodChannel channel = MethodChannel(
    'plugins.flutter.io/path_provider',
  );
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          // Return a dummy directory path.
          return '.';
        }
        return null;
      });

  // Initialize Hive for testing. This creates a temporary directory for Hive.
  await Hive.initFlutter();
  await Hive.openBox('themeBox');

  group('ThemeCubit', () {
    // Clear the box after each test to ensure isolation.
    tearDown(() async {
      final box = Hive.box('themeBox');
      await box.clear();
    });

    test('initial state is ThemeMode.light when saved theme is "light"', () {
      final box = Hive.box('themeBox');
      box.put('themeMode', 'light');
      final cubit = ThemeCubit();
      expect(cubit.state, ThemeMode.light);
      cubit.close();
    });

    test('initial state is ThemeMode.dark when saved theme is "dark"', () {
      final box = Hive.box('themeBox');
      box.put('themeMode', 'dark');
      final cubit = ThemeCubit();
      expect(cubit.state, ThemeMode.dark);
      cubit.close();
    });

    blocTest<ThemeCubit, ThemeMode>(
      'toggleTheme toggles from light to dark and persists the value',
      build: () {
        final box = Hive.box('themeBox');
        box.put('themeMode', 'light');
        return ThemeCubit();
      },
      act: (cubit) => cubit.toggleTheme(),
      expect: () => [ThemeMode.dark],
      verify: (_) {
        final box = Hive.box('themeBox');
        expect(box.get('themeMode'), 'dark');
      },
    );

    blocTest<ThemeCubit, ThemeMode>(
      'toggleTheme toggles from dark to light and persists the value',
      build: () {
        final box = Hive.box('themeBox');
        box.put('themeMode', 'dark');
        return ThemeCubit();
      },
      act: (cubit) => cubit.toggleTheme(),
      expect: () => [ThemeMode.light],
      verify: (_) {
        final box = Hive.box('themeBox');
        expect(box.get('themeMode'), 'light');
      },
    );
  });
}
