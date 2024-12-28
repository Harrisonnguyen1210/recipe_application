import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/screens/category_screen/category_screen_desktop.dart';
import 'package:recipe_application/screens/category_screen/category_screen_mobile.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/responsive_widget.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesFutureProvider);
    return categories.when(
      data: (categoryList) {
        if (categoryList.isEmpty) {
          return Text('No category is found');
        }
        return ResponsiveWidget(
          mobile: CategoryScreenMobile(categories: categoryList),
          tablet: CategoryScreenDesktop(categories: categoryList),
          desktop: CategoryScreenDesktop(categories: categoryList),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
