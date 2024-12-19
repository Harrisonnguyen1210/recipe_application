import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  final String? searchText;
  final Widget? leadingWidget;
  const CustomAppBar({super.key, this.searchText, this.leadingWidget});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: searchText);

    return AppBar(
      actions: [
        SizedBox(
            width: 300,
            child: SearchBar(
              controller: searchController,
              hintText: 'Search recipes',
              leading: Icon(Icons.search),
              onSubmitted: (value) {
                context.go('/recipes?filter=$value');
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
