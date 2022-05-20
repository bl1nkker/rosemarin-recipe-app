import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/api/providers/recipe_endpoint.dart';
import 'package:rosemarin_recipe_app/models/ingredient_model.dart';
import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';

class RecipesManager extends ChangeNotifier {
  final RecipeProvider recipeProvider;

  RecipesManager(this.recipeProvider);

  bool _isError = false;
  bool _isLoading = false;

  List<RecipeModel> _recipes = [];
  List<RecipeModel> _randomRecipes = [];
  List<RecipeModel> _healthyRecipes = [];
  List<RecipeModel> _foundRecipes = [];
  List<ProductModel> _products = [];
  List<IngredientModel> _ingredients = [];
  List<ProductModel> _selectedProducts = [];
  List<ProductModel> _currentProducts = [];

  bool get isError => _isError;
  bool get isLoading => _isLoading;
  List<ProductModel> get selectedProducts => _selectedProducts;
  List<RecipeModel> get recipes => _recipes;
  List<RecipeModel> get randomRecipes => _randomRecipes;
  List<RecipeModel> get healthyRecipes => _healthyRecipes;
  List<RecipeModel> get foundRecipes => _foundRecipes;
  List<ProductModel> get products => _products;
  List<ProductModel> get currentProducts => _currentProducts;
  List<IngredientModel> get ingredients => _ingredients;

  void initialize() async {
    // TODO: Fetch recipes here
    _isLoading = true;
    try {
      _products = await recipeProvider.fetchAllProducts();
      _recipes = await recipeProvider.fetchAllRecipes();
      _randomRecipes = await recipeProvider.fetchRandomRecipes();
      _healthyRecipes = await recipeProvider.fetchRandomRecipes();
      _ingredients = await recipeProvider.fetchAllIngredients();
      _products = _products.where(
        (product) {
          for (var recipe in _recipes) {
            for (var ingredient in recipe.ingredients) {
              if (ingredient.name.contains(product.title)) {
                return true;
              }
            }
          }
          return false;
        },
      ).toList();
      _isError = false;
      _isLoading = false;
      _currentProducts = _products.take(10).toList();
      print('Retrieved: ${_recipes.length} recipes');
      print('Retrieved: ${_products.length} products');
      print('Retrieved: ${_ingredients.length} ingredients');
    } catch (e) {
      print('Error: $e');
      _isError = true;
      _isLoading = false;
    }
    notifyListeners();
  }

  Future findRecipesByProduct(List<ProductModel> products) async {
    _selectedProducts = products;
    _currentProducts = _products
        .where((element) => !_selectedProducts.contains(element))
        .toList();
    if (_selectedProducts.isNotEmpty) {
      for (var product in _selectedProducts) {
        for (var recipe in _recipes) {
          for (var ingredient in recipe.ingredients) {
            if (ingredient.name.contains(product.title)) {
              if (!_foundRecipes.contains(recipe)) {
                _foundRecipes.add(recipe);
              }
            }
          }
        }
      }
    } else {
      _foundRecipes = [];
    }
    notifyListeners();
  }

  Future findProductsBySubstring(String substring) async {
    _currentProducts = _products
        .where((product) =>
            product.title.toLowerCase().contains(substring.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
