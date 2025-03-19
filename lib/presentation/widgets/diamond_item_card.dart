import 'package:diamond_kgk_app/bloc/cart/cart_bloc.dart';
import 'package:diamond_kgk_app/bloc/cart/cart_event.dart';
import 'package:diamond_kgk_app/data/models/diamond_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiamondItemCard extends StatelessWidget {
  final DiamondModel diamond;

  const DiamondItemCard({super.key, required this.diamond});

  @override
  Widget build(BuildContext context) {
    // We can read from a CartBloc or a CartService to see if this diamond is in cart
    final cartItems = context.watch<CartBloc>().state.cartItems;
    final isInCart = cartItems.any((d) => d.lotId == diamond.lotId);
    // In a real app, you might do:
    // final isInCart = context.select((CartBloc bloc) => bloc.state.contains(diamond));

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row with main info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lot: ${diamond.lotId}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Possibly display shape as an icon or short text
                Text(
                  diamond.shape,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Some key fields in a flexible layout
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _detailChip('Carat', diamond.carat.toStringAsFixed(2)),
                _detailChip('Color', diamond.color),
                _detailChip('Clarity', diamond.clarity),
                _detailChip('Lab', diamond.lab),
                _detailChip('Price', diamond.finalAmount.toStringAsFixed(2)),
                if (diamond.discount != 0)
                  _detailChip(
                    'Discount',
                    '${diamond.discount.toStringAsFixed(2)}%',
                  ),
              ],
            ),
            const SizedBox(height: 6),

            // "Add to cart" or "Remove" button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    isInCart
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart,
                  ),
                  label: Text(isInCart ? 'Remove' : 'Add to cart'),
                  onPressed: () {
                    if (isInCart) {
                      context.read<CartBloc>().add(
                        RemoveFromCartEvent(diamond.lotId),
                      );
                    } else {
                      context.read<CartBloc>().add(AddToCartEvent(diamond));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // A helper to style detail fields as small chips or labels
  Widget _detailChip(String label, String value) {
    return Chip(
      backgroundColor: Colors.grey[100],
      label: Text('$label: $value'),
    );
  }
}
