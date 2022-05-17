import 'package:flutter/material.dart';
import 'package:rosemarin_recipe_app/navigation/rosemarin_pages.dart';
import 'package:rosemarin_recipe_app/screens/home_screen.dart';
import 'package:rosemarin_recipe_app/screens/splash_screen.dart';
import 'package:rosemarin_recipe_app/state/app_state_manager.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;

  AppRouter({
    required this.appStateManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else ...[
          Home.page(appStateManager.getSelectedTab)
        ]
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == RosemarinPages.onboardingPath) {
      appStateManager.logout();
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
