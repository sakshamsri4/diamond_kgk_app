import 'package:diamond_kgk_app/bloc/filter/filter_event.dart';
import 'package:diamond_kgk_app/bloc/filter/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/filter/filter_bloc.dart';

class DiamondFilterFields extends StatelessWidget {
  const DiamondFilterFields({super.key});

  @override
  Widget build(BuildContext context) {
    // We watch the BLoC's state to show the user's current filter selection
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        // Access your filter fields from the state (e.g., state.filter.fromCarat, state.filter.toCarat, etc.)
        var filter = state.filter;
        final fromCarat = filter.fromCarat ?? 0.0;
        final toCarat = filter.toCarat ?? 5.0;
        final selectedLab = state.filter.lab;
        final selectedShape = state.filter.shape;
        final selectedColor = state.filter.color;
        final selectedClarity = state.filter.clarity;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carat Range
            const Text('Carat Range'),
            RangeSlider(
              values: RangeValues(fromCarat, toCarat),
              min: 0.0,
              max: 10.0,
              divisions: 100,
              labels: RangeLabels(
                fromCarat.toStringAsFixed(2),
                toCarat.toStringAsFixed(2),
              ),
              onChanged: (rangeValues) {
                // Dispatch events for fromCarat and toCarat
                context.read<FilterBloc>().add(
                  UpdateCaratFromEvent(rangeValues.start),
                );
                context.read<FilterBloc>().add(
                  UpdateCaratToEvent(rangeValues.end),
                );
              },
            ),
            Text(
              'From: ${fromCarat.toStringAsFixed(2)}  \t\t\t\t To: ${toCarat.toStringAsFixed(2)}',
            ),

            const SizedBox(height: 16),

            // Lab Dropdown
            DropdownButtonFormField<String>(
              value: selectedLab.isNotEmpty ? selectedLab : null,
              items: const [
                DropdownMenuItem(value: 'GIA', child: Text('GIA')),
                DropdownMenuItem(value: 'HRD', child: Text('HRD')),
                DropdownMenuItem(value: 'In-House', child: Text('In-House')),
              ],
              decoration: const InputDecoration(labelText: 'Select Lab'),
              onChanged: (value) {
                context.read<FilterBloc>().add(UpdateLabEvent(value ?? ''));
              },
            ),
            const SizedBox(height: 16),

            // Shape Dropdown
            DropdownButtonFormField<String>(
              value: selectedShape.isNotEmpty ? selectedShape : null,
              items: const [
                DropdownMenuItem(value: 'BR', child: Text('Round (BR)')),
                DropdownMenuItem(value: 'CU', child: Text('Cushion (CU)')),
                DropdownMenuItem(value: 'EM', child: Text('Emerald (EM)')),
                DropdownMenuItem(value: 'OV', child: Text('Oval (OV)')),
                DropdownMenuItem(value: 'PS', child: Text('Pear (PS)')),
                DropdownMenuItem(value: 'RAD', child: Text('Radiant (RAD)')),
                // ... etc ...
              ],
              decoration: const InputDecoration(labelText: 'Select Shape'),
              onChanged: (value) {
                context.read<FilterBloc>().add(UpdateShapeEvent(value ?? ''));
              },
            ),
            const SizedBox(height: 16),

            // Color Dropdown
            DropdownButtonFormField<String>(
              value: selectedColor.isNotEmpty ? selectedColor : null,
              items: const [
                DropdownMenuItem(value: 'D', child: Text('D')),
                DropdownMenuItem(value: 'E', child: Text('E')),
                DropdownMenuItem(value: 'F', child: Text('F')),
                DropdownMenuItem(value: 'G', child: Text('G')),
                DropdownMenuItem(value: 'H', child: Text('H')),
                DropdownMenuItem(value: 'I', child: Text('I')),
                // ... etc ...
              ],
              decoration: const InputDecoration(labelText: 'Select Color'),
              onChanged: (value) {
                context.read<FilterBloc>().add(UpdateColorEvent(value ?? ''));
              },
            ),
            const SizedBox(height: 16),

            // Clarity Dropdown
            DropdownButtonFormField<String>(
              value: selectedClarity.isNotEmpty ? selectedClarity : null,
              items: const [
                DropdownMenuItem(value: 'FL', child: Text('FL')),
                DropdownMenuItem(value: 'IF', child: Text('IF')),
                DropdownMenuItem(value: 'VVS1', child: Text('VVS1')),
                DropdownMenuItem(value: 'VVS2', child: Text('VVS2')),
                DropdownMenuItem(value: 'VS1', child: Text('VS1')),
                DropdownMenuItem(value: 'VS2', child: Text('VS2')),
                DropdownMenuItem(value: 'SI1', child: Text('SI1')),
                DropdownMenuItem(value: 'SI2', child: Text('SI2')),
                // ... etc ...
              ],
              decoration: const InputDecoration(labelText: 'Select Clarity'),
              onChanged: (value) {
                context.read<FilterBloc>().add(UpdateClarityEvent(value ?? ''));
              },
            ),
          ],
        );
      },
    );
  }
}
