import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';

class RecipeProvider {
  final Dio _client;

  RecipeProvider(this._client);

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final response = await _client.get(
        '/products/',
      );
      return List<ProductModel>.from(
        response.data.map(
          (product) => ProductModel.fromJson(product),
        ),
      );
    } on DioError catch (ex) {
      // Assuming there will be an errorMessage property in the JSON object
      print('Error: $ex');
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<List<RecipeModel>> fetchAllRecipes() async {
    try {
      final response = await _client.get(
        '/recipes/',
      );
      return List<RecipeModel>.from(
        response.data.map(
          (recipe) => RecipeModel.fromJson(recipe),
        ),
      );
    } on DioError catch (ex) {
      // Assuming there will be an errorMessage property in the JSON object
      print('Error: $ex');
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }
}
