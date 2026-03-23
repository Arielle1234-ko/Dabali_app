import 'package:flutter/material.dart';

import '../models/recipe.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final ValueChanged<String> onToggleFavorite;
  final ValueChanged<Recipe> onRecipeTap;
  final VoidCallback onExploreRecipes;

  const FavoritesScreen({
    super.key,
    required this.recipes,
    required this.onToggleFavorite,
    required this.onRecipeTap,
    required this.onExploreRecipes,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes =
        recipes.where((recipe) => recipe.isFavorite).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE5E7EB),
                ),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mes Favoris',
                  style: TextStyle(
                    color: Color(0xff1F2937),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Vos recettes sauvegardées',
                  style: TextStyle(
                    color: Color(0xff6B7280),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: favoriteRecipes.isEmpty
                ? _EmptyFavoritesState(
                    onExploreRecipes: onExploreRecipes,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: favoriteRecipes.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final recipe = favoriteRecipes[index];
                      return _FavoriteListTile(
                        recipe: recipe,
                        onTap: () => onRecipeTap(recipe),
                        onDelete: () => onToggleFavorite(recipe.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteListTile extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _FavoriteListTile({
    required this.recipe,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.05),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 92,
                  height: 92,
                  child: Image.asset(
                    recipe.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xffFFE8D9),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.restaurant_menu,
                          color: Color(0xffFF6B00),
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF7ED),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        recipe.category,
                        style: const TextStyle(
                          color: Color(0xffFF6B00),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff1F2937),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${recipe.time} min',
                      style: const TextStyle(
                        color: Color(0xff6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: const Color(0xffFEF2F2),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onDelete,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete_outline,
                      color: Color(0xffDC2626),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyFavoritesState extends StatelessWidget {
  final VoidCallback onExploreRecipes;

  const _EmptyFavoritesState({
    required this.onExploreRecipes,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: Color(0xffFFEDD5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 48,
                color: Color(0xffFDBA74),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Aucun favori',
              style: TextStyle(
                color: Color(0xff1F2937),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ajoutez des recettes a vos favoris pour les retrouver ici',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff6B7280),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onExploreRecipes,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF97316),
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Explorer les recettes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
