import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kUser = 'user';
  static const kOnboarding = 'onboarding';
  static const kFavoriteRecipes = 'favoriteRecipes';

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kUser, false);
    await prefs.setBool(kOnboarding, false);
  }

  Future<void> cacheUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kUser, true);
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnboarding, true);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kUser) ?? false;
  }

  Future<bool> didCompleteOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kOnboarding) ?? false;
  }

  Future<List<String>> getFavoriteRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(kFavoriteRecipes) ?? [];
  }

  Future<void> cacheRecipe(RecipeModel recipe) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteRecipes =
        prefs.getStringList(kFavoriteRecipes) ?? [];
    if (!favoriteRecipes.contains(recipe.id.toString())) {
      favoriteRecipes.add(recipe.id.toString());
      await prefs.setStringList(kFavoriteRecipes, favoriteRecipes);
    }
  }

  Future<void> uncacheRecipe(RecipeModel recipe) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteRecipes =
        prefs.getStringList(kFavoriteRecipes) ?? [];
    if (favoriteRecipes.contains(recipe.id.toString())) {
      favoriteRecipes.remove(recipe.id.toString());
      await prefs.setStringList(kFavoriteRecipes, favoriteRecipes);
    }
  }
}
