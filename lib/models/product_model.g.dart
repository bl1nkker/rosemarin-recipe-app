// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      proteins: json['proteins'] as int,
      carbs: json['carbs'] as int,
      calories: json['calories'] as int,
      fats: json['fats'] as int,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'proteins': instance.proteins,
      'carbs': instance.carbs,
      'calories': instance.calories,
      'fats': instance.fats,
    };
