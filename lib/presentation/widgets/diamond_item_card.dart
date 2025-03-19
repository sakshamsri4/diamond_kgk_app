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
    final theme = Theme.of(context);
    final cartItems = context.watch<CartBloc>().state.cartItems;
    final isInCart = cartItems.any((d) => d.lotId == diamond.lotId);

    return Card(
      elevation: theme.cardTheme.elevation,
      margin: theme.cardTheme.margin ?? const EdgeInsets.symmetric(vertical: 6),
      shape:
          theme.cardTheme.shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: theme.cardTheme.color,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lot: ${diamond.lotId}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  diamond.shape,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _detailChip(context, 'Carat', diamond.carat.toStringAsFixed(2)),
                _detailChip(context, 'Color', diamond.color),
                _detailChip(context, 'Clarity', diamond.clarity),
                _detailChip(context, 'Lab', diamond.lab),
                _detailChip(
                  context,
                  'Price',
                  diamond.finalAmount.toStringAsFixed(2),
                ),
                if (diamond.discount != 0)
                  _detailChip(
                    context,
                    'Discount',
                    '${diamond.discount.toStringAsFixed(2)}%',
                  ),
              ],
            ),
            const SizedBox(height: 6),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    isInCart
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart,
                    color: theme.colorScheme.onPrimary,
                  ),
                  label: Text(
                    isInCart ? 'Remove' : 'Add to cart',
                    style: TextStyle(color: theme.colorScheme.onPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                  ),
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

  Widget _detailChip(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Chip(
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      label: Text(
        '$label: $value',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
