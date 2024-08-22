import 'package:et_eats/src/features/recipes/repository/api_service.dart';
import 'package:et_eats/src/features/recipes/widgets/recipe_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/recipe_model.dart';


class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  final ApiService apiService;  // Add ApiService as a parameter

  const RecipeTile({super.key, required this.recipe, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double fontSize = 14;
          int maxLines = 2;

          if (constraints.maxWidth < 150) {
            fontSize = 12;
            maxLines = 1;
          } else if (constraints.maxWidth > 200) {
            fontSize = 16;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: AspectRatio(
                  aspectRatio: 1, // Square image
                  child: RecipeImageWidget(  // Replace Image.network with RecipeImageWidget
                    apiService: apiService,
                    imageUrl: recipe.imageUrl,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 2.0,
                  children: recipe.tags
                      .take(3) // Show up to 3 tags for compactness
                      .map(
                        (tag) => Chip(
                          label: Text(
                            tag,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: AutoSizeText(
                  recipe.description,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: maxLines,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
