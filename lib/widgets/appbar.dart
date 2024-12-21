import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

class CustomAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final user = ref.watch(userAutnenticationProvider);

    return AppBar(
      actions: [
        SizedBox(
          width: 300,
          child: SearchBar(
            controller: searchController,
            hintText: 'Search recipes',
            leading: Icon(Icons.search),
            onSubmitted: (value) {
              ref.read(recipeSearchProvider.notifier).loadSearchRecipes(value);
              context.go('/recipes');
              searchController.clear();
            },
          ),
        ),
        if (user == null)
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sign in'),
                  content: const Text('Please sign in'),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                        ref
                            .read(userAutnenticationProvider.notifier)
                            .signInAnonymously();
                      },
                      child: const Text('Login anonymously'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Sign in'),
          )
      ],
      title: const Text('Recipe Application'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
