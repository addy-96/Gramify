import 'package:flutter/material.dart';

void onLanguageSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 1, // Full screen height
        minChildSize: 0.5, // Minimum height when dragged down
        maxChildSize: 1, // Maximum height
        expand: true,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: ListView(
              controller:
                  scrollController, // Enables scrolling inside the sheet
              children: const [
                Text('Yet To implement', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Text('-'),
              ],
            ),
          );
        },
      );
    },
  );
}
