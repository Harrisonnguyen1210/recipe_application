import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/firestore_provider.dart';

final categoriesFutureProvider = FutureProvider<List<Category>>((ref) async {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final categories = await firestoreService.getAllCategories();
  return categories;
});
