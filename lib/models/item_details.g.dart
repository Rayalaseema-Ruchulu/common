// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
  categories: (json['categories'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'ingredients': instance.ingredients,
    };
