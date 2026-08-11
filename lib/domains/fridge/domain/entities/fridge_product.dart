import "package:equatable/equatable.dart";

class FridgeProduct extends Equatable {
  const FridgeProduct({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.expirationDate,
  });

  final String id;
  final String productId;
  final int quantity;
  final DateTime expirationDate;

  @override
  List<Object> get props => [id, productId, quantity, expirationDate];
}
