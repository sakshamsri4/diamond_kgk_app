import 'package:equatable/equatable.dart';
import 'package:diamond_kgk_app/data/models/diamond_model.dart';

class CartState extends Equatable {
  final List<DiamondModel> cartItems;

  const CartState({required this.cartItems});

  const CartState.initial() : cartItems = const [];

  CartState copyWith({List<DiamondModel>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }

  @override
  List<Object> get props => [cartItems];
}
