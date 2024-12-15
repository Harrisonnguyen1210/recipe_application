import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_application/models/dummy_data.dart';
import 'package:recipe_application/widgets/category_recipe_view.dart';
import 'package:recipe_application/widgets/responsive_widget.dart';

class RecipeCategoryScreen extends StatelessWidget {
  const RecipeCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: ListView.builder(
        itemBuilder: (context, index) {
          return Row(
            children: [
              const Placeholder(fallbackHeight: 200),
              InkWell(
                  onTap: () => context.go('/category/recipes/$index'),
                  child: Text(recipeCategories[index].name)),
            ],
          );
        },
        itemCount: recipeCategories.length,
      ),
      desktop: const CategoryAndRecipeView(),
    );
  }
}
