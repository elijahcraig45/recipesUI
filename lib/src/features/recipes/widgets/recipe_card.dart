import 'package:et_eats/src/features/recipes/repository/api_service.dart';
import 'package:et_eats/src/features/recipes/widgets/recipe_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/recipe_model.dart';


class RecipeCard extends StatelessWidget {
  final String recipeId;  // Instead of Recipe, we'll use the recipe ID
  final ApiService apiService;

  const RecipeCard({super.key, required this.recipeId, required this.apiService});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 800;

    return Scaffold(
      body: FutureBuilder<Recipe>(
        future: apiService.fetchRecipe(recipeId),  // Fetch the recipe by ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Recipe not found'));
          }

          final recipe = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.go("/");
                          },
                          icon: const Icon(Icons.navigate_before_rounded, color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            recipe.title,
                            style: const TextStyle(
                              fontSize: 26.0, 
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    
                        ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(40.0),
            ),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                maxWidth: 500,
                maxHeight: 500,
              ),
              child: RecipeImageWidget(
                          apiService: apiService,
                          imageUrl: recipe.imageUrl,
                        ),
            ),
          ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: recipe.tags.map((tag) => Chip(label: Text(tag))).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        recipe.description,
                        style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(thickness: 1.0, height: 32.0),
                    if (isWideScreen)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ingredients',
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16.0),
                                ...recipe.ingredients
                                    .map((ingredient) => Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text(
                                            '- $ingredient',
                                            style: const TextStyle(fontSize: 16.0),
                                          ),
                                        ))
                                    ,
                              ],
                            ),
                          ),
                          const SizedBox(width: 64.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Steps',
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16.0),
                                ...recipe.steps
                                    .map((step) => Padding(
                                          padding: const EdgeInsets.only(bottom: 16.0),
                                          child: Text(
                                            '${recipe.steps.indexOf(step) + 1}. $step',
                                            style: const TextStyle(fontSize: 16.0),
                                          ),
                                        ))
                                    ,
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          ...recipe.ingredients
                              .map((ingredient) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      '- $ingredient',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ))
                              ,
                          const SizedBox(height: 32.0),
                          const Divider(thickness: 1.0, height: 32.0),
                          const Text(
                            'Steps',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          ...recipe.steps
                              .map((step) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: Text(
                                      '${recipe.steps.indexOf(step) + 1}. $step',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ))
                              ,
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
