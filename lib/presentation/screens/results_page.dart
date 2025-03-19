// results_page.dart
import 'package:diamond_kgk_app/bloc/filter/filter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/filter/filter_bloc.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: SafeArea(
        child: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            final diamonds = state.filteredDiamonds;
            if (diamonds.isEmpty) {
              return const Center(child: Text('No results found.'));
            }
            return ListView.builder(
              itemCount: diamonds.length,
              itemBuilder: (context, index) {
                final d = diamonds[index];
                return ListTile(
                  title: Text('Lot: ${d.lotId}, Carat: ${d.carat}'),
                  subtitle: Text(
                    'Shape: ${d.shape}, Color: ${d.color}, Lab: ${d.lab}',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
