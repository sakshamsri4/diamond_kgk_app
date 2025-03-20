import 'package:diamond_kgk_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diamond_kgk_app/services/navigation_service.dart'; // contains appRouter
import 'package:diamond_kgk_app/bloc/cart/cart_bloc.dart';
import 'package:diamond_kgk_app/bloc/filter/filter_bloc.dart';
import 'package:diamond_kgk_app/bloc/theme/theme_cubit.dart';
import 'package:diamond_kgk_app/data/diamond_data.dart'; // Provides diamondList
import 'package:diamond_kgk_app/presentation/screens/filter_page.dart';
import 'package:diamond_kgk_app/presentation/screens/results_page.dart';
import 'package:diamond_kgk_app/presentation/screens/cart_page.dart';
import 'package:diamond_kgk_app/services/theme_storage_service.dart'; // For theme box initialization
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

void main() async {
  // Ensure the test binding is initialized.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up a mock for path_provider.
  const MethodChannel channel = MethodChannel(
    'plugins.flutter.io/path_provider',
  );
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return '.';
        }
        return null;
      });

  // Initialize Hive for testing.
  await Hive.initFlutter();
  // Initialize the boxes used by both LocalStorageService and ThemeStorageService.
  // (Assuming LocalStorageService.init() registers and opens the cartBox.)
  // Also initialize the theme box for ThemeStorageService.
  await LocalStorageService.init();
  await ThemeStorageService.init();

  // Helper function to wrap the app with the required providers.
  Widget buildTestableWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
        BlocProvider<FilterBloc>(
          create: (_) => FilterBloc(allDiamonds: diamondList),
        ),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: MaterialApp.router(routerConfig: appRouter),
    );
  }

  testWidgets('Initial route displays FilterPage', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const FilterPage()));
    await tester.pumpAndSettle();
    expect(find.byType(FilterPage), findsOneWidget);
  });

  testWidgets('Navigating to /results displays ResultsPage', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(const FilterPage()));
    // Navigate to /results.
    appRouter.go('/results');
    await tester.pumpAndSettle();
    expect(find.byType(ResultsPage), findsOneWidget);
  });

  testWidgets('Navigating to /cart displays CartPage', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(const FilterPage()));
    // Navigate to /cart.
    appRouter.go('/cart');
    await tester.pumpAndSettle();
    expect(find.byType(CartPage), findsOneWidget);
  });
}
