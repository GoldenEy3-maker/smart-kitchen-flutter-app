// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String,
  name: json['name'] as String,
  iconKey: json['iconKey'] as String,
  unit: json['unit'] as String,
  categoryId: json['categoryId'] as String,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconKey': instance.iconKey,
      'unit': instance.unit,
      'categoryId': instance.categoryId,
    };
