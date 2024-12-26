import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

final favoriteCountFutureProvider =
    FutureProvider.family<int, String>((ref, recipeId) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getFavoriteCount(recipeId);
});
