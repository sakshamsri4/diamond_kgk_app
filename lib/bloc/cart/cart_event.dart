import 'package:diamond_kgk_app/data/models/diamond_model.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final DiamondModel diamond;
  AddToCartEvent(this.diamond);
}

class RemoveFromCartEvent extends CartEvent {
  final String lotId;
  RemoveFromCartEvent(this.lotId);
}
