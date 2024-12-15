import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_application/models/dummy_data.dart';

class RecipeListScreen extends StatelessWidget {
  final String categoryId;

  const RecipeListScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: italianRecipes.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => context.go('/recipe/1'),
        child: Row(
          children: [
            Text(italianRecipes[index].name),
          ],
        ),
      ),
    );
  }
}
