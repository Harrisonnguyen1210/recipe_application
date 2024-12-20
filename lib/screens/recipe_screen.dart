import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeSearchProvider);

    return ListView.builder(
      itemBuilder: (context, index) {
        return Row(
          children: [
            const Placeholder(fallbackHeight: 150, fallbackWidth: 150),
            Column(
              children: [
                Text(recipes[index].name),
                ...recipes[index]
                    .ingredients
                    .map((ingredient) => Text(ingredient)),
                ...recipes[index].steps.map((step) => Text(step)),
              ],
            )
          ],
        );
      },
      itemCount: recipes.length,
    );
  }
}
