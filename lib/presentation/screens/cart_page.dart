import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_state.dart';
import '../../bloc/cart/cart_event.dart';
import '../../data/models/diamond_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () => context.read<CartBloc>().add(LoadCartEvent()),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.cartItems;

          if (cartItems.isEmpty) {
            return const Center(child: Text('No items in cart.'));
          }

          // Calculate summary
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

          return Column(
            children: [
              // Summary Row
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _summaryTile('Total Carat', totalCarat.toStringAsFixed(2)),
                    _summaryTile('Total Price', totalPrice.toStringAsFixed(2)),
                    _summaryTile('Avg Price', avgPrice.toStringAsFixed(2)),
                    _summaryTile(
                      'Avg Disc',
                      '${avgDiscount.toStringAsFixed(2)}%',
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final diamond = cartItems[index];
                    return _CartItem(
                      diamond: diamond,
                      onRemove:
                          () => context.read<CartBloc>().add(
                            RemoveFromCartEvent(diamond.lotId),
                          ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _summaryTile(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value),
      ],
    );
  }
}

class _CartItem extends StatelessWidget {
  final DiamondModel diamond;
  final VoidCallback onRemove;

  const _CartItem({Key? key, required this.diamond, required this.onRemove})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text('Lot: ${diamond.lotId}'),
        subtitle: Text(
          'Carat: ${diamond.carat.toStringAsFixed(2)}, '
          'Price: ${diamond.finalAmount.toStringAsFixed(2)}, '
          'Color: ${diamond.color}, Clarity: ${diamond.clarity}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
