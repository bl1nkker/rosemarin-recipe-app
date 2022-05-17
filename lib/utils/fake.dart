import 'package:rosemarin_recipe_app/models/ingredient_model.dart';
import 'dart:math';

import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';

class Faker {
  static List<String> productNames = [
    'Eggs',
    'Milk',
    'Flour',
    'Sugar',
    'Salt',
    'Tomato',
    'Apple',
    'Cucumber',
    'Banana',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
    'Celery',
    'Cucumber',
    'Cherry',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Celery',
    'Carrot',
    'Potato',
    'Cabbage',
  ];
  static List<String> recipeNames = [
    'Cooked Eggs',
    'Italian Pasta',
    'Marinated Tomatoes',
    'Creamy Spinach Salad',
    'Charlotte',
    'Tasty Meal',
    'Cooked Potato',
    'Spicy Cream',
    'Hot BBQ',
    'Dark Burger'
  ];
  static List<RecipeModel> generateRecipes(List<ProductModel> products) {
    const int ingredientsAmount = 10;
    int recipesAmount = recipeNames.length;
    final List<RecipeModel> recipes = [];
    final List<IngredientModel> ingrediens = [];
    for (int i = 0; i < ingredientsAmount; i++) {
      final ProductModel product = products[i];
      final newIngredient = IngredientModel(
          id: i,
          name: product.title,
          quantity: i * 100,
          image: '',
          unit: 'tsp');
      ingrediens.add(newIngredient);
    }

    for (var i = 0; i < recipesAmount; i++) {
      final int randomIngredintsAmount = Random().nextInt(5);
      final List<IngredientModel> randomIngredients = [];
      for (var j = 0; j < randomIngredintsAmount; j++) {
        final int randomIndex = Random().nextInt(ingrediens.length);
        final IngredientModel ingredient = ingrediens[randomIndex];
        randomIngredients.add(ingredient);
      }
      final newRecipe = RecipeModel(
          id: i,
          title: recipeNames[i],
          ingredients: randomIngredients,
          image: '');
      recipes.add(newRecipe);
    }

    return recipes;
  }

  static List<ProductModel> generateProducts() {
    final products = <ProductModel>[];
    for (var i = 0; i < productNames.length; i++) {
      products.add(ProductModel(
        id: i,
        calories: Random().nextInt(100),
        carbs: Random().nextInt(100),
        fats: Random().nextInt(100),
        proteins: Random().nextInt(100),
        title: productNames[i],
      ));
    }
    return products;
  }
}
