import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

final mainScreenFutureProvider = FutureProvider<List<dynamic>>((ref) async {
  final featuredRecipe = ref.watch(featuredRecipeProvider.future);
  final featureCategories = ref.watch(categoriesFutureProvider.future);
  return await Future.wait([featuredRecipe, featureCategories]);
});

final featuredRecipeProvider = FutureProvider<Recipe?>((ref) async {
  final recipes = ref.watch(recipesProvider);
  if (recipes.isEmpty) return null;
  final random = Random().nextInt(recipes.length);
  return recipes[random];
});
