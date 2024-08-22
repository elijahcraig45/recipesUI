import 'dart:typed_data';

import 'package:et_eats/src/features/recipes/repository/api_service.dart';
import 'package:flutter/material.dart';// Adjust the import path

class RecipeImageWidget extends StatelessWidget {
  final ApiService apiService;
  final String imageUrl;

  const RecipeImageWidget({super.key, required this.apiService, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: apiService.fetchImage(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Failed to load image');
        } else if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        } else {
          return const Text('No image data');
        }
      },
    );
  }
}
