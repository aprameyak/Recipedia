import 'dart:math';
import '../models/recipe.dart';

class RecipeService {
  // Mock data for demonstration - replace with real API calls
  static final List<Recipe> _mockRecipes = [
    Recipe(
      id: '1',
      title: 'Chocolate Chip Cookies',
      description: 'Classic homemade chocolate chip cookies that are soft on the inside and crispy on the outside.',
      authorId: 'user1',
      authorName: 'Chef Sarah',
      authorAvatar: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      images: [
        'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400&h=300&fit=crop',
      ],
      ingredients: [
        '2 1/4 cups all-purpose flour',
        '1 cup butter, softened',
        '3/4 cup granulated sugar',
        '3/4 cup brown sugar',
        '2 large eggs',
        '1 tsp vanilla extract',
        '1 tsp baking soda',
        '1/2 tsp salt',
        '2 cups chocolate chips',
      ],
      instructions: [
        'Preheat oven to 375°F (190°C)',
        'Cream together butter and sugars until light and fluffy',
        'Beat in eggs and vanilla',
        'Mix in flour, baking soda, and salt',
        'Stir in chocolate chips',
        'Drop rounded tablespoons onto ungreased baking sheets',
        'Bake for 9-11 minutes until golden brown',
        'Cool on baking sheets for 2 minutes, then transfer to wire racks',
      ],
      prepTime: 15,
      cookTime: 10,
      servings: 24,
      difficulty: 'Easy',
      categories: ['Desserts', 'Baking'],
      tags: ['Vegetarian', 'Kid-friendly'],
      rating: 4.8,
      ratingCount: 1250,
      likes: 890,
      views: 5600,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Recipe(
      id: '2',
      title: 'Grilled Chicken Salad',
      description: 'A healthy and delicious grilled chicken salad with fresh vegetables and homemade dressing.',
      authorId: 'user2',
      authorName: 'Chef Mike',
      authorAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      images: [
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop',
      ],
      ingredients: [
        '2 chicken breasts',
        'Mixed salad greens',
        'Cherry tomatoes',
        'Cucumber',
        'Red onion',
        'Olive oil',
        'Balsamic vinegar',
        'Salt and pepper',
        'Herbs (basil, oregano)',
      ],
      instructions: [
        'Season chicken breasts with salt, pepper, and herbs',
        'Grill chicken for 6-8 minutes per side until cooked through',
        'Let chicken rest for 5 minutes, then slice',
        'Wash and prepare vegetables',
        'Combine salad greens, tomatoes, cucumber, and onion',
        'Top with sliced chicken',
        'Drizzle with olive oil and balsamic vinegar',
        'Season with salt and pepper to taste',
      ],
      prepTime: 10,
      cookTime: 15,
      servings: 2,
      difficulty: 'Easy',
      categories: ['Proteins', 'Salads', 'Healthy'],
      tags: ['Gluten-free', 'Low-carb', 'High-protein'],
      rating: 4.6,
      ratingCount: 890,
      likes: 650,
      views: 3200,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Recipe(
      id: '3',
      title: 'Margarita Pizza',
      description: 'Authentic Italian Margarita pizza with fresh mozzarella, basil, and tomato sauce.',
      authorId: 'user3',
      authorName: 'Chef Maria',
      authorAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      images: [
        'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
      ],
      ingredients: [
        'Pizza dough',
        'Fresh mozzarella cheese',
        'Fresh basil leaves',
        'Tomato sauce',
        'Olive oil',
        'Salt',
        'Pizza stone or baking sheet',
      ],
      instructions: [
        'Preheat oven to 500°F (260°C) with pizza stone',
        'Roll out pizza dough to desired thickness',
        'Spread tomato sauce evenly over dough',
        'Add fresh mozzarella slices',
        'Drizzle with olive oil and sprinkle with salt',
        'Bake for 10-12 minutes until crust is golden',
        'Remove from oven and add fresh basil leaves',
        'Let rest for 2 minutes before slicing',
      ],
      prepTime: 20,
      cookTime: 12,
      servings: 4,
      difficulty: 'Medium',
      categories: ['Carbs', 'Italian', 'Pizza'],
      tags: ['Vegetarian', 'Italian'],
      rating: 4.9,
      ratingCount: 2100,
      likes: 1800,
      views: 8900,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  static final List<RecipeCategory> _categories = [
    RecipeCategory(
      id: 'desserts',
      name: 'Desserts',
      description: 'Sweet treats and baked goods',
      icon: '🍰',
      image: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=300&h=200&fit=crop',
      recipeCount: 45,
    ),
    RecipeCategory(
      id: 'proteins',
      name: 'Proteins',
      description: 'Meat, fish, and protein-rich dishes',
      icon: '🥩',
      image: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300&h=200&fit=crop',
      recipeCount: 78,
    ),
    RecipeCategory(
      id: 'carbs',
      name: 'Carbs',
      description: 'Pasta, bread, and grain dishes',
      icon: '🍝',
      image: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=300&h=200&fit=crop',
      recipeCount: 62,
    ),
    RecipeCategory(
      id: 'drinks',
      name: 'Drinks',
      description: 'Beverages and cocktails',
      icon: '🥤',
      image: 'https://images.unsplash.com/photo-1546173159-315724a31696?w=300&h=200&fit=crop',
      recipeCount: 34,
    ),
    RecipeCategory(
      id: 'healthy',
      name: 'Healthy',
      description: 'Nutritious and balanced meals',
      icon: '🥗',
      image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=300&h=200&fit=crop',
      recipeCount: 89,
    ),
    RecipeCategory(
      id: 'quick',
      name: 'Quick & Easy',
      description: 'Fast recipes under 30 minutes',
      icon: '⚡',
      image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=300&h=200&fit=crop',
      recipeCount: 156,
    ),
  ];

  // Get all recipes
  static Future<List<Recipe>> getAllRecipes() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockRecipes;
  }

  // Get featured recipes
  static Future<List<Recipe>> getFeaturedRecipes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockRecipes.take(3).toList();
  }

  // Get recipes by category
  static Future<List<Recipe>> getRecipesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockRecipes.where((recipe) => recipe.categories.contains(category)).toList();
  }

  // Get recipe by ID
  static Future<Recipe?> getRecipeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mockRecipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get all categories
  static Future<List<RecipeCategory>> getAllCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _categories;
  }

