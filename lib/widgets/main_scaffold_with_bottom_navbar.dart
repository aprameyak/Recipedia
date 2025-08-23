import 'package:flutter/material.dart';
import 'package:cooking_app/pages/home_new.dart';
import 'package:cooking_app/pages/search_new.dart';
import 'package:cooking_app/pages/favorites.dart';
import 'package:cooking_app/pages/prof.dart';
import 'package:cooking_app/pages/post.dart';
import 'package:cooking_app/theme/app_theme.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final List<Widget>? actions;
  const MainScaffold({
    required this.body,
    required this.currentIndex,
    this.actions,
    super.key,
  });
  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const SearchPage();
        break;
      case 2:
        page = const PostPage();
        break;
      case 3:
        page = const FavoritesPage();
        break;
      case 4:
        page = const ProfilePage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("CookingApp", style: AppTheme.heading2),
        backgroundColor: AppTheme.surfaceColor,
        foregroundColor: AppTheme.textPrimary,
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _navigate(context, index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.surfaceColor,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
