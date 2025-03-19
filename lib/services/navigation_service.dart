import 'package:go_router/go_router.dart';

import '../presentation/screens/cart_page.dart';
import '../presentation/screens/filter_page.dart';
import '../presentation/screens/results_page.dart';

final GoRouter appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const FilterPage(),
  ),
  GoRoute(
    path: '/results',
    builder: (context, state) => const ResultsPage(),
  ),
  GoRoute(
    path: '/cart',
    builder: (context, state) => const CartPage(),
  ),
]);
