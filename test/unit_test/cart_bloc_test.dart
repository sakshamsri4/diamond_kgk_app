import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diamond_kgk_app/bloc/cart/cart_bloc.dart';
import 'package:diamond_kgk_app/bloc/cart/cart_event.dart';
import 'package:diamond_kgk_app/bloc/cart/cart_state.dart';
import 'package:diamond_kgk_app/services/local_storage_service.dart';
import 'package:diamond_kgk_app/data/models/diamond_model.dart';
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

  // Initialize Hive for testing.
  await Hive.initFlutter();
  await LocalStorageService.init();

  group('CartBloc', () {
    // Obtain a reference to the Hive box used by LocalStorageService.
    final cartBox = Hive.box<DiamondModel>(LocalStorageService.cartBoxName);

    // Clear the box before each test for isolation.
    setUp(() async {
      await cartBox.clear();
    });

    // Test 1: Verify that on initialization when storage is empty,
    // the bloc does not emit any new state (since the empty state equals initial state).
    blocTest<CartBloc, CartState>(
      'emits no additional state on initialization when storage is empty',
      build: () => CartBloc(),
      skip: 1, // Skip the automatic emission from LoadCartEvent.
      expect: () => [],
    );

    // Create a dummy DiamondModel instance.
    final dummyDiamond = DiamondModel(
      lotId: '001',
      carat: 1.0,
      finalAmount: 1000.0,
      discount: 5.0,
      size: 1.0,
      clarity: 'VS1',
      color: 'D',
      cut: 'Round',
      polish: 'Excellent',
      symmetry: 'Excellent',
      fluorescence: 'None',
      perCaratRate: 1000.0,
      lab: 'GIA',
      shape: 'Round',
      keyToSymbol: 'D',
      labComment: 'Test Comment',
    );

    // Test 2: Add a diamond and verify state update.
    blocTest<CartBloc, CartState>(
      'emits updated state after adding a diamond',
      build: () => CartBloc(),
      act: (bloc) async {
        // Wait a tick for initial load.
        await Future.delayed(const Duration(milliseconds: 10));
        bloc.add(AddToCartEvent(dummyDiamond));
      },
      skip: 1,
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        final items = LocalStorageService.getAllCartItems();
        expect(items.length, 1);
        expect(items.first.lotId, dummyDiamond.lotId);
      },
      expect:
          () => [
            // After AddToCartEvent, the bloc should emit a state with the diamond added.
            CartState.initial().copyWith(cartItems: [dummyDiamond]),
          ],
    );

    // Test 3: Remove a diamond and verify that the cart becomes empty.
    blocTest<CartBloc, CartState>(
      'emits updated state after removing a diamond',
      build: () {
        // Pre-populate the storage with a dummy diamond.
        LocalStorageService.addToCart(dummyDiamond);
        return CartBloc();
      },
      act: (bloc) async {
        // Allow initial load.
        await Future.delayed(const Duration(milliseconds: 10));
        bloc.add(RemoveFromCartEvent(dummyDiamond.lotId));
      },
      skip: 1,
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        final items = LocalStorageService.getAllCartItems();
        expect(items.length, 0);
      },
      expect:
          () => [
            // After removal, the cart should be empty.
            CartState.initial().copyWith(cartItems: []),
          ],
    );

    // Test 4: Clear the cart and verify state update.
    blocTest<CartBloc, CartState>(
      'emits updated state after clearing the cart',
      build: () {
        // Pre-populate the storage.
        LocalStorageService.addToCart(dummyDiamond);
        return CartBloc();
      },
      act: (bloc) async {
        // Allow initial load.
        await Future.delayed(const Duration(milliseconds: 10));
        bloc.add(ClearCartEvent());
      },
      skip: 1,
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        final items = LocalStorageService.getAllCartItems();
        expect(items.length, 0);
      },
      expect:
          () => [
            // After clearing, the cart should be empty.
            CartState.initial().copyWith(cartItems: []),
          ],
    );
  });
}
