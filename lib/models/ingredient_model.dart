import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ingredient_model.g.dart';

@JsonSerializable()
class IngredientModel {
  final int id;
  final ProductModel product;
  final int quantity;

  IngredientModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);
}
