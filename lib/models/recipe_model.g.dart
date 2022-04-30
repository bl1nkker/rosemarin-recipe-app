// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: json['images'] as String,
    )
      ..calories = json['calories'] as int
      ..proteins = json['proteins'] as int
      ..fats = json['fats'] as int
      ..carbohydrates = json['carbohydrates'] as int;

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ingredients': instance.ingredients,
      'calories': instance.calories,
      'proteins': instance.proteins,
      'fats': instance.fats,
      'carbohydrates': instance.carbohydrates,
      'images': instance.images,
    };
