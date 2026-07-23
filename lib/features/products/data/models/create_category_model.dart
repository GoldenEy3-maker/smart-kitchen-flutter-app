import "package:json_annotation/json_annotation.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";

part "create_category_model.g.dart";

@JsonSerializable()
class CreateCategoryModel {
  final String label;
  final String iconKey;

  const CreateCategoryModel({required this.label, required this.iconKey});

  factory CreateCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CreateCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCategoryModelToJson(this);

  CreateCategory toEntity() => CreateCategory(label: label, iconKey: iconKey);
}
