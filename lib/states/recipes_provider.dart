import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

final recipesProvider = StateNotifierProvider<RecipesNotifier, List<Recipe>>(
    (ref) => RecipesNotifier(ref));

class RecipesNotifier extends StateNotifier<List<Recipe>> {
  final Ref ref;

  RecipesNotifier(this.ref) : super([]) {
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    final firestoreService = ref.read(firestoreServiceProvider);
    state = await firestoreService.getAllRecipes();
  }

  List<Recipe> getRecipesByCategoryId(String categoryId) {
    return state.where((recipe) => recipe.categoryId == categoryId).toList();
  }
}
