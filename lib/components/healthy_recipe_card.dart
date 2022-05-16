import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:rosemarin_recipe_app/screens/recipe_details_screen.dart';

class HealthyRecipeCard extends StatefulWidget {
  final RecipeModel recipe;
  const HealthyRecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  State<HealthyRecipeCard> createState() => _HealthyRecipeCardState();
}

class _HealthyRecipeCardState extends State<HealthyRecipeCard> {
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
              builder: (context) => RecipeDetailsScreen(recipe: widget.recipe),
            ),
          );
        },
        child: Container(
          width: 200,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image(image: NetworkImage(widget.recipe.image)),
              ),
              buildCardInfo(widget.recipe),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardInfo(RecipeModel recipe) {
    Widget buildRecipeInfo(String text, IconData icon) {
      return Row(
        children: [
          Icon(
            icon,
            color: ColorStyles.accentColor,
            size: 12,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          )
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(
        10.0,
      ),
      width: 200,
      decoration: const BoxDecoration(
        color: ColorStyles.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.recipe.title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        // buildRecipeInfo(
        //     '${recipe.getCalories().toString()} calories', Icons.foggy),
        // SizedBox(height: 5),
        // buildRecipeInfo('25 min', Icons.timer),
      ]),
    );
  }
}
