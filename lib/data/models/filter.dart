// filter.dart
class Filter {
  final double? fromCarat;
  final double? toCarat;
  final String lab;
  final String shape;
  final String color;
  final String clarity;

  const Filter({
    this.fromCarat,
    this.toCarat,
    this.lab = '',
    this.shape = '',
    this.color = '',
    this.clarity = '',
  });

  Filter copyWith({
    double? fromCarat,
    double? toCarat,
    String? lab,
    String? shape,
    String? color,
    String? clarity,
  }) {
    return Filter(
      fromCarat: fromCarat ?? this.fromCarat,
      toCarat: toCarat ?? this.toCarat,
      lab: lab ?? this.lab,
      shape: shape ?? this.shape,
      color: color ?? this.color,
      clarity: clarity ?? this.clarity,
    );
  }
}
