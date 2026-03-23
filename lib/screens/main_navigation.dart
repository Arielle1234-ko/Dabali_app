import 'package:flutter/material.dart';

import '../data/recipes_data.dart';
import '../models/recipe.dart';
import '../widgets/bottom_nav.dart';
import 'detail_screen.dart';
import 'ethnic_cuisines_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'recipes_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;
  String selectedRecipesCategory = 'Toutes';
  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
    recipes = initialRecipes.map((recipe) => recipe.copyWith()).toList();
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      if (index != 1) {
        selectedRecipesCategory = 'Toutes';
      }
    });
  }

  void openRecipesCategory(String category) {
    setState(() {
      selectedRecipesCategory = category;
      currentIndex = 1;
    });
  }

  void toggleFavorite(String recipeId) {
    setState(() {
      recipes = recipes
          .map(
            (recipe) => recipe.id == recipeId
                ? recipe.copyWith(isFavorite: !recipe.isFavorite)
                : recipe,
          )
          .toList();
    });
  }

  void openRecipe(Recipe recipe) {
    final selectedRecipe =
        recipes.firstWhere((currentRecipe) => currentRecipe.id == recipe.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          recipe: selectedRecipe,
          onFavoriteToggle: () => toggleFavorite(selectedRecipe.id),
        ),
      ),
    );
  }

  void openEthnicCuisines() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EthnicCuisinesScreen(recipes: recipes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        recipes: recipes,
        onViewAll: () => onTap(1),
        onProfileTap: () => onTap(3),
        onEthnicCuisinesTap: openEthnicCuisines,
        onToggleFavorite: toggleFavorite,
        onRecipeTap: openRecipe,
        onCategoryTap: openRecipesCategory,
      ),
      RecipesScreen(
        recipes: recipes,
        onToggleFavorite: toggleFavorite,
        onRecipeTap: openRecipe,
        initialCategory: selectedRecipesCategory,
      ),
      FavoritesScreen(
        recipes: recipes,
        onToggleFavorite: toggleFavorite,
        onRecipeTap: openRecipe,
        onExploreRecipes: () => onTap(1),
      ),
      ProfileScreen(recipes: recipes),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        favoriteCount: recipes.where((recipe) => recipe.isFavorite).length,
        onTap: onTap,
      ),
    );
  }
}
