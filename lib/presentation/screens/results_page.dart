import 'package:diamond_kgk_app/bloc/filter/filter_state.dart';
import 'package:diamond_kgk_app/presentation/widgets/cart_icon_with_badge.dart';
import 'package:diamond_kgk_app/presentation/widgets/diamond_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/filter/filter_bloc.dart';

// Or however you handle cart logic
import '../../data/models/diamond_model.dart';

enum SortOption { finalPriceAsc, finalPriceDesc, caratAsc, caratDesc }

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  SortOption _currentSort = SortOption.finalPriceAsc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        centerTitle: true,
        actions: [
          // Cart icon to navigate to cart page if needed
          IconButton(
            icon: CartIconWithBadge(),
            onPressed: () {
              // Go to cart
              context.push('/cart');
              // or Navigator.pushNamed(context, '/cart'); if not using GoRouter
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Sorting controls
            _buildSortControls(context),

            // Expanded list of diamonds
            Expanded(
              child: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, filterState) {
                  final diamonds = List<DiamondModel>.from(
                    filterState.filteredDiamonds,
                  );
                  // Apply sorting
                  _sortDiamonds(diamonds);

                  if (diamonds.isEmpty) {
                    return const Center(child: Text('No results found.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    itemCount: diamonds.length,
                    itemBuilder: (context, index) {
                      final diamond = diamonds[index];
                      return DiamondItemCard(diamond: diamond);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1) Sorting Controls at the top
  Widget _buildSortControls(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(
            'Sort by:',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          // A Dropdown or segmented control for different sort criteria
          DropdownButton<SortOption>(
            value: _currentSort,
            dropdownColor: theme.colorScheme.surface,
            style: theme.textTheme.bodyMedium,
            items: const [
              DropdownMenuItem(
                value: SortOption.finalPriceAsc,
                child: Text('Price (Asc)'),
              ),
              DropdownMenuItem(
                value: SortOption.finalPriceDesc,
                child: Text('Price (Desc)'),
              ),
              DropdownMenuItem(
                value: SortOption.caratAsc,
                child: Text('Carat (Asc)'),
              ),
              DropdownMenuItem(
                value: SortOption.caratDesc,
                child: Text('Carat (Desc)'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _currentSort = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // 2) Apply sorting to the diamonds list
  void _sortDiamonds(List<DiamondModel> diamonds) {
    switch (_currentSort) {
      case SortOption.finalPriceAsc:
        diamonds.sort((a, b) => a.finalAmount.compareTo(b.finalAmount));
        break;
      case SortOption.finalPriceDesc:
        diamonds.sort((a, b) => b.finalAmount.compareTo(a.finalAmount));
        break;
      case SortOption.caratAsc:
        diamonds.sort((a, b) => a.carat.compareTo(b.carat));
        break;
      case SortOption.caratDesc:
        diamonds.sort((a, b) => b.carat.compareTo(a.carat));
        break;
    }
  }
}
