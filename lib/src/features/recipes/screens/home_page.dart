import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/recipe_tile.dart';
import '../models/recipe_model.dart';
import '../repository/api_service.dart';

class HomeScreen extends StatefulWidget {
  final ApiService apiService;  // Accept ApiService as a parameter

  const HomeScreen({super.key, required this.apiService});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = widget.apiService.fetchRecipes();  // Use the passed ApiService instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Recipe>>(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found'));
          }

          final recipes = snapshot.data!;
          final screenWidth = MediaQuery.of(context).size.width;

          const double desiredTileWidth = 300;
          const double crossAxisSpacing = 12.0;
          const double mainAxisSpacing = 12.0;

          int columns =
              (screenWidth / (desiredTileWidth + crossAxisSpacing)).floor();
          if (columns < 1) columns = 1;

          double tileWidth =
              (screenWidth - (columns - 1) * crossAxisSpacing) / columns;
          double childAspectRatio = tileWidth / (tileWidth * 1.5);

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.go('/recipe/${recipes[index].id}');
                },
                child: RecipeTile(
                  recipe: recipes[index],
                  apiService: widget.apiService,  // Pass ApiService to RecipeTile
                ),
              );
            },
          );
        },
      ),
    );
  }
}
