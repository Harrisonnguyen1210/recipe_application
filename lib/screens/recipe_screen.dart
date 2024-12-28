import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/recipe_item.dart';
import 'package:recipe_application/widgets/responsive_widget.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeSearchProvider);

    if (recipes.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (recipes.hasValue && recipes.value!.isEmpty) {
      return const Center(child: Text('No recipe is found'));
    }

    return ResponsiveWidget(
      mobile: _buildRecipeList(recipes.value!, 1),
      tablet: _buildRecipeList(recipes.value!, 1),
      desktop: _buildRecipeList(recipes.value!, 2),
    );
  }

  Widget _buildRecipeList(List recipes, int crossAxisCount) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AlignedGridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeItem(recipe: recipe);
        },
      ),
    );
  }
}
