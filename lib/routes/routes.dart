import 'package:go_router/go_router.dart';
import 'package:recipe_application/screens/category_screen/category_screen.dart';
import 'package:recipe_application/screens/home_screen.dart';
import 'package:recipe_application/screens/main_screen.dart';
import 'package:recipe_application/screens/recipe_list_screen.dart';
import 'package:recipe_application/screens/recipe_screen.dart';
import 'package:recipe_application/screens/recipe_search_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/recipes',
      builder: (context, state) => RecipeSearchScreen(
        searchText: state.uri.queryParameters['filter'],
      ),
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
              // routes: [
              //   GoRoute(
              //     path: 'recipes',
              //     builder: (context, state) => RecipeSearchScreen(
              //       searchText: state.uri.queryParameters['filter'],
              //     ),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              redirect: (context, state) {
                if (state.pathParameters['id'] == null) {
                  return '/recipe/featuredRecipe';
                }
                return null;
              },
              path: '/recipe',
              routes: [
                GoRoute(
                  path: 'featuredRecipe',
                  builder: (context, state) => RecipeScreen(
                    recipeId: 'featuredRecipe',
                  ),
                ),
                GoRoute(
                  path: ':id',
                  builder: (context, state) => RecipeScreen(
                    recipeId: state.pathParameters['id']!,
                  ),
                )
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
