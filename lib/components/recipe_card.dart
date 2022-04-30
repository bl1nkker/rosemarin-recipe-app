import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:rosemarin_recipe_app/screens/recipe_details_screen.dart';

class RecipeCard extends StatefulWidget {
  final RecipeModel recipe;
  RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
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
          margin: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image(
                    image: NetworkImage(
                        'https://cdn.vox-cdn.com/thumbor/0QFv_gVJALYFrWPVytYTb1jPCr8=/0x0:3000x2000/1200x675/filters:focal(1260x760:1740x1240)/cdn.vox-cdn.com/uploads/chorus_image/image/70516799/jbareham_220214_ecl1085_anime_2022.0.jpg')),
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
            color: Colors.green,
            size: 12,
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(fontSize: 10, color: Colors.grey),
          )
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(
        10.0,
      ),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.recipe.name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        buildRecipeInfo(
            '${recipe.getCalories().toString()} calories', Icons.foggy),
        SizedBox(height: 5),
        buildRecipeInfo('25 min', Icons.timer),
      ]),
    );
  }
}
