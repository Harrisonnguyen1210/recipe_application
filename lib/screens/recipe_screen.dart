import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({super.key});

  void _deleteRecipe(BuildContext context, WidgetRef ref, String recipeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: const Text('Are you sure you want to delete this recipe?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(recipeSearchProvider.notifier).deleteRecipe(recipeId);
              context.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Recipe deleted successfully.'),
                  duration: Duration(seconds: 1),
                ),
              );
              ref.read(recipesProvider.notifier).loadRecipes();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeSearchProvider);
    final user = ref.watch(userAutnenticationProvider);

    if (recipes.isEmpty) return Text('No recipe is found');

    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];

        return Card(
          margin: const EdgeInsets.only(top: 16, left: 24, right: 24),
          child: ListTile(
            leading: const Icon(Icons.image_not_supported, size: 50),
            title: Text(
              recipe.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Ingredients:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ...recipe.ingredients
                    .map((ingredient) => Text('- $ingredient')),
                SizedBox(height: 8),
                Text(
                  'Steps:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ...recipe.steps.map((step) => Text('- $step')),
              ],
            ),
            trailing: user != null
                // trailing: user != null && user.uid == recipe.userId
                ? PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'edit') {
                        context.go('/addRecipe');
                      } else if (value == 'delete') {
                        _deleteRecipe(context, ref, recipe.recipeId);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }
}
