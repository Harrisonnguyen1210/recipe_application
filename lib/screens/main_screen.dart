import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_application/models/dummy_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Feature Recipe'),
          Card(
            child: InkWell(
              onTap: () => context.go('/recipe'),
              child: Column(
                children: [Text(featuredRecipe.name)],
              ),
            ),
          )
        ],
      ),
    );
  }
}
