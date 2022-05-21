import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosemarin_recipe_app/color_styles.dart';
import 'package:rosemarin_recipe_app/navigation/rosemarin_pages.dart';
import 'package:rosemarin_recipe_app/state/app_state_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: RosemarinPages.onboardingPath,
      key: ValueKey(RosemarinPages.onboardingPath),
      child: const OnboardingScreen(),
    );
  }

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: buildPages()),
            buildIndicator(),
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          child: const Text(
            'Пропустить',
            style: TextStyle(fontSize: 12, color: ColorStyles.primaryColor),
          ),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .completeOnboarding();
          },
        )
      ],
    );
  }

  Widget buildPages() {
    return PageView(
      controller: controller,
      children: [
        onboardPageView(const AssetImage('assets/icon/icon.png'),
            'Добро пожаловать в Rosemarin!'),
        onboardPageView(const AssetImage('assets/onboarding/onboarding_1.png'),
            'Приложение призвано упростить ваш стандартный процесс приготовления пищи, и сейчас мы покажем как!'),
        onboardPageView(const AssetImage('assets/onboarding/onboarding_2.png'),
            'На главном экране вы можете увидеть список всех рецептом, здоровых рецептов и простых рецептов. Выбирайте на свой вкус!'),
        onboardPageView(const AssetImage('assets/onboarding/onboarding_3.png'),
            'При переходе на страницу рецепта вы можете просмотреть информацию о его ингредиентах и общей пищевой ценности'),
        onboardPageView(const AssetImage('assets/onboarding/onboarding_4.png'),
            'А теперь к главному... выберите продукты которые есть в вашем холодильнике и сможете увидеть рецепты, которые вам подходят!'),
        onboardPageView(const AssetImage('assets/onboarding/onboarding_5.png'),
            'Можно выбрать несколько продуктов, тем самым расширив список рецептов!'),
        Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                child: Icon(Icons.favorite,
                    size: 100, color: ColorStyles.accentColor),
              ),
              SizedBox(height: 16),
              Text(
                'Рецепты также можно помечать как "Любимый". Они будут сохранены во вкладке "Любимые"',
                style: TextStyle(fontSize: 20, color: ColorStyles.primaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        onboardPageView(const AssetImage('assets/onboarding/onboarding_6.png'),
            'Следите за обновлениями нашего приложения на сайте!'),
      ],
    );
  }

  Widget onboardPageView(ImageProvider imageProvider, String text) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              fit: BoxFit.fitWidth,
              image: imageProvider,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style:
                const TextStyle(fontSize: 20, color: ColorStyles.primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 8,
      effect: const WormEffect(
          activeDotColor: ColorStyles.accentColor,
          dotColor: ColorStyles.primaryColor),
    );
  }
}
