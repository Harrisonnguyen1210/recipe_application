import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/recipe_list_item.dart';

class RecipeListScreen extends HookConsumerWidget {
  final String categoryId;

  const RecipeListScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(recipesProvider);
    final recipeList =
        ref.read(recipesProvider.notifier).getRecipesByCategoryId(categoryId);

    if (recipeList.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemCount: recipeList.length,
      itemBuilder: (context, index) {
        final recipe = recipeList[index];
        return RecipeListItem(recipe: recipe);
      },
    );
  }
}
