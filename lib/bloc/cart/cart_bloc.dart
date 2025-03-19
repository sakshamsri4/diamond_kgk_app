import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diamond_kgk_app/services/local_storage_service.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState.initial()) {
    // Auto-load the cart from Hive on creation
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);

    // Immediately load existing items
    add(LoadCartEvent());
  }

  // 1) Load cart items from Hive
  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    final diamonds = LocalStorageService.getAllCartItems();
    emit(state.copyWith(cartItems: diamonds));
  }

  // 2) Add item
  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    // Write to local storage
    await LocalStorageService.addToCart(event.diamond);

    // Reload
    final newItems = LocalStorageService.getAllCartItems();
    emit(state.copyWith(cartItems: newItems));
  }

  // 3) Remove item
  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    await LocalStorageService.removeFromCart(event.lotId);

    final updatedItems = LocalStorageService.getAllCartItems();
    emit(state.copyWith(cartItems: updatedItems));
  }

  // 4) Clear cart
  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    await LocalStorageService.clearCart();
    emit(state.copyWith(cartItems: []));
  }

  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is ClearCartEvent) {
      // Directly clear the cart items
      yield CartState(
        cartItems: [],
      ); // Assuming CartState takes a list of cart items
    }
    // Handle other events
  }
}
