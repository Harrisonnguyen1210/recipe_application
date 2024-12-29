import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/recipe_list_item.dart';
import 'package:recipe_application/widgets/responsive_widget.dart';

class RecipeListScreen extends HookConsumerWidget {
  final String categoryId;

  const RecipeListScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(recipesProvider);
    final recipeList =
        ref.watch(recipesProvider.notifier).getRecipesByCategoryId(categoryId);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            height: 50,
            child: TextButton(
              onPressed: () => context.pop(),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 8.0),
                  Text('Go back'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (recipeList.isEmpty)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: ResponsiveWidget(
                mobile: _buildRecipeList(recipeList, 1),
                tablet: _buildRecipeList(recipeList, 2),
                desktop: _buildRecipeList(recipeList, 3),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecipeList(List recipes, int crossAxisCount) {
    return AlignedGridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeListItem(recipe: recipe);
      },
    );
  }
}
