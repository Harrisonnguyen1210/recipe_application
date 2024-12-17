import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

final recipesProvider =
    StateNotifierProvider<RecipesNotifier, AsyncValue<List<Recipe>>>(
        (ref) => RecipesNotifier(ref));

class RecipesNotifier extends StateNotifier<AsyncValue<List<Recipe>>> {
  final Ref ref;

  RecipesNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> loadRecipes(String categoryId) async {
    final firestore = ref.read(firestoreProvider);
    state = const AsyncValue.loading();
    try {
      final recipeCollection = await firestore
          .collection('recipes')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      state = AsyncValue.data(recipeCollection.docs
          .map((doc) => Recipe.fromFirestore(doc.data(), doc.id))
          .toList());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
