import 'package:hive/hive.dart';

part 'diamond_model.g.dart'; // This file will be auto-generated

@HiveType(typeId: 0) // Unique ID for Hive TypeAdapter
class DiamondModel {
  @HiveField(0)
  final String lotId;

  @HiveField(1)
  final double size;

  @HiveField(2)
  final double carat;

  @HiveField(3)
  final String lab;

  @HiveField(4)
  final String shape;

  @HiveField(5)
  final String color;

  @HiveField(6)
  final String clarity;

  @HiveField(7)
  final String cut;

  @HiveField(8)
  final String polish;

  @HiveField(9)
  final String symmetry;

  @HiveField(10)
  final String fluorescence;

  @HiveField(11)
  final double discount;

  @HiveField(12)
  final double perCaratRate;

  @HiveField(13)
  final double finalAmount;

  @HiveField(14)
  final String keyToSymbol;

  @HiveField(15)
  final String labComment;

  DiamondModel({
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.perCaratRate,
    required this.finalAmount,
    required this.keyToSymbol,
    required this.labComment,
  });
}
