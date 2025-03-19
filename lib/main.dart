import 'package:diamond_kgk_app/services/local_storage_service.dart';
import 'package:diamond_kgk_app/services/navigation_service.dart';
import 'package:diamond_kgk_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  // Ensures Flutter is fully initialized before we do async operations
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Hive + Open the required box
  await LocalStorageService.init();

  // 2. Setup GetIt locator (optional, if you're using service locator)
  setupLocator();

  // 3. Run your app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Use your shared GoRouter object
  final GoRouter _router = appRouter;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KGK Diamond Selection',
      // Provide your GoRouter configuration
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true, // optional
      ),
    );
  }
}
