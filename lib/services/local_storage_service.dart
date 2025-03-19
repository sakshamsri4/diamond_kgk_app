import 'package:hive_flutter/hive_flutter.dart';

import '../data/models/diamond_model.dart';

class LocalStorageService {
  static const String cartBoxName = 'cartBox'; // Box name for storing cart data

  // Initializes Hive and opens the cart box
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DiamondModelAdapter()); // Register the Hive Adapter
    await Hive.openBox<DiamondModel>(cartBoxName);
  }

  // Returns the Hive box instance for cart
  static Box<DiamondModel> get cartBox => Hive.box<DiamondModel>(cartBoxName);

  // Adds a DiamondModel item to the cart
  static Future<void> addToCart(DiamondModel diamond) async {
    await cartBox.put(diamond.lotId, diamond);
  }

  // Removes an item from the cart using the diamond's lotId
  static Future<void> removeFromCart(String diamondId) async {
    await cartBox.delete(diamondId);
  }

  // Retrieves a DiamondModel item from the cart
  static DiamondModel? getCartItem(String diamondId) {
    return cartBox.get(diamondId);
  }

  // Retrieves all DiamondModel items currently in the cart
  static List<DiamondModel> getAllCartItems() {
    return cartBox.values.toList();
  }

  // Clears all items from the cart
  static Future<void> clearCart() async {
    await cartBox.clear();
  }
}
