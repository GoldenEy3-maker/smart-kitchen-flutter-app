import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";

class FridgeProductItem extends Equatable {
  const FridgeProductItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.expirationDate,
  });

  FridgeProductItem.loading()
    : this(
        id: "Loading",
        product: Product.loading(),
        quantity: 1,
        expirationDate: DateTime.now(),
      );

  final String id;
  final Product product;
  final int quantity;
  final DateTime expirationDate;

  @override
  List<Object> get props => [id, product, quantity, expirationDate];
}
