import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

class RecipeScreen extends HookConsumerWidget {
  final String recipeId;

  const RecipeScreen({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newRecipeId = useState(recipeId);
    useEffect(() {
      if (recipeId == 'featuredRecipe') {
        newRecipeId.value =
            ref.read(featuredRecipeProvider).value?.recipeId ?? '';
      }
      return;
    }, const []);

    return FutureBuilder(
      future:
          ref.read(firestoreServiceProvider).getRecipeById(newRecipeId.value),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipe = snapshot.data;
          if (recipe == null) {
            return Text('No recipe is found');
          }
          return Column(
            children: [
              const Placeholder(fallbackHeight: 200),
              Text(recipe.name),
              ...recipe.ingredients.map((ingredient) => Text(ingredient)),
              ...recipe.steps.map((step) => Text(step)),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
