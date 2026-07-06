import "package:json_annotation/json_annotation.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/entities/entities.dart";

part "category_model.g.dart";

@JsonSerializable()
class CategoryModel {
  final String id;
  final String label;
  final String emoji;

  CategoryModel({required this.id, required this.label, required this.emoji});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  Category toEntity() => Category(id: id, label: label, emoji: emoji);
}
