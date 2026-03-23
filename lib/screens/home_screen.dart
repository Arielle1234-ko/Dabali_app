import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final VoidCallback onViewAll;
  final VoidCallback onProfileTap;
  final ValueChanged<String> onToggleFavorite;
  final ValueChanged<Recipe> onRecipeTap;
  final ValueChanged<String> onCategoryTap;

  const HomeScreen({
    super.key,
    required this.recipes,
    required this.onViewAll,
    required this.onProfileTap,
    required this.onToggleFavorite,
    required this.onRecipeTap,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final categoryCount = <String, int>{};
    for (final recipe in recipes) {
      categoryCount[recipe.category] =
          (categoryCount[recipe.category] ?? 0) + 1;
    }

    final categories = [
      _CategoryData(
        name: 'Plats Principaux',
        category: 'Plats',
        icon: Icons.restaurant,
        colors: const [Color(0xffFF6B00), Color(0xffFF8533)],
        count: categoryCount['Plats'] ?? 0,
      ),
      _CategoryData(
        name: 'Entrees',
        category: 'Entrees',
        icon: Icons.lunch_dining,
        colors: const [Color(0xff10B981), Color(0xff34D399)],
        count: categoryCount['Entrees'] ?? 0,
      ),
      _CategoryData(
        name: 'Desserts',
        category: 'Desserts',
        icon: Icons.cake,
        colors: const [Color(0xffF59E0B), Color(0xffFBBF24)],
        count: categoryCount['Desserts'] ?? 0,
      ),
      _CategoryData(
        name: 'Boissons',
        category: 'Boissons',
        icon: Icons.local_drink,
        colors: const [Color(0xff3B82F6), Color(0xff60A5FA)],
        count: categoryCount['Boissons'] ?? 0,
      ),
    ].where((category) => category.count > 0).toList();

    final popularRecipes = recipes.take(4).toList();
    final favoriteCount = recipes.where((recipe) => recipe.isFavorite).length;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xffFF6B00),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                "A'",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "dAbAli",
              style: TextStyle(
                color: Color(0xff1F2937),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: onProfileTap,
            icon: const Icon(Icons.person_outline, color: Color(0xff4B5563)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffFF6B00),
                    Color(0xffFF8533),
                    Color(0xffFFA64D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: 0.08,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            backgroundBlendMode: BlendMode.srcOver,
                          ),
                          child: CustomPaint(painter: _DotPatternPainter()),
                        ),
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Decouvrez la Cote d'Ivoire",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Explorez les saveurs authentiques de la cuisine ivoirienne',
                        style: TextStyle(
                          color: Color(0xffFFEDD5),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: Color(0xffFFEDD5),
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Plus de 50 recettes traditionnelles',
                            style: TextStyle(
                              color: Color(0xffFFEDD5),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (categories.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        color: Color(0xff1F2937),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.12,
                          ),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return _CategoryCard(
                          category: category,
                          onTap: () => onCategoryTap(category.category),
                        );
                      },
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Recettes Populaires',
                      style: TextStyle(
                        color: Color(0xff1F2937),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onViewAll,
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(
                        color: Color(0xffFF6B00),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 266,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: popularRecipes.length,
                separatorBuilder: (context, index) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final recipe = popularRecipes[index];
                  return SizedBox(
                    width: 180,
                    child: RecipeCard(
                      recipe: recipe,
                      onTap: () => onRecipeTap(recipe),
                      onFavoriteToggle: () => onToggleFavorite(recipe.id),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffFFF7ED),
                  border: Border.all(color: const Color(0xffFED7AA)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xffFF6B00),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        favoriteCount > 0
                            ? "Vous avez $favoriteCount recette${favoriteCount > 1 ? 's' : ''} favorite${favoriteCount > 1 ? 's' : ''}. Gardez-les sous la main pour cuisiner plus vite."
                            : "Pour un attieke parfait, rincez-le a l'eau tiede et essorez-le bien avant de le rechauffer.",
                        style: const TextStyle(
                          color: Color(0xff4B5563),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _CategoryData category;
  final VoidCallback onTap;

  const _CategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: category.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: category.colors.first.withOpacity(0.28),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(category.icon, color: Colors.white, size: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${category.count} recette${category.count > 1 ? 's' : ''}',
                    style: const TextStyle(
                      color: Color(0xffFEF3C7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryData {
  final String name;
  final String category;
  final IconData icon;
  final List<Color> colors;
  final int count;

  const _CategoryData({
    required this.name,
    required this.category,
    required this.icon,
    required this.colors,
    required this.count,
  });
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 20.0;
    final paint = Paint()..color = Colors.white;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
