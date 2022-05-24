import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:rosemarin_recipe_app/screens/recipe_details_screen.dart';

class SimpleRecipeCard extends StatefulWidget {
  final RecipeModel recipe;
  const SimpleRecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  State<SimpleRecipeCard> createState() => _SimpleRecipeCardState();
}

class _SimpleRecipeCardState extends State<SimpleRecipeCard> {
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
          width: 120,
          height: 200,
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

    return Center(
      child: Container(
        padding: const EdgeInsets.all(
          10.0,
        ),
        width: 200,
        height: 100,
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
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Only ${widget.recipe.ingredients.length} ingredients!',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 8,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w300),
          ),
        ]),
      ),
    );
  }
}
