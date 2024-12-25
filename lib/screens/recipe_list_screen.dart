import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

class RecipeListScreen extends ConsumerWidget {
  final String categoryId;

  const RecipeListScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref
            .read(firestoreServiceProvider)
            .getRecipesByCategoryId(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final recipeList = snapshot.data;
            if (recipeList == null) {
              return Text('No recipe is found');
            }
            return ListView.builder(
              itemCount: recipeList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  ref
                      .read(recipeSearchProvider.notifier)
                      .loadRecipe(recipeList[index]);
                  context.go('/recipes');
                },
                child: Row(
                  children: [
                    Text(recipeList[index].name),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
