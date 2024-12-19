import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

final recipeSearchProvider = FutureProvider<List<Recipe>>((ref) async {
  final firestore = ref.watch(firestoreProvider);

  final recipeCollection = await firestore.collection('recipes').get();
  return recipeCollection.docs
      .map((doc) => Recipe.fromFirestore(doc.data(), doc.id))
      .toList();
});
