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
          height: 180,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            color: ColorStyles.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            image: DecorationImage(
              image: NetworkImage(widget.recipe.image),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
