import 'package:flutter/material.dart';
import 'package:recipe_application/models/dummy_data.dart';

class RecipeScreen extends StatelessWidget {
  final String recipeId;

  const RecipeScreen({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    final recipe = featuredRecipe;
    return Column(
      children: [
        const Placeholder(fallbackHeight: 200),
        Text(recipe.name),
        ...recipe.ingredients.map((ingredient) => Text(ingredient)),
        ...recipe.steps.map((step) => Text(step)),
      ],
    );
  }
}
