import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

final favoriteRecipesFutureProvider = FutureProvider<List<Recipe>>((ref) async {
  final user = ref.watch(userAutnenticationProvider);
  if (user == null) return [];
  return await ref.watch(firestoreServiceProvider).getUserFavorites(user.uid);
});
