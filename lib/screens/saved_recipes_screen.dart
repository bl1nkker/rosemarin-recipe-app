import 'package:flutter/material.dart';

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({Key? key}) : super(key: key);

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'This part of the app is still in development. Follow the news about our application!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
      ),
    ));
  }
}
