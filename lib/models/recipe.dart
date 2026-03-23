class Recipe {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String category;
  final int time;
  final int servings;
  final String difficulty;
  final List<String> ingredients;
  final List<String> steps;
  final bool isFavorite;

  const Recipe({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.category,
    required this.time,
    required this.servings,
    required this.difficulty,
    required this.ingredients,
    required this.steps,
    this.isFavorite = false,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? image,
    String? category,
    int? time,
    int? servings,
    String? difficulty,
    List<String>? ingredients,
    List<String>? steps,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      category: category ?? this.category,
      time: time ?? this.time,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
