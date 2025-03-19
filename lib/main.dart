import 'package:diamond_kgk_app/bloc/cart/cart_bloc.dart';
import 'package:diamond_kgk_app/bloc/filter/filter_bloc.dart';
import 'package:diamond_kgk_app/bloc/theme/theme_cubit.dart';
import 'package:diamond_kgk_app/core/theme/app_theme.dart';
import 'package:diamond_kgk_app/data/diamond_data.dart';
import 'package:diamond_kgk_app/services/local_storage_service.dart';
import 'package:diamond_kgk_app/services/navigation_service.dart';
import 'package:diamond_kgk_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive + open the required box
  await LocalStorageService.init();

  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FilterBloc>(
          create: (context) => FilterBloc(allDiamonds: diamondList),
        ),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'KGK Diamond Selection',
          routerConfig: _router,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}
