import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

class CustomAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  final Widget? leadingWidget;
  const CustomAppBar({super.key, this.leadingWidget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    return AppBar(
      actions: [
        SizedBox(
            width: 300,
            child: SearchBar(
              controller: searchController,
              hintText: 'Search recipes',
              leading: Icon(Icons.search),
              onSubmitted: (value) {
                ref
                    .read(recipeSearchProvider.notifier)
                    .loadSearchRecipes(value);
                context.go('/recipes');
                searchController.clear();
              },
            ))
      ],
      title: const Text('Recipe Application'),
      leading: leadingWidget,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
