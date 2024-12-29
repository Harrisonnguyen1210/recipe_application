import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

final recipeSearchProvider =
    StateNotifierProvider<RecipeSearchNotifier, AsyncValue<List<Recipe>>>(
        (ref) {
  final recipes = ref.watch(recipesProvider);

  return RecipeSearchNotifier(ref, recipes);
});

class RecipeSearchNotifier extends StateNotifier<AsyncValue<List<Recipe>>> {
  final Ref ref;
  List<Recipe> recipes;

  RecipeSearchNotifier(this.ref, this.recipes) : super(AsyncValue.loading()) {
    loadSearchRecipes(null);
  }

  void loadSearchRecipes(String? searchText) async {
    AsyncValue.loading();
    if (recipes.isEmpty) return;
    if (searchText == null) {
      final random = Random().nextInt(recipes.length);
      state = AsyncValue.data([recipes[random]]);
    } else {
      state = AsyncValue.data(ref
          .read(recipesProvider)
          .where((recipe) => recipe.name.toLowerCase().contains(searchText))
          .toList());
    }
  }

  void loadRecipe(Recipe recipe) async {
    final recipeResult =
        await ref.read(firestoreServiceProvider).getRecipeById(recipe.recipeId);
    state = AsyncValue.data(recipeResult != null ? [recipeResult] : []);
  }

  Future<void> deleteRecipe(String recipeId) async {
    await ref.read(firestoreServiceProvider).deleteRecipe(recipeId);
    state = AsyncValue.data(
        state.value!.where((recipe) => recipe.recipeId != recipeId).toList());
  }
}
