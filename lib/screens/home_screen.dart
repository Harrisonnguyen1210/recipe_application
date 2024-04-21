import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_application/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.tabView});
  final StatefulNavigationShell tabView;

  void _onItemTapped(int index) {
    tabView.goBranch(
      index,
      initialLocation: index == tabView.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            label: 'Random',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_sharp),
            label: 'Category',
          ),
        ],
      ),
      body: tabView,
    );
  }
}
