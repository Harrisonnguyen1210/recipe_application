import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

class RecipeListItem extends HookConsumerWidget {
  final Recipe recipe;
  const RecipeListItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userAutnenticationProvider);
    final isFavorite = ref.watch(favoriteStatusProvider(recipe.recipeId));

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: () {
          ref.read(recipeSearchProvider.notifier).loadRecipe(recipe);
          context.go('/recipes');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(recipe.name),
              ),
            ),
            user != null
                ? isFavorite.when(
                    data: (isFavorite) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
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
                          ref.invalidate(
                              favoriteCountFutureProvider(recipe.recipeId));
                        },
                      ),
                    ),
                    error: (error, _) => SizedBox.shrink(),
                    loading: () => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
