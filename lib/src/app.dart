import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/recipes/repository/api_service.dart';
import 'features/recipes/widgets/recipe_card.dart';
import 'features/recipes/screens/home_page.dart';
import 'package:et_eats/src/features/scaffold_with_app_bar/widgets/scaffold_with_app_bar.dart';

class MyApp extends StatelessWidget {
  // Initialize ApiService first
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8080');

  // Initialize the router after ApiService
  MyApp({super.key});

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ScaffoldWithAppBar(
          title: 'Recipes',
          body: HomeScreen(apiService: apiService),  // Pass the ApiService to HomeScreen
        ),
      ),
      GoRoute(
        path: '/recipe/:id',
        builder: (context, state) {
          final recipeId = state.pathParameters['id']!;

          return ScaffoldWithAppBar(
            title: 'Recipe Details',  // Add title for the details page
            body: RecipeCard(recipeId: recipeId, apiService: apiService),  // Pass the recipeId and ApiService to RecipeCard
            showBackButton: true,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,  // Remove the debug banner
    );
  }
}
