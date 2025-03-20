import 'package:flutter_test/flutter_test.dart';
import 'package:diamond_kgk_app/services/local_storage_service.dart';
import 'package:diamond_kgk_app/data/models/diamond_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

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

  group('LocalStorageService', () {
    // Obtain a reference to the Hive box used by LocalStorageService.
    final box = LocalStorageService.cartBox;

    // Clear the box before each test to ensure isolation.
    setUp(() async {
      await box.clear();
    });

    // Clean up Hive after all tests are done.
    tearDownAll(() async {
      // Provide a non-null path argument to avoid the "null" error.
      await Hive.deleteBoxFromDisk(LocalStorageService.cartBoxName, path: '.');
    });

    // Create a dummy DiamondModel instance.
    final dummyDiamond = DiamondModel(
      lotId: '001',
      carat: 1.5,
      finalAmount: 1500.0,
      discount: 10.0,
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
      labComment: 'Test comment',
    );

    test('init should open the box', () {
      expect(box.isOpen, true);
    });

    test('addToCart adds a diamond to the box', () async {
      await LocalStorageService.addToCart(dummyDiamond);
      final diamond = LocalStorageService.getCartItem(dummyDiamond.lotId);
      expect(diamond, isNotNull);
      expect(diamond!.lotId, dummyDiamond.lotId);
    });

    test('getAllCartItems returns all diamonds', () async {
      await LocalStorageService.addToCart(dummyDiamond);
      // Create another diamond with a different lotId.
      final anotherDiamond = DiamondModel(
        lotId: '002',
        carat: 2.0,
        finalAmount: 3000.0,
        discount: 5.0,
        size: 1.0,
        clarity: 'VVS1',
        color: 'E',
        cut: 'Princess',
        polish: 'Very Good',
        symmetry: 'Very Good',
        fluorescence: 'Faint',
        perCaratRate: 1500.0,
        lab: 'IGI',
        shape: 'Princess',
        keyToSymbol: 'E',
        labComment: 'Test comment 2',
      );
      await LocalStorageService.addToCart(anotherDiamond);
      final items = LocalStorageService.getAllCartItems();
      expect(items.length, 2);
    });

    test('removeFromCart removes the diamond', () async {
      await LocalStorageService.addToCart(dummyDiamond);
      await LocalStorageService.removeFromCart(dummyDiamond.lotId);
      final diamond = LocalStorageService.getCartItem(dummyDiamond.lotId);
      expect(diamond, isNull);
    });

    test('clearCart clears all diamonds', () async {
      await LocalStorageService.addToCart(dummyDiamond);
      final anotherDiamond = DiamondModel(
        lotId: '002',
        carat: 2.0,
        finalAmount: 3000.0,
        discount: 5.0,
        size: 1.0,
        clarity: 'VVS1',
        color: 'E',
        cut: 'Princess',
        polish: 'Very Good',
        symmetry: 'Very Good',
        fluorescence: 'Faint',
        perCaratRate: 1500.0,
        lab: 'IGI',
        shape: 'Princess',
        keyToSymbol: 'E',
        labComment: 'Test comment 2',
      );
      await LocalStorageService.addToCart(anotherDiamond);
      await LocalStorageService.clearCart();
      final items = LocalStorageService.getAllCartItems();
      expect(items, isEmpty);
    });
  });
}
