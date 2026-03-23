import 'package:flutter/material.dart';

import '../data/ethnic_cuisines_data.dart';
import '../models/ethnic_cuisine.dart';
import '../models/recipe.dart';
import 'ethnic_cuisine_detail_screen.dart';

class EthnicCuisinesScreen extends StatelessWidget {
  final List<Recipe> recipes;

  const EthnicCuisinesScreen({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Cuisine par ethnie'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: ethnicCuisines.length,
        separatorBuilder: (context, index) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final ethnicCuisine = ethnicCuisines[index];
          return _EthnicCuisineCard(
            ethnicCuisine: ethnicCuisine,
            recipeCount: ethnicCuisine.recipeIds
                .where((id) => recipes.any((recipe) => recipe.id == id))
                .length,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EthnicCuisineDetailScreen(
                    ethnicCuisine: ethnicCuisine,
                    recipes: recipes,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _EthnicCuisineCard extends StatelessWidget {
  final EthnicCuisine ethnicCuisine;
  final int recipeCount;
  final VoidCallback onTap;

  const _EthnicCuisineCard({
    required this.ethnicCuisine,
    required this.recipeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.05),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xffFF6B00), Color(0xffFF9C55)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      ethnicCuisine.name.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ethnicCuisine.name,
                          style: const TextStyle(
                            color: Color(0xff111827),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ethnicCuisine.regions.join(', '),
                          style: const TextStyle(
                            color: Color(0xff6B7280),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Color(0xff9CA3AF)),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                ethnicCuisine.description,
                style: const TextStyle(
                  color: Color(0xff4B5563),
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Peuples: ${ethnicCuisine.communities.join(', ')}',
                style: const TextStyle(
                  color: Color(0xff6B7280),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...ethnicCuisine.specialties.map(
                    (specialty) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF7ED),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        specialty,
                        style: const TextStyle(
                          color: Color(0xffEA580C),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                '$recipeCount recette${recipeCount > 1 ? 's' : ''} associee${recipeCount > 1 ? 's' : ''}',
                style: const TextStyle(
                  color: Color(0xffFF6B00),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
