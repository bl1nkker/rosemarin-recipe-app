import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/components/found_recipe_card.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:rosemarin_recipe_app/state/recipes_manager.dart';

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({Key? key}) : super(key: key);

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  Widget buildFoundRecipesList(List<RecipeModel> recipes) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: recipes.isEmpty
          ? const Text(
              'Add some recipes...',
              style: TextStyle(
                  fontSize: 24,
                  color: ColorStyles.secondaryColor,
                  fontWeight: FontWeight.w600),
            )
          : Column(
              children: recipes
                  .map((recipe) => FoundRecipeCard(recipe: recipe))
                  .toList(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesManager>(builder: (context, recipesManager, child) {
      return ListView(children: [
        const Text(
          'Favourite Recipes',
          style: TextStyle(
              fontSize: 48,
              color: ColorStyles.secondaryColor,
              fontWeight: FontWeight.bold),
        ),
        buildFoundRecipesList(recipesManager.favoriteRecipes)
      ]);
    });
  }
}
