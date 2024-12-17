import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureData = ref.watch(mainScreenFutureProvider);
    return futureData.when(
        loading: () => Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, stackTrace) => Text('Error please try again'),
        data: (data) {
          final featureRecipe = data[0] as Recipe;
          final featureCategories = data[1] as List<Category>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Feature Recipe'),
              Card(
                child: InkWell(
                  onTap: () => context.go('/recipe/${featureRecipe.recipeId}'),
                  child: Column(
                    children: [Text(featureRecipe.name)],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Recipe caterories'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: featureCategories.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    context.go(
                        '/category/recipes/${featureCategories[index].categoryId}');
                  },
                  child: Row(
                    children: [
                      const Text(
                        "\u2022",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(featureCategories[index].name)
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
        });
  }
}
