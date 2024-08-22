class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final int prepTime;
  final int cookTime;
  final List<String> tags;
  final String description;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.prepTime,
    required this.cookTime,
    required this.tags,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['ID'] as String,
      title: json['Name'] as String,
      imageUrl: json['ImageURL'] as String? ?? '', // Handle null or missing field
      prepTime: json['PrepTime'] != null ? json['PrepTime'] as int : 0,
      cookTime: json['CookTime'] != null ? json['CookTime'] as int : 0,
      tags: List<String>.from(json['Tags'] ?? []), // Handle null by providing an empty list
      description: json['Description'] as String? ?? '', // Handle null or missing field
      ingredients: List<String>.from(json['Ingredients'] ?? []), // Handle null by providing an empty list
      steps: List<String>.from(json['Instructions'] ?? []), // Handle null by providing an empty list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': title,
      'ImageURL': imageUrl,
      'PrepTime': prepTime,
      'CookTime': cookTime,
      'Tags': tags,
      'Description': description,
      'Ingredients': ingredients,
      'Instructions': steps,
    };
  }
}
