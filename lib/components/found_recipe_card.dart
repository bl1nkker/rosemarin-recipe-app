import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/models/ingredient_model.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:rosemarin_recipe_app/screens/recipe_details_screen.dart';

class FoundRecipeCard extends StatefulWidget {
  final RecipeModel recipe;
  const FoundRecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  State<FoundRecipeCard> createState() => _FoundRecipeCardState();
}

class _FoundRecipeCardState extends State<FoundRecipeCard> {
  List<Widget> createTagChips(List<IngredientModel> ingredients) {
    // final List<IngredientModel> ingrediens = ingredientIds
    //     .map((id) => Provider.of<RecipesManager>(context, listen: false)
    //         .ingredients
    //         .firstWhere((ingredient) => ingredient.id == id))
    //     .toList();
    final chips = <Widget>[];
    for (var element in ingredients) {
      final chip = Chip(
          label: Text(
            element.name[0].toUpperCase() + element.name.substring(1),
            style: const TextStyle(
                color: ColorStyles.secondaryColor, fontWeight: FontWeight.w300),
          ),
          backgroundColor: ColorStyles.accentColor);
      chips.add(chip);
    }

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        transitionOnUserGestures: true,
        tag: '${widget.recipe.id}',
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RecipeDetailsScreen(recipe: widget.recipe),
                ),
              );
            },
            child: Center(
              child: Container(
                constraints: const BoxConstraints.expand(
                  width: 350,
                  height: 450,
                ),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.recipe.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorStyles.secondaryColor.withOpacity(0.8),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // TODO: Save to favorites
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: ColorStyles.accentColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.recipe.title,
                            style: const TextStyle(
                                color: ColorStyles.primaryColor, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 12,
                          children: createTagChips(widget.recipe.ingredients),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
