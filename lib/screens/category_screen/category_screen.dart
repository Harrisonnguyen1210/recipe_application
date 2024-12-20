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
    return FutureBuilder(
      future: ref.read(firestoreServiceProvider).getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final categoryList = snapshot.data;

          if (categoryList == null) {
            return Text('No category is found');
          }
          return ResponsiveWidget(
            mobile: CategoryScreenMobile(categories: categoryList),
            desktop: CategoryScreenDesktop(categories: categoryList),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
