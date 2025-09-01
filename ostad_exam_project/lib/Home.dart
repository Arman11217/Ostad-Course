import 'package:flutter/material.dart';

import 'data/cooking_data.dart';
import 'model/Recipe.dart';


class Home extends StatelessWidget {
  final List<Recipe> recipes = parseRecipes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipes"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text(recipe.title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(recipe.description),
          );
        },
      ),
    );
  }
}