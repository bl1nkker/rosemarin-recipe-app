import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int id;
  final String title;
  final int proteins;
  final int fats;
  final int carbohydrates;
  final int calories;

  ProductModel({
    required this.id,
    required this.title,
    required this.proteins,
    required this.fats,
    required this.carbohydrates,
    required this.calories,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
