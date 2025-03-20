// filter_state.dart
import 'package:diamond_kgk_app/data/models/filter.dart';
import 'package:equatable/equatable.dart';
import 'package:diamond_kgk_app/data/models/diamond_model.dart';

class FilterState extends Equatable {
  final Filter filter;
  final List<DiamondModel> filteredDiamonds;
  // If you want to store search results here.

  const FilterState({required this.filter, required this.filteredDiamonds});

  factory FilterState.initial() {
    return FilterState(
      filter: const Filter(), // all default/empty
      filteredDiamonds: const [],
    );
  }

  FilterState copyWith({Filter? filter, List<DiamondModel>? filteredDiamonds}) {
    return FilterState(
      filter: filter ?? this.filter,
      filteredDiamonds: filteredDiamonds ?? this.filteredDiamonds,
    );
  }

  @override
  List<Object> get props => [filter, filteredDiamonds];
}
