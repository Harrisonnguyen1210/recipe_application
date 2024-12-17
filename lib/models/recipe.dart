class Recipe {
  String recipeId;
  String name;
  String? imageUrl;
  List<String> ingredients;
  List<String> steps;

  Recipe({
    required this.recipeId,
    required this.name,
    this.imageUrl,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
      recipeId: id,
      name: data['name'],
      imageUrl: data['imageUrl'],
      ingredients: (data['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      steps: (data['steps'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'steps': steps,
    };
  }
}
