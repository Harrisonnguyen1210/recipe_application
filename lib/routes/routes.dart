import 'package:go_router/go_router.dart';
import 'package:recipe_application/screens/category_screen/category_screen.dart';
import 'package:recipe_application/screens/home_screen.dart';
import 'package:recipe_application/screens/main_screen.dart';
import 'package:recipe_application/screens/recipe_list_screen.dart';
import 'package:recipe_application/screens/recipe_screen.dart';

final router = GoRouter(
  routes: [
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
