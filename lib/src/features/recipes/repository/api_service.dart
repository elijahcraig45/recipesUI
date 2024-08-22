import 'dart:convert';
import 'dart:typed_data'; // For image data
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse('$baseUrl/recipes'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<Recipe> fetchRecipe(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/recipe?id=$id'));

    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  Future<Uint8List> fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse('$baseUrl/image?url=$imageUrl'));

    if (response.statusCode == 200) {
      return response.bodyBytes; // Returns the raw image data as bytes
    } else {
      throw Exception('Failed to load image');
    }
  }
}

