import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/models/recipe_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
                controller: controller, panelController: panelController),
            body: Container(
                // TODO: Change content padding value to constant

                height: 250,
                decoration: BoxDecoration(
                  // TODO: Set default image color
                  color: Colors.greenAccent,
                  image: DecorationImage(
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
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back_ios_sharp,
                                  // TODO: Work with colors
                                  color: Colors.white),
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

class DetailsPanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  const DetailsPanelWidget(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  void togglePanel() {
    if (panelController.isPanelOpen) {
      panelController.close();
    } else {
      panelController.open();
    }
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
                // Colors.black.withOpacity(.3),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 10.0),
              const SizedBox(height: 10.0),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        style: themeData.textTheme.bodyText2),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        style: themeData.textTheme.bodyText2),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text('Здесь будут ссылки. Пока не знаю в каком формате',
                        style: themeData.textTheme.bodyText2)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
