import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipedia/widgets/main_scaffold_with_bottom_navbar.dart';
import 'package:recipedia/auth/auth.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _formKey = GlobalKey<FormState>();
  final _recipeController = TextEditingController();
  final _initImageController = TextEditingController();
  final _captionController = TextEditingController();
  final userID = Auth().userID;

  final List<TextEditingController> _followUpControllers = [
    TextEditingController(),
  ];

  void _addFollowUpField() {
    setState(() {
      _followUpControllers.add(TextEditingController());
    });
  }

  void _removeFollowUpField(int index) {
    setState(() {
      _followUpControllers.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final now = DateTime.now().toUtc();
      // final formattedTime = DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(now);

      // Construct the payload for backend submission
      // final payload = {
      //   'recipe': _recipeController.text,
      //   'initRecipeImage': _initImageController.text,
      //   'allImageFollowUpsToCompare': _followUpControllers
      //       .map((c) => c.text)
      //       .where((s) => s.isNotEmpty)
      //       .toList(),
      //   'timeStamp': formattedTime,
      //   'caption': _captionController.text,
      // };
      if (userID == null) {
        print("Not logged in");
      }
      // add backend here

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Post submitted!")));

      // clear form
      _recipeController.clear();
      _initImageController.clear();
      _captionController.clear();
      for (final c in _followUpControllers) {
        c.clear();
      }
    }
  }

  @override
  void dispose() {
    _recipeController.dispose();
    _initImageController.dispose();
    _captionController.dispose();
    for (final c in _followUpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: Scaffold(
          appBar: AppBar(title: const Text('Create Post')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _recipeController,
                    decoration: const InputDecoration(labelText: 'Recipe Name'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter a recipe'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _initImageController,
                    decoration: const InputDecoration(
                      labelText: 'Main Image URL',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter an image URL'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  const Text("Other Images"),
                  ..._followUpControllers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final controller = entry.value;
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Image URL ${index + 1}',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: _followUpControllers.length > 1
                              ? () => _removeFollowUpField(index)
                              : null,
                        ),
                      ],
                    );
                  }),
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Add Another Image"),
                    onPressed: _addFollowUpField,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _captionController,
                    decoration: const InputDecoration(labelText: 'Recipe'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text("Submit Post"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      currentIndex: 2,
    );
  }
}
