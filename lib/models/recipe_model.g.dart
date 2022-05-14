// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      ingredients_ids:
          (json['ingredients'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'ingredients': instance.ingredients_ids,
    };
