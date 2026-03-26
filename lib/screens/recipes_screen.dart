import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class RecipesScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final ValueChanged<String> onToggleFavorite;
  final ValueChanged<Recipe> onRecipeTap;
  final String initialCategory;

  const RecipesScreen({
    super.key,
    required this.recipes,
    required this.onToggleFavorite,
    required this.onRecipeTap,
    this.initialCategory = 'Toutes',
  });

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late String selectedCategory;
  String query = '';
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    _controller = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant RecipesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCategory != oldWidget.initialCategory &&
        widget.initialCategory != selectedCategory) {
      setState(() {
        selectedCategory = widget.initialCategory;
        query = '';
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xff1F2937) : Colors.white;
    final inputColor = isDark ? const Color(0xff111827) : const Color(0xffF3F4F6);

    const preferredOrder = ['Plats', 'Entrees', 'Desserts', 'Boissons'];
    final availableCategories = {
      for (final recipe in widget.recipes) recipe.category,
    };
    final orderedCategories = [
      ...preferredOrder.where(availableCategories.contains),
      ...availableCategories.where((category) => !preferredOrder.contains(category)),
    ];
    final categories = ['Toutes', ...orderedCategories];

    final filteredRecipes = widget.recipes.where((recipe) {
      final matchesCategory =
          selectedCategory == 'Toutes' || recipe.category == selectedCategory;
      final normalizedQuery = query.trim().toLowerCase();
      final matchesQuery =
          normalizedQuery.isEmpty ||
          recipe.title.toLowerCase().contains(normalizedQuery) ||
          recipe.subtitle.toLowerCase().contains(normalizedQuery) ||
          recipe.ingredients.any(
            (ingredient) => ingredient.toLowerCase().contains(normalizedQuery),
          );

      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 12),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: inputColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Rechercher une recette...',
                      hintStyle: TextStyle(color: Color(0xff9CA3AF)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xff9CA3AF),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == selectedCategory;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                            query = '';
                            _controller.clear();
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xffFF6B00)
                                : surfaceColor,
                            borderRadius: BorderRadius.circular(999),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: isDark
                                        ? const Color(0xff374151)
                                        : const Color(0xffE5E7EB),
                                  ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xff4B5563),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredRecipes.isEmpty
                ? _NoResultsState(
                    onReset: () {
                      setState(() {
                        selectedCategory = 'Toutes';
                        query = '';
                        _controller.clear();
                      });
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: filteredRecipes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.60,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return RecipeCard(
                        recipe: recipe,
                        onTap: () => widget.onRecipeTap(recipe),
                        onFavoriteToggle: () =>
                            widget.onToggleFavorite(recipe.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _NoResultsState extends StatelessWidget {
  final VoidCallback onReset;

  const _NoResultsState({
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Color(0xffD1D5DB),
            ),
            const SizedBox(height: 12),
            const Text(
              'Aucune recette trouvee',
              style: TextStyle(
                color: Color(0xff4B5563),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: onReset,
              child: const Text(
                'Voir toutes les recettes',
                style: TextStyle(
                  color: Color(0xffFF6B00),
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
