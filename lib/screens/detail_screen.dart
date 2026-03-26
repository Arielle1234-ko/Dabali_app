import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../services/share_service.dart';

class DetailScreen extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onFavoriteToggle;

  const DetailScreen({
    super.key,
    required this.recipe,
    this.onFavoriteToggle,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool isFavorite;
  int selectedTab = 0;
  late List<bool> checkedIngredients;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.recipe.isFavorite;
    checkedIngredients = List<bool>.filled(widget.recipe.ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroSection(
                    recipe: widget.recipe,
                    isFavorite: isFavorite,
                    onBack: () => Navigator.pop(context),
                    onShareTap: () => _showShareSheet(context),
                    onFavoriteTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      widget.onFavoriteToggle?.call();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _DetailTabButton(
                                title: 'Ingredients',
                                selected: selectedTab == 0,
                                onTap: () {
                                  setState(() {
                                    selectedTab = 0;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _DetailTabButton(
                                title: 'Preparation',
                                selected: selectedTab == 1,
                                onTap: () {
                                  setState(() {
                                    selectedTab = 1;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (selectedTab == 0) ...[
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Liste des ingredients",
                                  style: TextStyle(
                                    color: Color(0xff1F2937),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    checkedIngredients = List<bool>.filled(
                                      checkedIngredients.length,
                                      true,
                                    );
                                  });
                                },
                                child: const Text(
                                  'Tout cocher',
                                  style: TextStyle(color: Color(0xffFF6B00)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...List.generate(
                            widget.recipe.ingredients.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _IngredientTile(
                                text: widget.recipe.ingredients[index],
                                value: checkedIngredients[index],
                                onChanged: (value) {
                                  setState(() {
                                    checkedIngredients[index] = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ] else ...[
                          const Text(
                            'Instructions etape par etape',
                            style: TextStyle(
                              color: Color(0xff1F2937),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...List.generate(
                            widget.recipe.steps.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _StepTile(
                                stepNumber: index + 1,
                                text: widget.recipe.steps[index],
                                isLast: index == widget.recipe.steps.length - 1,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 46,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffE5E7EB),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Partager ${widget.recipe.title}',
                  style: const TextStyle(
                    color: Color(0xff111827),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choisissez votre option de partage preferee.',
                  style: TextStyle(
                    color: Color(0xff6B7280),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                _ShareOptionTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  color: const Color(0xff25D366),
                  title: 'Partager sur WhatsApp',
                  onTap: () async {
                    Navigator.pop(bottomSheetContext);
                    await ShareService.shareToWhatsApp(context, widget.recipe);
                  },
                ),
                _ShareOptionTile(
                  icon: Icons.facebook_rounded,
                  color: const Color(0xff1877F2),
                  title: 'Partager sur Facebook',
                  onTap: () async {
                    Navigator.pop(bottomSheetContext);
                    await ShareService.shareToFacebook(context, widget.recipe);
                  },
                ),
                _ShareOptionTile(
                  icon: Icons.link_rounded,
                  color: const Color(0xffFF6B00),
                  title: 'Copier le lien',
                  onTap: () async {
                    Navigator.pop(bottomSheetContext);
                    await ShareService.copyRecipeLink(context, widget.recipe);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeroSection extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onShareTap;
  final VoidCallback onFavoriteTap;

  const _HeroSection({
    required this.recipe,
    required this.isFavorite,
    required this.onBack,
    required this.onShareTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 340,
          width: double.infinity,
          child: Image.asset(
            recipe.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xffFFE8D9),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 64,
                  color: Color(0xffFF6B00),
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.45),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.55),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 44,
          left: 16,
          right: 16,
          child: Row(
            children: [
              _CircleActionButton(
                icon: Icons.arrow_back,
                onTap: onBack,
              ),
              const Spacer(),
              _CircleActionButton(
                icon: Icons.share_outlined,
                onTap: onShareTap,
              ),
              const SizedBox(width: 10),
              _CircleActionButton(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? const Color(0xffEF4444) : const Color(0xff374151),
                onTap: onFavoriteTap,
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0x1AFF6B00),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  recipe.category,
                  style: const TextStyle(
                    color: Color(0xffFFB67A),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                recipe.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _MetaItem(
                    icon: Icons.schedule,
                    text: '${recipe.time} min',
                  ),
                  _MetaItem(
                    icon: Icons.people_outline,
                    text: '${recipe.servings} pers.',
                  ),
                  _MetaItem(
                    icon: Icons.local_fire_department_outlined,
                    text: recipe.difficulty,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const _CircleActionButton({
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.9),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: color ?? const Color(0xff1F2937),
          ),
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.white70),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _DetailTabButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _DetailTabButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? const Color(0xffFF6B00) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: selected ? const Color(0xffFF6B00) : const Color(0xff6B7280),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _IngredientTile extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _IngredientTile({
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xffFF6B00),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xff374151),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final int stepNumber;
  final String text;
  final bool isLast;

  const _StepTile({
    required this.stepNumber,
    required this.text,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xffFF6B00),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$stepNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: const Color(0xffE5E7EB),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xff374151),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareOptionTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  const _ShareOptionTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xff111827),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xff9CA3AF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
