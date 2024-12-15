import 'package:recipe_application/models/category.dart';
import 'package:recipe_application/models/recipe.dart';

final featuredRecipe = Recipe(
  name: "Spaghetti Carbonara",
  ingredients: [
    "200g spaghetti",
    "100g pancetta",
    "2 large eggs",
    "50g grated Parmesan cheese",
    "Salt and black pepper to taste"
  ],
  steps: [
    "Cook the spaghetti according to package instructions until al dente.",
    "While the spaghetti is cooking, fry the pancetta in a pan until crispy.",
    "In a bowl, whisk together the eggs and grated Parmesan cheese.",
    "Once the spaghetti is cooked, drain it and immediately add it to the pan with the pancetta.",
    "Remove the pan from the heat and quickly pour in the egg and cheese mixture, stirring constantly until the eggs thicken and coat the spaghetti.",
    "Season with salt and pepper to taste, and serve hot."
  ],
);

final recipeCategories = [
  Category(name: "Italian", imageUrl: "https://example.com/italian.jpg"),
  Category(name: "Mexican", imageUrl: "https://example.com/mexican.jpg"),
  Category(name: "Asian", imageUrl: "https://example.com/asian.jpg"),
];

final italianRecipes = [
  Recipe(
    name: "Margherita Pizza",
    imageUrl: "https://example.com/margherita_pizza.jpg",
    ingredients: [
      "Pizza dough",
      "Tomato sauce",
      "Fresh mozzarella",
      "Basil leaves"
    ],
    steps: [
      "Roll out the pizza dough",
      "Spread tomato sauce over the dough",
      "Add slices of fresh mozzarella",
      "Bake in a preheated oven until crust is golden and cheese is bubbly",
      "Top with fresh basil leaves before serving"
    ],
  ),
  Recipe(
    name: "Pasta Carbonara",
    imageUrl: "https://example.com/pasta_carbonara.jpg",
    ingredients: [
      "Spaghetti",
      "Pancetta",
      "Eggs",
      "Parmesan cheese",
      "Black pepper"
    ],
    steps: [
      "Cook spaghetti al dente",
      "Fry pancetta until crispy",
      "Whisk eggs and Parmesan cheese in a bowl",
      "Mix cooked spaghetti with pancetta",
      "Add egg mixture to spaghetti and toss until creamy",
      "Season with black pepper and serve"
    ],
  ),
  Recipe(
    name: "Caprese Salad",
    imageUrl: "https://example.com/caprese_salad.jpg",
    ingredients: [
      "Fresh tomatoes",
      "Fresh mozzarella",
      "Fresh basil leaves",
      "Extra virgin olive oil",
      "Balsamic vinegar",
      "Salt",
      "Black pepper"
    ],
    steps: [
      "Slice tomatoes and fresh mozzarella into rounds",
      "Arrange them alternately on a plate",
      "Tuck fresh basil leaves in between",
      "Drizzle with extra virgin olive oil and balsamic vinegar",
      "Season with salt and black pepper before serving"
    ],
  ),
  Recipe(
    name: "Tiramisu",
    imageUrl: "https://example.com/tiramisu.jpg",
    ingredients: [
      "Ladyfingers",
      "Espresso coffee",
      "Mascarpone cheese",
      "Heavy cream",
      "Sugar",
      "Cocoa powder"
    ],
    steps: [
      "Dip ladyfingers in espresso coffee and layer them in a dish",
      "Mix mascarpone cheese, heavy cream, and sugar to make a creamy mixture",
      "Spread half of the mixture over the ladyfingers",
      "Repeat the layers, ending with a layer of the creamy mixture",
      "Dust the top with cocoa powder",
      "Chill in the refrigerator for several hours before serving"
    ],
  ),
];
