import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';
import 'package:recipe_application/widgets/app_drawer.dart';
import 'package:recipe_application/widgets/appbar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.tabView});
  final StatefulNavigationShell tabView;

  void _onItemTapped(int index) {
    tabView.goBranch(
      index,
      initialLocation: index == tabView.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userAutnenticationProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _onItemTapped(index),
        currentIndex: tabView.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_sharp),
            label: 'Category',
          ),
        ],
      ),
      body: tabView,
      drawer: user != null ? AppDrawer(ref: ref) : null,
    );
  }
}
