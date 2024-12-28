class Recipe {
  String recipeId;
  String name;
  List<String> ingredients;
  List<String> steps;
  String categoryId;
  String userId;

  Recipe({
    required this.recipeId,
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.categoryId,
    required this.userId,
  });

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
      recipeId: id,
      name: data['name'],
      ingredients: (data['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      steps: (data['steps'] as List<dynamic>).map((e) => e as String).toList(),
      categoryId: data['categoryId'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      'categoryId': categoryId,
      'userId': userId,
    };
  }
}
