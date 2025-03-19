import 'package:diamond_kgk_app/bloc/filter/filter_state.dart';
import 'package:diamond_kgk_app/presentation/widgets/diamond_filter_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/filter/filter_bloc.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // If the FilterBloc is already provided at a higher level, just return the view:
    return const _FilterPageView();
  }
}

class _FilterPageView extends StatelessWidget {
  const _FilterPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Diamonds'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Reusable widget that holds all filter fields (carat range, lab, shape, color, clarity)
              const DiamondFilterFields(),

              const SizedBox(height: 24),

              // "Search" button
              ElevatedButton(
                onPressed: () {
                  // Dispatch an event or read current filter from BLoC
                  context.read<FilterBloc>().add(SearchDiamondsEvent());
                  // Navigate to ResultsPage using named route
                  context.push('/results');
                },
                child: const Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
