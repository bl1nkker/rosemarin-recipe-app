import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/navigation/rosemarin_pages.dart';
import 'package:rosemarin_recipe_app/screens/ml_screen.dart';
import 'package:rosemarin_recipe_app/screens/recipe_screen.dart';
import 'package:rosemarin_recipe_app/screens/saved_recipes_screen.dart';
import 'package:rosemarin_recipe_app/state/app_state_manager.dart';
import 'package:rosemarin_recipe_app/state/recipes_manager.dart';

class Home extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: RosemarinPages.homePath,
      key: ValueKey(RosemarinPages.homePath),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    const SavedRecipesScreen(),
    const RecipeScreen(),
    const MLScreen()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RecipesManager>(context, listen: false).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (
        context,
        appStateManager,
        child,
      ) {
        return Scaffold(
          appBar: AppBar(
            // title: const Text('Rosemarin'),
            backgroundColor: ColorStyles.secondaryColor,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage(
                  'assets/icon/icon.png',
                ),
              ),
            ),

            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.question_mark_sharp,
                  color: ColorStyles.accentColor,
                ),
                onPressed: () {
                  appStateManager.repeatOnboarding();
                },
              ),
            ],
          ),
          body: Consumer<RecipesManager>(
              builder: (context, RecipesManager recipesManager, child) =>
                  recipesManager.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: ColorStyles.accentColor,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: SafeArea(
                            child: IndexedStack(
                              index: widget.currentTab,
                              children: pages,
                            ),
                          ),
                        )),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: ColorStyles.accentColor,
            currentIndex: widget.currentTab,
            onTap: (index) {
              Provider.of<AppStateManager>(context, listen: false)
                  .goToTab(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  size: 32,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 32,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.computer,
                  size: 32,
                ),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
