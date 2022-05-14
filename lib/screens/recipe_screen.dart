import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/components/healthy_recipe_card.dart';
import 'package:rosemarin_recipe_app/components/recipe_card.dart';
import 'package:rosemarin_recipe_app/components/simple_recipe_card.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:rosemarin_recipe_app/state/recipes_manager.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<RecipesManager>(context, listen: false).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          'Recipes',
          style: TextStyle(
              fontSize: 48, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Consumer<RecipesManager>(builder: (context, recipesManager, child) {
          return buildRecipesList(recipesManager.recipes);
        }),
        const Text(
          'Simple Recipes',
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        Consumer<RecipesManager>(builder: (context, recipesManager, child) {
          return buildSimpleRecipesList(recipesManager.recipes);
        }),
        const Text(
          '#Healthy_food',
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        Consumer<RecipesManager>(builder: (context, recipesManager, child) {
          return buildHealthyRecipesList(recipesManager.recipes);
        }),
      ],
    );
  }

  Widget buildRecipesList(List<RecipeModel> recipes) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: recipes.map((recipe) => RecipeCard(recipe: recipe)).toList(),
      ),
    );
  }

  Widget buildSimpleRecipesList(List<RecipeModel> recipes) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: Row(
        children:
            recipes.map((recipe) => SimpleRecipeCard(recipe: recipe)).toList(),
      ),
    );
  }

  Widget buildHealthyRecipesList(List<RecipeModel> recipes) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: Row(
        children:
            recipes.map((recipe) => HealthyRecipeCard(recipe: recipe)).toList(),
      ),
    );
  }
}
