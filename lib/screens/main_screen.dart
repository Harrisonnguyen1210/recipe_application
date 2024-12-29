import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/responsive_widget.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureData = ref.watch(mainScreenFutureProvider);

    return Scaffold(
      body: futureData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(
          child: Text('Error, please try again'),
        ),
        data: (data) {
          final featureRecipe = data[0] as Recipe?;
          final featureCategories =
              (data[1] as List<Category>).take(3).toList();
          if (featureRecipe == null || featureCategories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ResponsiveWidget(
            mobile: _buildMobileLayout(
                featureRecipe, featureCategories, context, ref),
            tablet: _buildTabletLayout(
                featureRecipe, featureCategories, context, ref),
            desktop: _buildDesktopLayout(
                featureRecipe, featureCategories, context, ref),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(
    Recipe featureRecipe,
    List<Category> featureCategories,
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Feature Recipe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Card(
            child: InkWell(
              onTap: () {
                ref
                    .read(recipeSearchProvider.notifier)
                    .loadRecipe(featureRecipe);
                context.go('/recipes');
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(featureRecipe.name),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text('Recipe categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ..._buildCategoryList(featureCategories, context),
          Card(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Go to categories'),
              ),
              onTap: () => context.go('/category'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(
    Recipe featureRecipe,
    List<Category> featureCategories,
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Feature Recipe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Card(
            child: InkWell(
              onTap: () {
                ref
                    .read(recipeSearchProvider.notifier)
                    .loadRecipe(featureRecipe);
                context.go('/recipes');
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(featureRecipe.name),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Recipe categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: _buildCategoryList(featureCategories, context).map(
              (e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: e,
                );
              },
            ).toList(),
          ),
          Card(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Go to categories'),
              ),
              onTap: () => context.go('/category'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(
    Recipe featureRecipe,
    List<Category> featureCategories,
    BuildContext context,
    WidgetRef ref,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Feature Recipe',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(recipeSearchProvider.notifier)
                          .loadRecipe(featureRecipe);
                      context.go('/recipes');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(featureRecipe.name),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Card(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text('Go to categories'),
                    ),
                    onTap: () => context.go('/category'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recipe categories',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ..._buildCategoryList(featureCategories, context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCategoryList(
      List<Category> categories, BuildContext context) {
    return categories.map((category) {
      return InkWell(
        onTap: () {
          context.go('/category/recipes/${category.categoryId}');
        },
        child: Row(
          children: [
            const Text("\u2022", style: TextStyle(fontSize: 30)),
            SizedBox(width: 8),
            Text(category.name),
          ],
        ),
      );
    }).toList();
  }
}
