import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

class RecipeItem extends HookConsumerWidget {
  final Recipe recipe;
  const RecipeItem({super.key, required this.recipe});

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
    final user = ref.watch(userAutnenticationProvider);
    final isFavorite = ref.watch(favoriteStatusProvider(recipe.recipeId));

    return Card(
      margin: const EdgeInsets.only(top: 16, left: 24, right: 24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.image_not_supported, size: 80),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
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
            ),
            user != null
                ? Column(
                    children: [
                      isFavorite.when(
                        data: (isFavorite) => InkWell(
                          child: isFavorite
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_outline),
                          onTap: () async {
                            await ref
                                .read(firestoreServiceProvider)
                                .toggleFavorite(
                                    recipe.recipeId, user.uid, !isFavorite);
                            ref.invalidate(
                                favoriteStatusProvider(recipe.recipeId));
                            ref.invalidate(favoriteRecipesFutureProvider);
                          },
                        ),
                        error: (error, _) => SizedBox.shrink(),
                        loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      if (recipe.userId == user.uid)
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'edit') {
                            context.go('/updateRecipe/${recipe.recipeId}');
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
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
