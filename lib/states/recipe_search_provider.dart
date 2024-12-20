import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

final recipeSearchProvider =
    StateNotifierProvider<RecipeSearchNotifier, List<Recipe>>((ref) {
  final recipes = ref.watch(recipesProvider);

  return RecipeSearchNotifier(ref, recipes);
});

class RecipeSearchNotifier extends StateNotifier<List<Recipe>> {
  final Ref ref;
  List<Recipe> recipes;

  RecipeSearchNotifier(this.ref, this.recipes) : super([]) {
    loadSearchRecipes(null);
  }

  void loadSearchRecipes(String? searchText) async {
    if (recipes.isEmpty) return;
    if (searchText == null) {
      final random = Random().nextInt(recipes.length);
      state = [recipes[random]];
    } else {
      state = ref
          .read(recipesProvider)
          .where((recipe) => recipe.name.toLowerCase().contains(searchText))
          .toList();
    }
  }

  void loadRecipe(Recipe recipe) {
    state = [recipe];
  }
}
