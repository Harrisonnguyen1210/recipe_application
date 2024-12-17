import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/screens/category_screen/category_screen_desktop.dart';
import 'package:recipe_application/screens/category_screen/category_screen_mobile.dart';
import 'package:recipe_application/states/category_future_provider.dart';
import 'package:recipe_application/widgets/responsive_widget.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return categories.when(
      data: (data) {
        return ResponsiveWidget(
          mobile: CategoryScreenMobile(categories: data),
          desktop: CategoryScreenDesktop(categories: data),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error please try again'),
    );
  }
}
