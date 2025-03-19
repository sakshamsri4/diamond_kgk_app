import 'package:hive_flutter/hive_flutter.dart';

// A service class for managing local storage using Hive.
// This class handles operations related to a cart, storing items identified by a unique diamondId.
class LocalStorageService {
  static const String cartBoxName =
      'cartBox'; // The name of the Hive box used for storing cart items.

  // Initializes the Hive database and opens the cart box.
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(cartBoxName);
  }

  // Returns the Hive box instance for the cart.
  static Box get cartBox => Hive.box(cartBoxName);

  // Adds an item to the cart with the specified diamondId and associated data.
  static Future<void> addToCart(
      String diamondId, Map<String, dynamic> diamondData) async {
    await cartBox.put(diamondId, diamondData);
  }

  // Removes an item from the cart using the specified diamondId.
  static Future<void> removeFromCart(String diamondId) async {
    await cartBox.delete(diamondId);
  }

  // Retrieves the data of a cart item using the specified diamondId.
  static Map<String, dynamic>? getCartItem(String diamondId) {
    return cartBox.get(diamondId);
  }

  // Retrieves all items currently in the cart.
  static List<Map<String, dynamic>> getAllCartItems() {
    return cartBox.values.cast<Map<String, dynamic>>().toList();
  }

  // Clears all items from the cart.
  static Future<void> clearCart() async {
    await cartBox.clear();
  }
}
