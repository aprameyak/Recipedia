// Using DateTime for now, can be replaced with Firestore Timestamp later

class Recipe {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final String authorName;
  final String authorAvatar;
  final List<String> images;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTime; // in minutes
  final int cookTime; // in minutes
  final int servings;
  final String difficulty; // Easy, Medium, Hard
  final List<String> categories; // Desserts, Proteins, etc.
  final List<String> tags; // Vegetarian, Gluten-free, etc.
  final double rating;
  final int ratingCount;
  final int likes;
  final int views;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPublished;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.authorName,
    required this.authorAvatar,
    required this.images,
    required this.ingredients,
    required this.instructions,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.difficulty,
    required this.categories,
    required this.tags,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.likes = 0,
    this.views = 0,
    required this.createdAt,
    required this.updatedAt,
    this.isPublished = true,
  });

  int get totalTime => prepTime + cookTime;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'images': images,
      'ingredients': ingredients,
      'instructions': instructions,
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'difficulty': difficulty,
      'categories': categories,
      'tags': tags,
      'rating': rating,
      'ratingCount': ratingCount,
      'likes': likes,
      'views': views,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isPublished': isPublished,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      authorAvatar: map['authorAvatar'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      ingredients: List<String>.from(map['ingredients'] ?? []),
      instructions: List<String>.from(map['instructions'] ?? []),
      prepTime: map['prepTime']?.toInt() ?? 0,
      cookTime: map['cookTime']?.toInt() ?? 0,
      servings: map['servings']?.toInt() ?? 1,
      difficulty: map['difficulty'] ?? 'Medium',
      categories: List<String>.from(map['categories'] ?? []),
      tags: List<String>.from(map['tags'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      ratingCount: map['ratingCount']?.toInt() ?? 0,
      likes: map['likes']?.toInt() ?? 0,
      views: map['views']?.toInt() ?? 0,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      isPublished: map['isPublished'] ?? true,
    );
  }

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    List<String>? images,
    List<String>? ingredients,
    List<String>? instructions,
    int? prepTime,
    int? cookTime,
    int? servings,
    String? difficulty,
    List<String>? categories,
    List<String>? tags,
    double? rating,
    int? ratingCount,
    int? likes,
    int? views,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPublished,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      images: images ?? this.images,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      prepTime: prepTime ?? this.prepTime,
      cookTime: cookTime ?? this.cookTime,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}

class RecipeCategory {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String image;
  final int recipeCount;

  RecipeCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.image,
    this.recipeCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'image': image,
      'recipeCount': recipeCount,
    };
  }

  factory RecipeCategory.fromMap(Map<String, dynamic> map) {
    return RecipeCategory(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
      image: map['image'] ?? '',
      recipeCount: map['recipeCount']?.toInt() ?? 0,
    );
  }
}
