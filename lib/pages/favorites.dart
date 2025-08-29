import 'package:flutter/material.dart';
import 'package:chef_social/widgets/main_scaffold_with_bottom_navbar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Favorites Page'),
            const SizedBox(height: 20),
          ],
        ),
      ),
      currentIndex: 3,
    );
  }
}
