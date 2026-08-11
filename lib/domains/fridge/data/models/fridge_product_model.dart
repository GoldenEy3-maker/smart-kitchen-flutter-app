import "package:json_annotation/json_annotation.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/entities/entities.dart";

part "fridge_product_model.g.dart";

@JsonSerializable()
class FridgeProductModel {
  const FridgeProductModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.expirationDate,
  });

  final String id;
  final String productId;
  final int quantity;
  final DateTime expirationDate;

  factory FridgeProductModel.fromJson(Map<String, dynamic> json) =>
      _$FridgeProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$FridgeProductModelToJson(this);

  FridgeProduct toEntity() => FridgeProduct(
    id: id,
    productId: productId,
    quantity: quantity,
    expirationDate: expirationDate,
  );
}
