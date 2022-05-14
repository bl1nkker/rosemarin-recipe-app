import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  // title = models.CharField(max_length=255)
  // proteins = models.IntegerField()
  // carbs = models.IntegerField()
  // calories = models.IntegerField()
  // fats = models.IntegerField()
  final int id;
  final String title;
  final int proteins;
  final int carbs;
  final int calories;
  final int fats;

  ProductModel({
    required this.id,
    required this.title,
    required this.proteins,
    required this.carbs,
    required this.calories,
    required this.fats,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
