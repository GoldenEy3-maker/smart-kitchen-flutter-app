import "package:json_annotation/json_annotation.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";

part "product_model.g.dart";

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  final String iconKey;
  final String unit;
  final String categoryId;

  const ProductModel({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.unit,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  Product toEntity() => Product(
    id: id,
    name: name,
    iconKey: iconKey,
    unit: unit,
    categoryId: categoryId,
  );
}
