import 'package:flutter/material.dart';

class PostOverview extends StatelessWidget {
  const PostOverview({super.key, required this.postMap});

  final Map<String, String> postMap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: postMap.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final entry = postMap.entries.elementAt(index);
        final imageUrl = entry.value;
        return Container(
          padding: const EdgeInsets.all(4),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) => const Icon(Icons.error),
          ),
        );
      },
    );
  }
}
