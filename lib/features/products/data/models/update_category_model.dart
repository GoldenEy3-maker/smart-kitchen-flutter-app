import "package:json_annotation/json_annotation.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/update_category.dart";

part "update_category_model.g.dart";

@JsonSerializable()
class UpdateCategoryModel {
  final String id;
  final String? label;
  final String? iconKey;

  const UpdateCategoryModel({required this.id, this.label, this.iconKey});

  factory UpdateCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCategoryModelToJson(this);

  UpdateCategory toEntity() =>
      UpdateCategory(id: id, label: label, iconKey: iconKey);
}
