import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

final favoriteStatusProvider =
    FutureProvider.family<bool, String>((ref, recipeId) async {
  final user = ref.watch(userAutnenticationProvider);
  if (user == null) return false;
  return ref
      .read(firestoreServiceProvider)
      .isRecipeFavorited(recipeId, user.uid);
});
