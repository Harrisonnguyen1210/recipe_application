import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';

class CategoryScreenMobile extends ConsumerWidget {
  final List<Category> categories;
  const CategoryScreenMobile({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Row(
          children: [
            const Icon(Icons.image_not_supported, size: 100),
            InkWell(
                onTap: () => context
                    .go('/category/recipes/${categories[index].categoryId}'),
                child: Text(categories[index].name)),
          ],
        );
      },
      itemCount: categories.length,
    );
  }
}
