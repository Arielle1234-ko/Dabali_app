import 'package:flutter/material.dart';

import '../models/ethnic_cuisine.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'detail_screen.dart';

class EthnicCuisineDetailScreen extends StatelessWidget {
  final EthnicCuisine ethnicCuisine;
  final List<Recipe> recipes;

  const EthnicCuisineDetailScreen({
    super.key,
    required this.ethnicCuisine,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    final linkedRecipes = ethnicCuisine.recipeIds
        .map((id) => recipes.where((recipe) => recipe.id == id).toList())
        .where((matches) => matches.isNotEmpty)
        .map((matches) => matches.first)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(ethnicCuisine.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xffFF6B00), Color(0xffFF9C55)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ethnicCuisine.group,
                  style: const TextStyle(
                    color: Color(0xffFFEDD5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ethnicCuisine.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ethnicCuisine.regions.join(' • '),
                  style: const TextStyle(
                    color: Color(0xffFFF7ED),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  ethnicCuisine.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionCard(
            title: 'Apercu historique',
            child: Text(
              ethnicCuisine.historicalOverview,
              style: const TextStyle(
                color: Color(0xff4B5563),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Identite culinaire',
            child: Text(
              ethnicCuisine.culinaryIdentity,
              style: const TextStyle(
                color: Color(0xff4B5563),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Peuples et zones culturelles',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...ethnicCuisine.communities.map(
                  (community) => _ChipLabel(label: community),
                ),
                ...ethnicCuisine.regions.map(
                  (region) => _ChipLabel(label: region, subtle: true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Ingredients recurrents',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ethnicCuisine.stapleIngredients
                  .map((ingredient) => _ChipLabel(label: ingredient))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Moments culturels',
            child: Column(
              children: ethnicCuisine.culturalMoments
                  .map(
                    (moment) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.circle,
                              size: 8,
                              color: Color(0xffFF6B00),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              moment,
                              style: const TextStyle(
                                color: Color(0xff374151),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Specialites culinaires',
            child: Column(
              children: ethnicCuisine.specialties
                  .map(
                    (specialty) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Color(0xffFF6B00),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              specialty,
                              style: const TextStyle(
                                color: Color(0xff374151),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Recettes associees',
            style: TextStyle(
              color: Color(0xff111827),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (linkedRecipes.isEmpty)
            const Text(
              'Aucune recette liee pour le moment.',
              style: TextStyle(color: Color(0xff6B7280)),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: linkedRecipes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.60,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final recipe = linkedRecipes[index];
                return RecipeCard(
                  recipe: recipe,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff111827),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ChipLabel extends StatelessWidget {
  final String label;
  final bool subtle;

  const _ChipLabel({
    required this.label,
    this.subtle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: subtle ? const Color(0xffF3F4F6) : const Color(0xffFFF7ED),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: subtle ? const Color(0xff4B5563) : const Color(0xffEA580C),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
