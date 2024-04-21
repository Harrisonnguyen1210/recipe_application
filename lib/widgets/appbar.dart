import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [
        SizedBox(
            width: 100,
            child: SearchBar(
              leading: Icon(Icons.search),
            ))
      ],
      title: const Text('Recipe Application'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
