import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/api/api_client.dart';
import 'package:rosemarin_recipe_app/api/providers/recipe_endpoint.dart';
import 'package:rosemarin_recipe_app/navigation/router.dart';
import 'package:rosemarin_recipe_app/state/app_state_manager.dart';
import 'package:rosemarin_recipe_app/state/recipes_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Client client = Client();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Rosemarin(
        client: client,
      ),
    );
  }
}

class Rosemarin extends StatefulWidget {
  final Client client;
  const Rosemarin({Key? key, required this.client}) : super(key: key);

  @override
  _RosemarinState createState() => _RosemarinState();
}

class _RosemarinState extends State<Rosemarin> {
  late RecipeProvider recipeProvider;
  late AppStateManager _appStateManager;
  late RecipesManager _recipeManager;
  late AppRouter _appRouter;

  @override
  void initState() {
    recipeProvider = RecipeProvider(widget.client.init());
    _appStateManager = AppStateManager();
    _recipeManager = RecipesManager(recipeProvider);
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _appStateManager,
          ),
          ChangeNotifierProvider(
            create: (context) => _recipeManager,
          ),
        ],
        child: MaterialApp(
          home: Router(
            // routerDelegate helps construct the stack of pages that represents
            //your app state.
            routerDelegate: _appRouter,
          ),
        ));
  }
}
