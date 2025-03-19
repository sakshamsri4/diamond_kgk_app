import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diamond_kgk_app/bloc/cart/cart_bloc.dart';

class CartIconWithBadge extends StatelessWidget {
  const CartIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to changes in the cartItems
    final cartCount = context.select<CartBloc, int>(
      (bloc) => bloc.state.cartItems.length,
    );

    return Stack(
      children: [
        const Icon(Icons.shopping_cart, size: 30),

        // Show a badge if there's at least 1 item in cart
        if (cartCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                '$cartCount',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
