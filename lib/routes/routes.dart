import 'package:go_router/go_router.dart';
import 'package:recipe_application/models/dummy_data.dart';
import 'package:recipe_application/screens/home_screen.dart';
import 'package:recipe_application/screens/main_screen.dart';
import 'package:recipe_application/screens/recipe_category_screen.dart';
import 'package:recipe_application/screens/recipe_screen.dart';

final router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(tabView: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const MainScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/recipe',
              builder: (context, state) => RecipeScreen(recipe: featuredRecipe),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/category',
              builder: (context, state) => const RecipeCategoryScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
