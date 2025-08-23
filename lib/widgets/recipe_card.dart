import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  final bool showAuthor;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.showAuthor = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.network(
                    recipe.images.isNotEmpty ? recipe.images.first : '',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: AppTheme.backgroundColor,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: AppTheme.backgroundColor,
                      child: const Icon(
                        Icons.restaurant,
                        size: 50,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                  // Difficulty Badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(recipe.difficulty).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        recipe.difficulty,
                        style: AppTheme.bodyTextSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Time Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.totalTime}min',
                            style: AppTheme.bodyTextSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Recipe Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    recipe.title,
                    style: AppTheme.heading3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    recipe.description,
                    style: AppTheme.bodyTextSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Author and Stats Row
                  Row(
                    children: [
                      if (showAuthor) ...[
                        // Author Avatar
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(recipe.authorAvatar),
                          onBackgroundImageError: (exception, stackTrace) => const Icon(Icons.person),
                        ),
                        const SizedBox(width: 8),
                        // Author Name
                        Expanded(
                          child: Text(
                            recipe.authorName,
                            style: AppTheme.bodyTextSmall.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ] else ...[
                        const Spacer(),
                      ],
                      // Rating
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            recipe.rating.toStringAsFixed(1),
                            style: AppTheme.bodyTextSmall.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Likes
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            size: 16,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.likes}',
                            style: AppTheme.bodyTextSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Tags
                  if (recipe.tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: recipe.tags.take(3).map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tag,
                          style: AppTheme.bodyTextSmall.copyWith(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
