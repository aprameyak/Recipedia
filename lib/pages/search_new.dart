import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'fullPost.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> searchResults = [];
  List<RecipeCategory> categories = [];
  bool isLoading = false;
  String selectedCategory = '';
  String selectedDifficulty = '';
  String selectedTimeFilter = '';

  final List<String> difficulties = ['Easy', 'Medium', 'Hard'];
  final List<String> timeFilters = ['Under 15 min', '15-30 min', '30-60 min', 'Over 60 min'];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final cats = await RecipeService.getAllCategories();
      setState(() {
        categories = cats;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _performSearch() async {
    if (_searchController.text.trim().isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final results = await RecipeService.searchRecipes(_searchController.text.trim());
      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterByCategory(String category) {
    setState(() {
      selectedCategory = selectedCategory == category ? '' : category;
    });
    _applyFilters();
  }

  void _filterByDifficulty(String difficulty) {
    setState(() {
      selectedDifficulty = selectedDifficulty == difficulty ? '' : difficulty;
    });
    _applyFilters();
  }

  void _filterByTime(String timeFilter) {
    setState(() {
      selectedTimeFilter = selectedTimeFilter == timeFilter ? '' : timeFilter;
    });
    _applyFilters();
  }

  void _applyFilters() {
    // In a real app, this would apply filters to the search results
    // For now, we'll just trigger a new search
    _performSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Search App Bar
          SliverAppBar(
            pinned: true,
            backgroundColor: AppTheme.surfaceColor,
            elevation: 0,
            title: Text(
              'Search Recipes',
              style: AppTheme.heading2.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          // Search Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  _buildSearchBar(),
                  const SizedBox(height: 24),
                  
                  // Categories
                  _buildCategoriesSection(),
                  const SizedBox(height: 24),
                  
                  // Filters
                  _buildFiltersSection(),
                  const SizedBox(height: 24),
                  
                  // Search Results
                  _buildSearchResults(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for recipes, ingredients, or tags...',
          hintStyle: AppTheme.bodyTextSmall.copyWith(
            color: AppTheme.textSecondary,
          ),
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppTheme.textSecondary),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            _performSearch();
          }
        },
        onSubmitted: (value) => _performSearch(),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: AppTheme.heading2,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category.name;
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => _filterByCategory(category.name),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppTheme.primaryColor : AppTheme.textLight,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          category.icon,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category.name,
                          style: AppTheme.bodyTextSmall.copyWith(
                            color: isSelected ? Colors.white : AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filters',
          style: AppTheme.heading2,
        ),
        const SizedBox(height: 12),
        
        // Difficulty Filter
        Text(
          'Difficulty',
          style: AppTheme.heading3,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: difficulties.map((difficulty) {
            final isSelected = selectedDifficulty == difficulty;
            return FilterChip(
              label: Text(difficulty),
              selected: isSelected,
              onSelected: (selected) => _filterByDifficulty(difficulty),
              backgroundColor: AppTheme.surfaceColor,
              selectedColor: AppTheme.primaryColor.withOpacity(0.2),
              labelStyle: AppTheme.bodyTextSmall.copyWith(
                color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
        
        const SizedBox(height: 16),
        
        // Time Filter
        Text(
          'Cooking Time',
          style: AppTheme.heading3,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: timeFilters.map((timeFilter) {
            final isSelected = selectedTimeFilter == timeFilter;
            return FilterChip(
              label: Text(timeFilter),
              selected: isSelected,
              onSelected: (selected) => _filterByTime(timeFilter),
              backgroundColor: AppTheme.surfaceColor,
              selectedColor: AppTheme.primaryColor.withOpacity(0.2),
              labelStyle: AppTheme.bodyTextSmall.copyWith(
                color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_searchController.text.trim().isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Searches',
            style: AppTheme.heading2,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Chocolate Chip Cookies',
              'Grilled Chicken',
              'Pasta',
              'Salad',
              'Pizza',
              'Smoothie',
            ].map((searchTerm) => ActionChip(
              label: Text(searchTerm),
              onPressed: () {
                _searchController.text = searchTerm;
                _performSearch();
              },
              backgroundColor: AppTheme.surfaceColor,
              labelStyle: AppTheme.bodyTextSmall,
            )).toList(),
          ),
        ],
      );
    }

    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: AppTheme.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'No recipes found',
                style: AppTheme.heading3.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your search terms or filters',
                style: AppTheme.bodyTextSmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results (${searchResults.length})',
          style: AppTheme.heading2,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final recipe = searchResults[index];
            return RecipeCard(
              recipe: recipe,
              onTap: () => _navigateToRecipeDetail(recipe),
            );
          },
        ),
      ],
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
