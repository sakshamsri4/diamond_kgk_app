// filter_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:diamond_kgk_app/data/models/diamond_model.dart';
import 'package:diamond_kgk_app/data/models/filter.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final List<DiamondModel> allDiamonds;
  // Or pass a DiamondRepository if you prefer.

  FilterBloc({required this.allDiamonds}) : super(FilterState.initial()) {
    on<UpdateCaratFromEvent>(_onUpdateCaratFrom);
    on<UpdateCaratToEvent>(_onUpdateCaratTo);
    on<UpdateLabEvent>(_onUpdateLab);
    on<UpdateShapeEvent>(_onUpdateShape);
    on<UpdateColorEvent>(_onUpdateColor);
    on<UpdateClarityEvent>(_onUpdateClarity);
    on<SearchDiamondsEvent>(_onSearchDiamonds);
  }

  void _onUpdateCaratFrom(
    UpdateCaratFromEvent event,
    Emitter<FilterState> emit,
  ) {
    final updatedFilter = state.filter.copyWith(fromCarat: event.fromCarat);
    emit(state.copyWith(filter: updatedFilter));
  }

  void _onUpdateCaratTo(UpdateCaratToEvent event, Emitter<FilterState> emit) {
    final updatedFilter = state.filter.copyWith(toCarat: event.toCarat);
    emit(state.copyWith(filter: updatedFilter));
  }

  void _onUpdateLab(UpdateLabEvent event, Emitter<FilterState> emit) {
    final updatedFilter = state.filter.copyWith(lab: event.lab);
    emit(state.copyWith(filter: updatedFilter));
  }

  void _onUpdateShape(UpdateShapeEvent event, Emitter<FilterState> emit) {
    final updatedFilter = state.filter.copyWith(shape: event.shape);
    emit(state.copyWith(filter: updatedFilter));
  }

  void _onUpdateColor(UpdateColorEvent event, Emitter<FilterState> emit) {
    final updatedFilter = state.filter.copyWith(color: event.color);
    emit(state.copyWith(filter: updatedFilter));
  }

  void _onUpdateClarity(UpdateClarityEvent event, Emitter<FilterState> emit) {
    final updatedFilter = state.filter.copyWith(clarity: event.clarity);
    emit(state.copyWith(filter: updatedFilter));
  }

  void _onSearchDiamonds(SearchDiamondsEvent event, Emitter<FilterState> emit) {
    final newList = _applyFilter(state.filter);
    emit(state.copyWith(filteredDiamonds: newList));
  }

  /// This is your search logic. You can adapt it as needed.
  List<DiamondModel> _applyFilter(Filter filter) {
    return allDiamonds.where((diamond) {
      // Carat from
      if (filter.fromCarat != null && diamond.carat < filter.fromCarat!) {
        return false;
      }
      // Carat to
      if (filter.toCarat != null && diamond.carat > filter.toCarat!) {
        return false;
      }
      // Lab
      if (filter.lab.isNotEmpty && diamond.lab != filter.lab) {
        return false;
      }
      // Shape
      if (filter.shape.isNotEmpty && diamond.shape != filter.shape) {
        return false;
      }
      // Color
      if (filter.color.isNotEmpty && diamond.color != filter.color) {
        return false;
      }
      // Clarity
      if (filter.clarity.isNotEmpty && diamond.clarity != filter.clarity) {
        return false;
      }
      return true;
    }).toList();
  }
}
