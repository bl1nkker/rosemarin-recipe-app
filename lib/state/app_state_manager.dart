import 'dart:async';

import 'package:flutter/material.dart';

import 'app_cache.dart';

class RosemarinTab {
  static const int savedRecipes = 0;
  static const int recipes = 1;
  static const int ml = 2;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  // bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = RosemarinTab.savedRecipes;
  final _appCache = AppCache();

  bool get isInitialized => _initialized;
  // bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  void initializeApp() async {
    // _loggedIn = await _appCache.isUserLoggedIn();
    _onboardingComplete = await _appCache.didCompleteOnboarding();
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );

    notifyListeners();
  }

  // void login(String username, String password) async {
  //   _loggedIn = true;
  //   await _appCache.cacheUser();
  //   notifyListeners();
  // }

  void completeOnboarding() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void repeatOnboarding() async {
    _onboardingComplete = false;
    // await _appCache.repeatOnboarding();
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = RosemarinTab.recipes;
    notifyListeners();
  }

  void logout() async {
    _initialized = false;
    _selectedTab = 0;
    await _appCache.invalidate();

    initializeApp();
    notifyListeners();
  }
}
