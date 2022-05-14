import 'package:json_annotation/json_annotation.dart';
part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  // title = models.CharField(max_length=255)
  // image = models.CharField(max_length=255)
  // ingredients = models.ManyToManyField(Ingredient)
  final int id;
  final String title;
  final String image;
  @JsonKey(name: 'ingredients')
  final List<int> ingredients_ids;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.ingredients_ids,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}
