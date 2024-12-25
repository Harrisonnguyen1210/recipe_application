import 'package:go_router/go_router.dart';
import 'package:recipe_application/screens/add_recipe_screen.dart';
import 'package:recipe_application/screens/category_screen/category_screen.dart';
import 'package:recipe_application/screens/favorite_screen.dart';
import 'package:recipe_application/screens/home_screen.dart';
import 'package:recipe_application/screens/main_screen.dart';
import 'package:recipe_application/screens/recipe_list_screen.dart';
import 'package:recipe_application/screens/recipe_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/addRecipe',
      builder: (context, state) => AddRecipeScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(tabView: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const MainScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/recipes',
              builder: (context, state) => const RecipeScreen(),
              routes: [
                GoRoute(
                  path: 'favorites',
                  builder: (context, state) => FavoriteScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/category',
              builder: (context, state) => const CategoryScreen(),
              routes: [
                GoRoute(
                  path: 'recipes/:id',
                  builder: (context, state) => RecipeListScreen(
                    categoryId: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
