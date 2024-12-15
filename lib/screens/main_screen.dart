import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_application/models/dummy_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Feature Recipe'),
        Card(
          child: InkWell(
            onTap: () => context.go('/recipe/1'),
            child: Column(
              children: [Text(featuredRecipe.name)],
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text('Recipe caterories'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: recipeCategories.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              context.go('/category/recipes/$index');
            },
            child: Row(
              children: [
                const Text(
                  "\u2022",
                  style: TextStyle(fontSize: 30),
                ),
                Text(recipeCategories[index].name)
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () => context.go('/category'),
          child: const Text('Go to categories'),
        ),
      ],
    );
  }
}
