import 'package:firebase_auth/firebase_auth.dart';
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
        _buildLoginLogoutButton(context, user, ref)
      ],
      title: const Text('Recipe Application'),
    );
  }

  Widget _buildLoginLogoutButton(
    BuildContext context,
    User? user,
    WidgetRef ref,
  ) {
    if (user != null) {
      return TextButton(
        onPressed: () {
          ref.read(userAutnenticationProvider.notifier).signOutAnonymously();
        },
        child: Text('Sign out'),
      );
    }
    return TextButton(
      onPressed: () {
        context.go('/login');
      },
      child: Text('Sign in'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
