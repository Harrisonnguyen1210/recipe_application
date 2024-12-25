import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/recipe_item.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteRecipes = ref.watch(favoriteRecipesFutureProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () => context.pop(),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    SizedBox(width: 8.0),
                    Text('Go back'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          favoriteRecipes.when(
            data: (recipes) {
              if (recipes.isEmpty) return Text('No favorite recipe is found');
              return ListView.builder(
                shrinkWrap: true,
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return RecipeItem(recipe: recipe);
                },
              );
            },
            error: (error, stackTrace) => Text('Error occured'),
            loading: () => Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
