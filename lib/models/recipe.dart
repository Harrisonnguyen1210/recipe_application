class Recipe {
  String name;
  String? imageUrl;
  List<String> ingredients;
  List<String> steps;

  Recipe({
    required this.name,
    this.imageUrl,
    required this.ingredients,
    required this.steps,
  });
}
