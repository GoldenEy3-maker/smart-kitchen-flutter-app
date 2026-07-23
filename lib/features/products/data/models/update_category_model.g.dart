// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCategoryModel _$UpdateCategoryModelFromJson(Map<String, dynamic> json) =>
    UpdateCategoryModel(
      id: json['id'] as String,
      label: json['label'] as String?,
      iconKey: json['iconKey'] as String?,
    );

Map<String, dynamic> _$UpdateCategoryModelToJson(
  UpdateCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'iconKey': instance.iconKey,
};
