// filter_event.dart

abstract class FilterEvent {}

class UpdateCaratFromEvent extends FilterEvent {
  final double? fromCarat;
  UpdateCaratFromEvent(this.fromCarat);
}

class UpdateCaratToEvent extends FilterEvent {
  final double? toCarat;
  UpdateCaratToEvent(this.toCarat);
}

class UpdateLabEvent extends FilterEvent {
  final String lab;
  UpdateLabEvent(this.lab);
}

class UpdateShapeEvent extends FilterEvent {
  final String shape;
  UpdateShapeEvent(this.shape);
}

class UpdateColorEvent extends FilterEvent {
  final String color;
  UpdateColorEvent(this.color);
}

class UpdateClarityEvent extends FilterEvent {
  final String clarity;
  UpdateClarityEvent(this.clarity);
}

/// The user taps "Search" button
class SearchDiamondsEvent extends FilterEvent {}
