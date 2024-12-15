import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryAndRecipeView extends StatefulWidget {
  const CategoryAndRecipeView({super.key});

  @override
  State createState() => _CategoryAndRecipeViewState();
}

class _CategoryAndRecipeViewState extends State<CategoryAndRecipeView> {
  final List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4'
  ];
  final Map<String, List<String>> recipesByCategory = {
    'Category 1':
        List.generate(20, (index) => 'Recipe ${index + 1} in Category 1'),
    'Category 2':
        List.generate(15, (index) => 'Recipe ${index + 1} in Category 2'),
    'Category 3':
        List.generate(10, (index) => 'Recipe ${index + 1} in Category 3'),
    'Category 4':
        List.generate(5, (index) => 'Recipe ${index + 1} in Category 4'),
  };

  String selectedCategory = 'Category 1'; // Default selected category

  @override
  Widget build(BuildContext context) {
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
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    color: category == selectedCategory
                        ? Colors.blue.shade100
                        : null,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: category == selectedCategory
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: category == selectedCategory
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: recipesByCategory[selectedCategory] != null
                ? ListView.builder(
                    itemCount: recipesByCategory[selectedCategory]!.length,
                    itemBuilder: (context, index) {
                      final recipe =
                          recipesByCategory[selectedCategory]![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: ListTile(
                          title: Text(recipe),
                          onTap: () => context.go('/recipe/1'),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No recipes available for this category.'),
                  ),
          ),
        ],
      ),
    );
  }
}
