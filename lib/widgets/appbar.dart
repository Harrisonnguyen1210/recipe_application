import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/responsive_widget.dart';

class CustomAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final user = ref.watch(userAutnenticationProvider);

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 2,
      title: ResponsiveWidget(
        mobile: _buildMobileAppBar(context, ref, searchController, user),
        tablet: _buildDesktopAppBar(context, ref, searchController, user),
        desktop: _buildDesktopAppBar(context, ref, searchController, user),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Recipe Application',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildMobileAppBar(
    BuildContext context,
    WidgetRef ref,
    TextEditingController searchController,
    dynamic user,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitle(context),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Search Recipes'),
                    content: _buildSearchBar(searchController, ref, context),
                  ),
                );
              },
            ),
            if (user == null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                ),
                onPressed: () {
                  _showSignInDialog(context, ref);
                },
                child: const Text('Sign in'),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopAppBar(
    BuildContext context,
    WidgetRef ref,
    TextEditingController searchController,
    dynamic user,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitle(context),
        Row(
          children: [
            SizedBox(
              width: 300,
              child: _buildSearchBar(searchController, ref, context),
            ),
            if (user == null)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  onPressed: () {
                    _showSignInDialog(context, ref);
                  },
                  child: const Text('Sign in'),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(
    TextEditingController searchController,
    WidgetRef ref,
    BuildContext context,
  ) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search recipes',
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onSubmitted: (value) {
        ref.read(recipeSearchProvider.notifier).loadSearchRecipes(value);
        context.go('/recipes');
        searchController.clear();
        if (MediaQuery.of(context).size.width < 600) context.pop();
      },
    );
  }

  void _showSignInDialog(BuildContext context, WidgetRef ref) {
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
              ref.read(userAutnenticationProvider.notifier).signInAnonymously();
            },
            child: const Text('Login anonymously'),
          ),
        ],
      ),
    );
  }
}
