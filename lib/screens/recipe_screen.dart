import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Recipe Screen'));
  }
}
