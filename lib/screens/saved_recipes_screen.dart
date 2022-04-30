import 'package:flutter/material.dart';

class SavedRecipesScreen extends StatefulWidget {
  SavedRecipesScreen({Key? key}) : super(key: key);

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Saved Recipes!'),
    );
  }
}
