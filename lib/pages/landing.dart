import 'package:flutter/material.dart';
import 'package:chef_social/widgets/main_scaffold_with_bottom_navbar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Home Page'),
            const SizedBox(height: 20),
          ],
        ),
      ),
      currentIndex: 0,
    );
  }
}
