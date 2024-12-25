import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

class AddRecipeScreen extends HookConsumerWidget {
  const AddRecipeScreen({super.key});

  Future<void> createRecipe(
    GlobalKey<FormState> formKey,
    ValueNotifier<String> recipeName,
    ValueNotifier<List<String>> ingredients,
    ValueNotifier<List<String>> steps,
    ValueNotifier<Category?> selectedCategory,
    ValueNotifier<bool> isAddingRecipe,
    WidgetRef ref,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      isAddingRecipe.value = true;
      final recipeData = {
        'name': recipeName.value,
        'ingredients': ingredients.value,
        'steps': steps.value,
        'categoryId': selectedCategory.value?.categoryId,
        'imageUrl': '',
        'userId': ref.read(userAutnenticationProvider)?.uid,
      };

      ref.read(firestoreServiceProvider).addRecipe(recipeData);
      await Future.delayed(Duration(milliseconds: 300));
      isAddingRecipe.value = false;
      if (context.mounted) context.go('/');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final recipeName = useState('');
    final ingredients = useState<List<String>>([]);
    final steps = useState<List<String>>([]);
    final ingredientController = useTextEditingController();
    final stepController = useTextEditingController();
    final categories = ref.watch(categoriesFutureProvider);
    final selectedCategory = useState<Category?>(categories.value?.first);
    final isAddingRecipe = useState(false);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Recipe')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recipe Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a recipe name'
                    : null,
                onChanged: (value) => recipeName.value = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ingredientController,
                validator: (value) {
                  if (ingredients.value.isEmpty) {
                    return 'Please add an ingredient';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Add Ingredient',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (ingredientController.text.isNotEmpty) {
                        ingredients.value = [
                          ...ingredients.value,
                          ingredientController.text,
                        ];
                        ingredientController.clear();
                      }
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ingredients.value
                    .map(
                      (ingredient) => Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Chip(
                          label: Text(ingredient),
                          onDeleted: () {
                            ingredients.value = List.from(ingredients.value)
                              ..remove(ingredient);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: stepController,
                validator: (value) {
                  if (steps.value.isEmpty) {
                    return 'Please add a step';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Add Step',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (stepController.text.isNotEmpty) {
                        steps.value = [
                          ...steps.value,
                          stepController.text,
                        ];
                        stepController.clear();
                      }
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: steps.value
                    .map(
                      (step) => Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Chip(
                          label: Text(step),
                          onDeleted: () {
                            steps.value = List.from(steps.value)..remove(step);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text('Select Categories'),
              const SizedBox(height: 16),
              categories.when(
                data: (data) {
                  selectedCategory.value ??= data.first;
                  return Wrap(
                    children: data
                        .map(
                          (category) => Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: FilterChip(
                              label: Text(category.name),
                              selected: selectedCategory.value == category,
                              onSelected: (isSelected) {
                                if (isSelected) {
                                  selectedCategory.value = category;
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
                error: (error, stackTrace) => Text('Error loading categories'),
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: isAddingRecipe.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => createRecipe(
                          formKey,
                          recipeName,
                          ingredients,
                          steps,
                          selectedCategory,
                          isAddingRecipe,
                          ref,
                          context,
                        ),
                        child: const Text('Create Recipe'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
