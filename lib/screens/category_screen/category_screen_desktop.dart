import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

class CategoryScreenDesktop extends HookConsumerWidget {
  final List<Category> categories;
  const CategoryScreenDesktop({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = useState(categories[0]);
    final recipes = ref.watch(recipesProvider);

    useEffect(() {
      ref
          .read(recipesProvider.notifier)
          .loadRecipes(selectedCategory.value.categoryId);
      return;
    }, const []);

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
                    ref
                        .read(recipesProvider.notifier)
                        .loadRecipes(selectedCategory.value.categoryId);
                  },
                  child: Container(
                    color: category == selectedCategory.value
                        ? Colors.blue.shade100
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
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          recipes.when(
            data: (data) {
              return Expanded(
                flex: 2,
                child: data.isNotEmpty
                    ? ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final recipe = data[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: ListTile(
                              title: Text(recipe.name),
                              onTap: () =>
                                  context.go('/recipe/${recipe.recipeId}'),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No recipes available for this category.'),
                      ),
              );
            },
            error: (error, stackTrace) => Text('Error please try again'),
            loading: () => Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