  // Search recipes
  static Future<List<Recipe>> searchRecipes(String query) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final lowercaseQuery = query.toLowerCase();
    return _mockRecipes.where((recipe) {
      return recipe.title.toLowerCase().contains(lowercaseQuery) ||
          recipe.description.toLowerCase().contains(lowercaseQuery) ||
          recipe.ingredients.any((ingredient) => ingredient.toLowerCase().contains(lowercaseQuery)) ||
          recipe.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  // Get trending recipes
  static Future<List<Recipe>> getTrendingRecipes() async {
    await Future.delayed(const Duration(milliseconds: 400));
    final sortedRecipes = List<Recipe>.from(_mockRecipes);
    sortedRecipes.sort((a, b) => b.views.compareTo(a.views));
    return sortedRecipes.take(5).toList();
  }

  // Get recent recipes
  static Future<List<Recipe>> getRecentRecipes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final sortedRecipes = List<Recipe>.from(_mockRecipes);
    sortedRecipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedRecipes.take(10).toList();
  }

  // Like a recipe
  static Future<void> likeRecipe(String recipeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // In a real app, this would update the database
    print('Recipe $recipeId liked');
  }

  // Rate a recipe
  static Future<void> rateRecipe(String recipeId, double rating) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would update the database
    print('Recipe $recipeId rated with $rating stars');
  }

  // Create a new recipe
  static Future<Recipe> createRecipe(Recipe recipe) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // In a real app, this would save to database
    final newRecipe = recipe.copyWith(
      id: (Random().nextInt(10000) + 1000).toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _mockRecipes.add(newRecipe);
    return newRecipe;
  }
}
