import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';

class AddRecipeScreen extends HookConsumerWidget {
  static final formKey = GlobalKey<FormState>();
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
    User? user,
  ) async {
    if (formKey.currentState!.validate()) {
      isAddingRecipe.value = true;
      final recipeData = {
        'name': recipeName.value,
        'ingredients': ingredients.value,
        'steps': steps.value,
        'categoryId': selectedCategory.value?.categoryId,
        'userId': user?.uid,
      };

      ref.read(firestoreServiceProvider).addRecipe(recipeData);
      await Future.delayed(Duration(milliseconds: 300));
      isAddingRecipe.value = false;
      if (context.mounted) context.go('/');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeName = useState('');
    final ingredients = useState<List<String>>([]);
    final steps = useState<List<String>>([]);
    final ingredientController = useTextEditingController();
    final stepController = useTextEditingController();
    final categories = ref.watch(categoriesFutureProvider);
    final selectedCategory = useState<Category?>(categories.value?.first);
    final isAddingRecipe = useState(false);
    final user = ref.watch(userAutnenticationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    label: 'Recipe Name',
                    onChanged: (value) => recipeName.value = value,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a recipe name'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  _buildAddableList(
                    label: 'Add Ingredient',
                    controller: ingredientController,
                    validator: (value) {
                      if (ingredients.value.isEmpty) {
                        return 'Please add an ingredient. Click + to add';
                      }
                      return null;
                    },
                    items: ingredients.value,
                    onAdd: (value) {
                      ingredients.value = [...ingredients.value, value];
                    },
                    onDelete: (value) {
                      ingredients.value = List.from(ingredients.value)
                        ..remove(value);
                    },
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  _buildAddableList(
                    label: 'Add Step',
                    controller: stepController,
                    validator: (value) {
                      if (steps.value.isEmpty) {
                        return 'Please add a step. Click + to add';
                      }
                      return null;
                    },
                    items: steps.value,
                    onAdd: (value) {
                      steps.value = [...steps.value, value];
                    },
                    onDelete: (value) {
                      steps.value = List.from(steps.value)..remove(value);
                    },
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  const Text('Select Categories',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  categories.when(
                    data: (data) {
                      selectedCategory.value ??= data.first;
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: data.map((category) {
                          return FilterChip(
                            label: Text(category.name),
                            selected: selectedCategory.value?.categoryId ==
                                category.categoryId,
                            onSelected: (isSelected) {
                              if (isSelected) {
                                selectedCategory.value = category;
                              }
                            },
                            selectedColor:
                                Theme.of(context).colorScheme.primaryContainer,
                          );
                        }).toList(),
                      );
                    },
                    error: (error, stackTrace) => const Text(
                      'Error loading categories',
                      style: TextStyle(color: Colors.red),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: isAddingRecipe.value
                        ? const CircularProgressIndicator()
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
                              user,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Create Recipe',
                                style: TextStyle(fontSize: 16)),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildAddableList({
    required String label,
    required TextEditingController controller,
    required List<String> items,
    required Function(String) onAdd,
    required Function(String) onDelete,
    required BuildContext context,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  onAdd(controller.text);
                  controller.clear();
                }
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: items.map((item) {
            return Chip(
              label: Text(item),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => onDelete(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
