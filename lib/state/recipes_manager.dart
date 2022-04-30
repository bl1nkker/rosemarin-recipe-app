import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:rosemarin_recipe_app/utils/fake.dart';

class RecipesManager extends ChangeNotifier {
  List<RecipeModel> _recipes = [];
  List<ProductModel> _products = [];

  List<RecipeModel> get recipes => _recipes;
  List<ProductModel> get products => _products;

  void initialize() {
    // TODO: Fetch recipes here
    _products = Faker.generateProducts();
    _recipes = Faker.generateRecipes(_products);
  }
}
