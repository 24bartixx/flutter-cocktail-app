import 'package:cocktails/data/models/ingredient.dart';

class Cocktail {

  final int id;
  final String name;
  final String category;
  final String glass;
  final String instructions;
  final String imageUrl;
  final bool alcoholic;
  final DateTime createdAt;
  final DateTime updatedAt;
  List<Ingredient> ingredients;

  Cocktail({
    required this.id,
    required this.name,
    required this.category,
    required this.glass,
    required this.instructions,
    required this.imageUrl,
    required this.alcoholic,
    required this.createdAt,
    required this.updatedAt,
    this.ingredients = const[]
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'id': int id,
        'name': String name,
        'category': String category,
        'glass': String glass,
        'instructions': String instructions,
        'imageUrl': String imageUrl,
        'alcoholic': bool alcoholic,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt
      } => 
      Cocktail(
        id: id,
        name: name,
        category: category,
        glass: glass,
        instructions: instructions,
        imageUrl: imageUrl,
        alcoholic: alcoholic,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt)
      ),
      _ => throw const FormatException('Failed to load cocktail.')
    };
  }

  void addIngredients(List<Map<String, dynamic>> newIngredients) {
    ingredients = newIngredients.map((object) => Ingredient.fromJson(object)).toList();
  }

}