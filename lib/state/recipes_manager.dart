import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/api/providers/recipe_endpoint.dart';
import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';

class RecipesManager extends ChangeNotifier {
  final RecipeProvider recipeProvider;

  RecipesManager(this.recipeProvider);

  List<RecipeModel> _recipes = [];
  List<ProductModel> _products = [];

  List<RecipeModel> get recipes => _recipes;
  List<ProductModel> get products => _products;

  void initialize() async {
    // TODO: Fetch recipes here
    _products = await recipeProvider.fetchAllProducts();
    _recipes = await recipeProvider.fetchAllRecipes();
    print('Retrieved ${_products.length} products');
    print('Retrieved ${_recipes.length} recipes');
  }
}
