import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/appbar.dart';

class RecipeSearchScreen extends ConsumerWidget {
  final String? searchText;
  const RecipeSearchScreen({super.key, required this.searchText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        searchText: searchText,
        leadingWidget: GestureDetector(
          onTap: () => context.go('/'),
          child: Icon(Icons.home),
        ),
      ),
      body: FutureBuilder(
          future: ref.read(firestoreServiceProvider).getAllRecipes(),
          builder: (context, snapshot) {
            final recipeSearchList = snapshot.data
                    ?.where((recipe) =>
                        recipe.name.toLowerCase().contains(searchText ?? ''))
                    .toList() ??
                [];

            if (snapshot.connectionState == ConnectionState.done) {
              if (recipeSearchList.isEmpty) {
                return Text('No recipe found');
              }
              return ListView.builder(
                itemCount: recipeSearchList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () =>
                      context.go('/recipe/${recipeSearchList[index].recipeId}'),
                  child: Row(
                    children: [
                      Text(recipeSearchList[index].name),
                    ],
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
