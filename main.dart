import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// APP ROOT

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecipeListScreen(),
    );
  }
}

// MODEL

class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}

// JSON (same as question)

const String recipesJson = '''
{
  "recipes": [
    {
      "title": "Pasta Carbonara",
      "description": "Creamy pasta dish with bacon and cheese.",
      "ingredients": ["spaghetti", "bacon", "egg", "cheese"]
    },
    {
      "title": "Caprese Salad",
      "description": "Simple and refreshing salad with tomatoes, mozzarella, and basil.",
      "ingredients": ["tomatoes", "mozzarella", "basil"]
    },
    {
      "title": "Banana Smoothie",
      "description": "Healthy and creamy smoothie with bananas and milk.",
      "ingredients": ["bananas", "milk"]
    },
    {
      "title": "Chicken Stir-Fry",
      "description": "Quick and flavorful stir-fried chicken with vegetables.",
      "ingredients": ["chicken breast", "broccoli", "carrot", "soy sauce"]
    },
    {
      "title": "Grilled Salmon",
      "description": "Delicious grilled salmon with lemon and herbs.",
      "ingredients": ["salmon fillet", "lemon", "olive oil", "dill"]
    },
    {
      "title": "Vegetable Curry",
      "description": "Spicy and aromatic vegetable curry.",
      "ingredients": ["mixed vegetables", "coconut milk", "curry powder"]
    },
    {
      "title": "Berry Parfait",
      "description": "Layered dessert with fresh berries and yogurt.",
      "ingredients": ["berries", "yogurt", "granola"]
    }
  ]
}
''';

//UI + PARSING

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  List<Recipe> _parseRecipes() {
    final Map<String, dynamic> decoded = jsonDecode(recipesJson);
    final List<dynamic> list = decoded['recipes'];
    return list.map((e) => Recipe.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final recipes = _parseRecipes();

    return Scaffold(
      // we build the header ourselves to match the screenshot
      body: Column(
        children: [
          // BLUE HEADER BAR (like in the provided UI)
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 12),
            child: const Text(
              'Food Recipes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // LIST OF RECIPES
          Expanded(
            child: ListView.separated(
              itemCount: recipes.length,
              separatorBuilder: (context, index) =>
              const Divider(height: 1, thickness: 0.5),
              itemBuilder: (context, index) {
                final recipe = recipes[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  leading: const Icon(
                    Icons.fastfood, // looks close to the screenshot icon
                    size: 20,
                  ),
                  title: Text(
                    recipe.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    recipe.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  dense: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
