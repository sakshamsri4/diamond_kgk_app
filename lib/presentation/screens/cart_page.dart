import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_state.dart';
import '../../bloc/cart/cart_event.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () => context.read<CartBloc>().add(ClearCartEvent()),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.cartItems;
          if (cartItems.isEmpty) {
            return const Center(child: Text('No items in cart.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final diamond = cartItems[index];
              return Card(
                color: theme.cardTheme.color,
                elevation: theme.cardTheme.elevation,
                shape: theme.cardTheme.shape,
                margin: theme.cardTheme.margin,
                child: ListTile(
                  title: Text(
                    'Lot: ${diamond.lotId}',
                    style: theme.textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    'Carat: ${diamond.carat.toStringAsFixed(2)}, '
                    'Price: ${diamond.finalAmount.toStringAsFixed(2)}, '
                    'Color: ${diamond.color}, Clarity: ${diamond.clarity}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed:
                        () => context.read<CartBloc>().add(
                          RemoveFromCartEvent(diamond.lotId),
                        ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.cartItems;
          if (cartItems.isEmpty) return const SizedBox.shrink();

          // Calculate summary values.
          final totalCarat = cartItems.fold<double>(
            0.0,
            (sum, d) => sum + d.carat,
          );
          final totalPrice = cartItems.fold<double>(
            0.0,
            (sum, d) => sum + d.finalAmount,
          );
          final avgPrice =
              cartItems.isNotEmpty ? (totalPrice / cartItems.length) : 0.0;
          final totalDiscount = cartItems.fold<double>(
            0.0,
            (sum, d) => sum + d.discount,
          );
          final avgDiscount =
              cartItems.isNotEmpty ? (totalDiscount / cartItems.length) : 0.0;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _summaryTile(
                  'Total Carat',
                  totalCarat.toStringAsFixed(2),
                  theme,
                ),
                _summaryTile(
                  'Total Price',
                  totalPrice.toStringAsFixed(2),
                  theme,
                ),
                _summaryTile('Avg Price', avgPrice.toStringAsFixed(2), theme),
                _summaryTile(
                  'Avg Disc',
                  '${avgDiscount.toStringAsFixed(2)}%',
                  theme,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _summaryTile(String label, String value, ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
