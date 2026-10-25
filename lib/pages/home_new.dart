import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'fullPost.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> featuredRecipes = [];
  List<Recipe> trendingRecipes = [];
  List<Recipe> recentRecipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final featured = await RecipeService.getFeaturedRecipes();
      final trending = await RecipeService.getTrendingRecipes();
      final recent = await RecipeService.getRecentRecipes();

      setState(() {
        featuredRecipes = featured;
        trendingRecipes = trending;
        recentRecipes = recent;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: AppTheme.surfaceColor,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Recipedia',
                  style: AppTheme.heading2.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.1),
                        AppTheme.accentColor.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // TODO: Navigate to search page
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    // TODO: Navigate to notifications
                  },
                ),
              ],
            ),
            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Section
                    _buildWelcomeSection(),
                    const SizedBox(height: 24),
                    
                    // Featured Recipes
                    _buildSectionHeader('Featured Recipes', 'See all'),
                    const SizedBox(height: 16),
                    _buildFeaturedRecipes(),
                    const SizedBox(height: 32),
                    
                    // Quick Categories
                    _buildSectionHeader('Categories', 'Browse all'),
                    const SizedBox(height: 16),
                    _buildCategoriesGrid(),
                    const SizedBox(height: 32),
                    
                    // Trending Recipes
                    _buildSectionHeader('Trending Now', 'View all'),
                    const SizedBox(height: 16),
                    _buildRecipeList(trendingRecipes),
                    const SizedBox(height: 32),
                    
                    // Recent Recipes
                    _buildSectionHeader('Recently Added', 'See all'),
                    const SizedBox(height: 16),
                    _buildRecipeList(recentRecipes),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor,
            AppTheme.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back! 👋',
                  style: AppTheme.heading3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ready to cook something delicious today?',
                  style: AppTheme.bodyText.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.heading2,
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate to section page
          },
          child: Text(
            actionText,
            style: AppTheme.bodyText.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedRecipes() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredRecipes.length,
        itemBuilder: (context, index) {
          final recipe = featuredRecipes[index];
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            child: RecipeCard(
              recipe: recipe,
              onTap: () => _navigateToRecipeDetail(recipe),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildCategoryCard('🍰', 'Desserts', '45 recipes'),
        _buildCategoryCard('🥩', 'Proteins', '78 recipes'),
        _buildCategoryCard('🍝', 'Carbs', '62 recipes'),
        _buildCategoryCard('🥗', 'Healthy', '89 recipes'),
      ],
    );
  }

  Widget _buildCategoryCard(String emoji, String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to category page
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTheme.heading3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTheme.bodyTextSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList(List<Recipe> recipes) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          recipe: recipe,
          onTap: () => _navigateToRecipeDetail(recipe),
        );
      },
    );
  }

  void _navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullPostPage(recipe: recipe),
      ),
    );
  }
}
