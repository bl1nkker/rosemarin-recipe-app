import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:rosemarin_recipe_app/state/recipes_manager.dart';
import 'package:collection/collection.dart';

class MLScreen extends StatefulWidget {
  const MLScreen({Key? key}) : super(key: key);

  @override
  State<MLScreen> createState() => _MLScreenState();
}

class _MLScreenState extends State<MLScreen> {
  // Amount of nutrients for 1700 ccal
  final int averageFatsPerDayVegetarian = 60;
  final int averageProteinsPerDayVegetarian = 77;
  final int averageCarbsPerDayVegetarian = 221;

  final int averageFatsPerDayMediterranian = 64;
  final int averageProteinsPerDayMediterranian = 60;
  final int averageCarbsPerDayMediterranian = 234;

  final int averageFatsPerDayFourtyThirty = 57;
  final int averageProteinsPerDayFourtyThirty = 128;
  final int averageCarbsPerDayFourtyThirty = 170;

  int currentFats = 0;
  int currentProteins = 0;
  int currentCarbs = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget buildNutrientIndicator(
      {required int average, required int current, required String label}) {
    return Column(
      children: <Widget>[
        Stack(children: [
          SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: current / average > .85
                  ? ColorStyles.accentColor
                  : current / average > .5
                      ? ColorStyles.warningColor
                      : ColorStyles.errorColor,
              value: current / average,
            ),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: Text(
              '${(current / average * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                  fontSize: 20,
                  color: current / average > .85
                      ? ColorStyles.accentColor
                      : current / average > .5
                          ? ColorStyles.warningColor
                          : ColorStyles.errorColor,
                  fontWeight: FontWeight.bold),
            ),
          )),
        ]),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildDietContainer(
      {required String label,
      required int averageFatsPerDay,
      required int averageProteinsPerDay,
      required int averageCarbsPerDay,
      required String dietInfo}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 24,
              color: ColorStyles.secondaryColor,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorStyles.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorStyles.accentColor,
              width: 5,
            ),
          ),
          child: Text(
            dietInfo,
            style:
                const TextStyle(color: ColorStyles.primaryColor, fontSize: 12),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNutrientIndicator(
                average: averageFatsPerDay,
                current: currentFats,
                label: 'Fats'),
            buildNutrientIndicator(
                average: averageProteinsPerDay,
                current: currentProteins,
                label: 'Proteins'),
            buildNutrientIndicator(
                average: averageCarbsPerDay,
                current: currentCarbs,
                label: 'Carbs'),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesManager>(
        builder: ((BuildContext context, RecipesManager recipesManager, child) {
      List<ProductModel?> usedProducts = [];
      for (var recipe in recipesManager.cookedRecipes) {
        usedProducts.addAll(recipe.ingredients
            .map((ingredient) =>
                Provider.of<RecipesManager>(context, listen: false)
                    .products
                    .firstWhereOrNull(
                        (product) => ingredient.name.contains(product.title)))
            .toList());
      }
      currentFats =
          usedProducts.fold(0, (sum, product) => sum + (product?.fats ?? 0));
      currentCarbs =
          usedProducts.fold(0, (sum, product) => sum + (product?.carbs ?? 0));
      currentProteins = usedProducts.fold(
          0, (sum, product) => sum + (product?.proteins ?? 0));
      // totalCalories = usedProducts.fold(
      //     0, (sum, product) => sum + (product?.calories ?? 0));
      return SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Your Daily Nutrients',
              style: TextStyle(
                  fontSize: 36,
                  color: ColorStyles.secondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            buildDietContainer(
                label: 'Vegetarian Diet',
                averageCarbsPerDay: averageCarbsPerDayVegetarian,
                averageFatsPerDay: averageFatsPerDayVegetarian,
                averageProteinsPerDay: averageProteinsPerDayVegetarian,
                dietInfo:
                    'Servings of protein foods such as meat and seafood are not included in the vegetarian plan. Rather, someone following a 2000-calorie-per-day vegetarian diet should try to consume 3.5-ounce equivalents of protein foods, including legumes, soy products, eggs, nuts, and seeds'),
            buildDietContainer(
                label: 'Mediterranean-Style Diet',
                averageCarbsPerDay: averageCarbsPerDayMediterranian,
                averageFatsPerDay: averageFatsPerDayMediterranian,
                averageProteinsPerDay: averageProteinsPerDayMediterranian,
                dietInfo:
                    'Mediterranean-style diet contains more fruits and seafood and less dairy than the Healthy U.S.-style Pattern.'),
            buildDietContainer(
                label: '40-30-30 Diet',
                averageCarbsPerDay: averageCarbsPerDayFourtyThirty,
                averageFatsPerDay: averageFatsPerDayFourtyThirty,
                averageProteinsPerDay: averageProteinsPerDayFourtyThirty,
                dietInfo:
                    'A 40-30-30 diet may be helpful for those who want to gain muscle mass, but may not be appropriate for those with liver or kidney problems or when training for endurance exercise.'),
          ],
        ),
      );
    }));
  }
}
