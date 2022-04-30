import 'package:json_annotation/json_annotation.dart';
import 'package:rosemarin_recipe_app/models/ingredient_model.dart';
part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  final int id;
  final String name;
  final List<IngredientModel> ingredients;
  late int calories;
  late int proteins;
  late int fats;
  late int carbohydrates;
  final String images;

  RecipeModel({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.images,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);

  int getCalories() {
    calories = 0;
    for (var ingredient in ingredients) {
      calories += ingredient.product.calories * ingredient.quantity;
    }
    return calories;
  }

  int getProteins() {
    proteins = 0;
    for (var ingredient in ingredients) {
      proteins += ingredient.product.proteins * ingredient.quantity;
    }
    return proteins;
  }

  int getFats() {
    fats = 0;
    for (var ingredient in ingredients) {
      fats += ingredient.product.fats * ingredient.quantity;
    }
    return fats;
  }

  int getCarbohydrates() {
    carbohydrates = 0;
    for (var ingredient in ingredients) {
      carbohydrates += ingredient.product.carbohydrates * ingredient.quantity;
    }
    return carbohydrates;
  }
}
