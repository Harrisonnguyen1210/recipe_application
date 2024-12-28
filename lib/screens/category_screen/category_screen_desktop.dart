import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/recipe_list_item.dart';

class CategoryScreenDesktop extends HookConsumerWidget {
  final List<Category> categories;
  const CategoryScreenDesktop({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = useState(categories[0]);
    ref.watch(recipesProvider);
    final recipes = ref
        .read(recipesProvider.notifier)
        .getRecipesByCategoryId(selectedCategory.value.categoryId);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories & Recipes')),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    selectedCategory.value = category;
                  },
                  child: ListTile(
                    leading: Icon(Icons.image_not_supported, size: 50),
                    title: Container(
                      color: category == selectedCategory.value
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: category == selectedCategory.value
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: category == selectedCategory.value
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return RecipeListItem(recipe: recipe);
              },
            ),
          )
        ],
      ),
    );
  }
}
