import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Services
import 'package:diamond_kgk_app/services/local_storage_service.dart';
import 'package:diamond_kgk_app/services/navigation_service.dart';
import 'package:diamond_kgk_app/services/service_locator.dart';

// BLoC
import 'package:diamond_kgk_app/bloc/filter/filter_bloc.dart';
import 'package:diamond_kgk_app/data/diamond_data.dart'; // where diamondList is stored

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive + open the required box
  await LocalStorageService.init();

  // Setup GetIt locator (optional, if you're using service locator)
  setupLocator();

  // Run your app, passing in bloc providers at the root
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FilterBloc>(
          create: (context) => FilterBloc(allDiamonds: diamondList),
        ),
        // If you have more BLoCs, add them here
      ],
      child: MyApp(),
    ),
  );
}

// If you have a separate router in navigation_service.dart or wherever:

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Provide your GoRouter instance
  final GoRouter _router = appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KGK Diamond Selection',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
    );
  }
}
