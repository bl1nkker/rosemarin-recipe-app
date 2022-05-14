import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ingredient_model.g.dart';

@JsonSerializable()
class IngredientModel {
  // name = models.CharField(max_length=255)
  // quantity = models.IntegerField()
  // unit = models.CharField(max_length=255)
  // image = models.CharField(max_length=255)
  final int id;
  final String name;
  final int quantity;
  final String unit;
  final String image;

  IngredientModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.image,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);
}
