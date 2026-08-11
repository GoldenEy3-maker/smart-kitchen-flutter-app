// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fridge_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FridgeProductModel _$FridgeProductModelFromJson(Map<String, dynamic> json) =>
    FridgeProductModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$FridgeProductModelToJson(FridgeProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'expirationDate': instance.expirationDate.toIso8601String(),
    };
