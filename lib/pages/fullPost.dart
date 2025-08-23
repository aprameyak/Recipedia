import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';

class FullPostPage extends StatelessWidget {
  final Recipe recipe;
  
  const FullPostPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: AppTheme.surfaceColor,
        foregroundColor: AppTheme.textPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            if (recipe.images.isNotEmpty)
              Image.network(
                recipe.images.first,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe.title,
                          style: AppTheme.heading1,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            recipe.rating.toStringAsFixed(1),
                            style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Author and Time
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(recipe.authorAvatar),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        recipe.authorName,
                        style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        '${recipe.totalTime} min',
                        style: AppTheme.bodyTextSmall,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Description
                  Text(
                    recipe.description,
                    style: AppTheme.bodyText,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Ingredients
                  Text(
                    'Ingredients',
                    style: AppTheme.heading2,
                  ),
                  const SizedBox(height: 12),
                  ...recipe.ingredients.map((ingredient) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            ingredient,
                            style: AppTheme.bodyText,
                          ),
                        ),
                      ],
                    ),
                  )),
                  
                  const SizedBox(height: 24),
                  
                  // Instructions
                  Text(
                    'Instructions',
                    style: AppTheme.heading2,
                  ),
                  const SizedBox(height: 12),
                  ...recipe.instructions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final instruction = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: AppTheme.bodyTextSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              instruction,
                              style: AppTheme.bodyText,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
