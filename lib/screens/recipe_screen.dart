import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/components/found_recipe_card.dart';
import 'package:rosemarin_recipe_app/components/healthy_recipe_card.dart';
import 'package:rosemarin_recipe_app/components/recipe_card.dart';
import 'package:rosemarin_recipe_app/components/simple_recipe_card.dart';
import 'package:rosemarin_recipe_app/models/product_model.dart';
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
    return Consumer<RecipesManager>(builder: (context, recipesManager, child) {
      return ListView(
        children: recipesManager.selectedProducts.isNotEmpty
            ? [
                const RecipeSearchField(),
                const Text(
                  'Found Recipes',
                  style: TextStyle(
                      fontSize: 48,
                      color: ColorStyles.secondaryColor,
                      fontWeight: FontWeight.bold),
                ),
                buildFoundRecipesList(recipesManager.foundRecipes)
              ]
            : [
                const RecipeSearchField(),
                const Text(
                  'Recipes',
                  style: TextStyle(
                      fontSize: 48,
                      color: ColorStyles.secondaryColor,
                      fontWeight: FontWeight.bold),
                ),
                buildRecipesList(recipesManager.recipes),
                const Text(
                  'Simple Recipes',
                  style: TextStyle(
                      fontSize: 24,
                      color: ColorStyles.secondaryColor,
                      fontWeight: FontWeight.w600),
                ),
                buildSimpleRecipesList(recipesManager.recipes),
                const Text(
                  '#Healthy_food',
                  style: TextStyle(
                      fontSize: 24,
                      color: ColorStyles.secondaryColor,
                      fontWeight: FontWeight.w600),
                ),
                buildHealthyRecipesList(recipesManager.recipes)
              ],
      );
    });
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

  Widget buildFoundRecipesList(List<RecipeModel> recipes) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: Column(
        children:
            recipes.map((recipe) => FoundRecipeCard(recipe: recipe)).toList(),
      ),
    );
  }
}

class RecipeSearchField extends StatefulWidget {
  const RecipeSearchField({Key? key}) : super(key: key);

  @override
  State<RecipeSearchField> createState() => _RecipeSearchFieldState();
}

class _RecipeSearchFieldState extends State<RecipeSearchField> {
  final TextEditingController _controller = TextEditingController();
  List<ProductModel> selectedProducts = [];
  List<Widget> createTagChips(List<ProductModel> productsList) {
    final chips = <Widget>[];
    for (var element in productsList) {
      final chip = GestureDetector(
          onTap: () {
            if (selectedProducts.contains(element)) {
              setState(() {
                selectedProducts.remove(element);
              });
            } else {
              setState(() {
                selectedProducts.add(element);
              });
            }
            Provider.of<RecipesManager>(context, listen: false)
                .findRecipesByProduct(selectedProducts);
          },
          child: Chip(
            label: Text(
              element.title[0].toUpperCase() + element.title.substring(1),
              style: TextStyle(
                  color: selectedProducts.contains(element)
                      ? ColorStyles.secondaryColor
                      : ColorStyles.primaryColor,
                  fontWeight: FontWeight.w300),
            ),
            backgroundColor: selectedProducts.contains(element)
                ? ColorStyles.accentColor
                : ColorStyles.secondaryColor.withOpacity(0.7),
          ));
      chips.add(chip);
    }

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: (value) {
            Provider.of<RecipesManager>(context, listen: false)
                .findProductsBySubstring(value);
          },
          decoration: InputDecoration(
            hintText: 'Search for products',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          child: Consumer<RecipesManager>(
            builder: (context, recipesManager, child) => Wrap(
              alignment: WrapAlignment.start,
              spacing: 5,
              children: [
                ...createTagChips([
                  ...Provider.of<RecipesManager>(context, listen: false)
                      .selectedProducts,
                  ...Provider.of<RecipesManager>(context, listen: false)
                      .currentProducts,
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
