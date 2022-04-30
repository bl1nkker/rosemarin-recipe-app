import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/navigation/rosemarin_pages.dart';
import 'package:rosemarin_recipe_app/navigation/router.dart';
import 'package:rosemarin_recipe_app/screens/ml_screen.dart';
import 'package:rosemarin_recipe_app/screens/recipe_screen.dart';
import 'package:rosemarin_recipe_app/screens/saved_recipes_screen.dart';
import 'package:rosemarin_recipe_app/state/app_state_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const Rosemarin(),
    );
  }
}

class Rosemarin extends StatefulWidget {
  const Rosemarin({Key? key}) : super(key: key);

  @override
  _RosemarinState createState() => _RosemarinState();
}

class _RosemarinState extends State<Rosemarin> {
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;

  @override
  void initState() {
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
        ],
        child: MaterialApp(
          home: Router(
            backButtonDispatcher: RootBackButtonDispatcher(),
            // routerDelegate helps construct the stack of pages that represents
            //your app state.
            routerDelegate: _appRouter,
          ),
        ));
  }
}
