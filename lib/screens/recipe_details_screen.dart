import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/models/ingredient_model.dart';
import 'package:rosemarin_recipe_app/models/product_model.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:rosemarin_recipe_app/state/recipes_manager.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:collection/collection.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final RecipeModel recipe;
  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final PanelController panelController = PanelController();
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Hero(
        transitionOnUserGestures: true,
        tag: widget.recipe.id,
        child: SafeArea(
          child: SlidingUpPanel(
            controller: panelController,
            // backdropColor: Colors.red.withAlpha(1),
            color: Colors.transparent,
            minHeight: 200,
            // maxHeight: 300,
            parallaxEnabled: true,
            parallaxOffset: .1,

            panelBuilder: (controller) => DetailsPanelWidget(
                recipe: widget.recipe,
                controller: controller,
                panelController: panelController),
            body: Container(
                height: 250,
                decoration: BoxDecoration(
                  // TODO: Set default image color
                  color: ColorStyles.accentColor,
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: NetworkImage(
                        widget.recipe.image,
                      ),

                      // alignment: Alignment(-.7, 0),
                      fit: BoxFit.fitHeight),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorStyles.accentColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 50,
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back_ios_sharp,
                                  // TODO: Work with colors
                                  color: ColorStyles.secondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class DetailsPanelWidget extends StatefulWidget {
  final RecipeModel recipe;
  final ScrollController controller;
  final PanelController panelController;
  const DetailsPanelWidget(
      {Key? key,
      required this.recipe,
      required this.controller,
      required this.panelController})
      : super(key: key);

  @override
  State<DetailsPanelWidget> createState() => _DetailsPanelWidgetState();
}

class _DetailsPanelWidgetState extends State<DetailsPanelWidget> {
  int totalFats = 0;
  int totalCarbs = 0;
  int totalProteins = 0;
  int totalCalories = 0;
  void togglePanel() {
    if (widget.panelController.isPanelOpen) {
      widget.panelController.close();
    } else {
      widget.panelController.open();
    }
  }

  List<Widget> createTagChips(BuildContext context, List<int> ingredientIds) {
    final List<IngredientModel> ingrediens = ingredientIds
        .map((id) => Provider.of<RecipesManager>(context, listen: false)
            .ingredients
            .firstWhere((ingredient) => ingredient.id == id))
        .toList();
    final List<ProductModel?> usedProducts = ingrediens
        .map((ingredient) => Provider.of<RecipesManager>(context, listen: false)
            .products
            .firstWhereOrNull(
                (product) => ingredient.name.contains(product.title)))
        .toList();
    setState(() {
      totalFats =
          usedProducts.fold(0, (sum, product) => sum + (product?.fats ?? 0));
      totalCarbs =
          usedProducts.fold(0, (sum, product) => sum + (product?.carbs ?? 0));
      totalProteins = usedProducts.fold(
          0, (sum, product) => sum + (product?.proteins ?? 0));
      totalCalories = usedProducts.fold(
          0, (sum, product) => sum + (product?.calories ?? 0));
    });

    final chips = <Widget>[];
    for (var element in ingrediens) {
      final chip = Row(children: [
        Chip(
            label: Text(
              element.name[0].toUpperCase() + element.name.substring(1),
              style: const TextStyle(
                  color: ColorStyles.secondaryColor,
                  fontWeight: FontWeight.w300),
            ),
            backgroundColor: ColorStyles.accentColor),
        const SizedBox(width: 5),
        Text(
          " x ${element.quantity.toString()} ${element.unit}",
          style: const TextStyle(
              color: ColorStyles.secondaryColor, fontWeight: FontWeight.w300),
        ),
      ]);
      chips.add(chip);
    }

    return chips;
  }

  Widget buildIngredientInfoRow(
      {required IconData icon, required String title, required String data}) {
    return Row(
      children: [
        Row(
          children: [
            Icon(icon, color: ColorStyles.accentColor),
            Text(title,
                style: const TextStyle(
                    color: ColorStyles.secondaryColor,
                    fontWeight: FontWeight.w300)),
          ],
        ),
        const SizedBox(width: 10),
        Text(data,
            style: const TextStyle(
                color: ColorStyles.secondaryColor,
                fontWeight: FontWeight.w300)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return ClipRRect(
      // borderRadius: BorderRadius.circular(30),
      child: Container(
          height: MediaQuery.of(context).size.height * .3,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                const Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                // ColorStyles.secondaryColor.withOpacity(.3),
                const Color.fromARGB(255, 255, 255, 255).withOpacity(.6),
              ])),
          child: Column(
            children: [
              GestureDetector(
                onTap: togglePanel,
                child: Container(
                  width: 50,
                  height: 8,
                  decoration: BoxDecoration(
                      color: ColorStyles.primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 10.0),
              const SizedBox(height: 10.0),
              Expanded(
                child: ListView(
                  controller: widget.controller,
                  children: [
                    Text(widget.recipe.title,
                        style: const TextStyle(
                            color: ColorStyles.secondaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Ingredients: ',
                        style: TextStyle(
                            color: ColorStyles.secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...createTagChips(
                            context, widget.recipe.ingredients_ids),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Nutrients: ',
                        style: TextStyle(
                            color: ColorStyles.secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: [
                        buildIngredientInfoRow(
                            icon: Icons.foggy,
                            title: 'Total fats:',
                            data: totalFats.toString()),
                        buildIngredientInfoRow(
                            icon: Icons.fastfood,
                            title: 'Total carbs:',
                            data: totalCarbs.toString()),
                        buildIngredientInfoRow(
                            icon: Icons.fastfood,
                            title: 'Total proteins:',
                            data: totalProteins.toString()),
                        buildIngredientInfoRow(
                            icon: Icons.fastfood,
                            title: 'Total calories:',
                            data: totalCalories.toString()),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
