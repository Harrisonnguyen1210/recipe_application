import 'package:flutter/material.dart';
import 'package:recipe_application/models/recipe.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Placeholder(fallbackHeight: 200),
          Text(recipe.name),
          ...recipe.ingredients.map((ingredient) => Text(ingredient)),
          ...recipe.steps.map((step) => Text(step)),
        ],
      ),
    );
  }
}
