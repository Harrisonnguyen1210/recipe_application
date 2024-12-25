import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/recipe_item.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeSearchProvider);

    if (recipes.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (recipes.hasValue && recipes.value!.isEmpty) {
      return Text('No recipe is found');
    }

    return ListView.builder(
      itemCount: recipes.value!.length,
      itemBuilder: (context, index) {
        final recipe = recipes.value![index];
        return RecipeItem(recipe: recipe);
      },
    );
  }
}
