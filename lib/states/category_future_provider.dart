import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final firestore = ref.read(firestoreServiceProvider);
  return await firestore.getAllCategories();
});
