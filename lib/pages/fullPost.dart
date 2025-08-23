import 'package:flutter/material.dart';

class FullPostPage extends StatelessWidget {
  const FullPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Post'),
      ),
      body: const Center(
        child: Text(
          'Full Post Details',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
