import 'package:flutter/material.dart';

import '../models/recipe.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class ProfileScreen extends StatelessWidget {
  final List<Recipe> recipes;

  const ProfileScreen({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteCount = recipes.where((recipe) => recipe.isFavorite).length;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 36),
            decoration: const BoxDecoration(
              color: Color(0xffF97316),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    _ProfileAvatar(),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chef Ivoirien',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Amateur de bonne cuisine',
                            style: TextStyle(
                              color: Color(0xffFFEDD5),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _StatItem(
                        value: '${recipes.length}',
                        label: 'Recettes',
                      ),
                    ),
                    Expanded(
                      child: _StatItem(
                        value: '$favoriteCount',
                        label: 'Favoris',
                      ),
                    ),
                    const Expanded(
                      child: _StatItem(
                        value: '4.8',
                        label: 'Note moy.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _ProfileActionTile(
                          icon: Icons.login_rounded,
                          iconColor: const Color(0xffFF6B00),
                          backgroundColor: const Color(0xffFFEDD5),
                          title: 'Se connecter',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                        ),
                        _ProfileActionTile(
                          icon: Icons.person_add_alt_1_rounded,
                          iconColor: const Color(0xff2563EB),
                          backgroundColor: const Color(0xffDBEAFE),
                          title: "S'inscrire",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignupScreen(),
                              ),
                            );
                          },
                        ),
                        _ProfileActionTile(
                          icon: Icons.settings_outlined,
                          iconColor: const Color(0xffEA580C),
                          backgroundColor: const Color(0xffFFEDD5),
                          title: 'Parametres',
                          onTap: () => _showMessage(context, 'Parametres'),
                        ),
                        _ProfileActionTile(
                          icon: Icons.share_outlined,
                          iconColor: const Color(0xff2563EB),
                          backgroundColor: const Color(0xffDBEAFE),
                          title: "Partager l'app",
                          onTap: () => _showMessage(context, "Partager l'app"),
                        ),
                        _ProfileActionTile(
                          icon: Icons.star_outline,
                          iconColor: const Color(0xff16A34A),
                          backgroundColor: const Color(0xffDCFCE7),
                          title: "Noter l'application",
                          onTap: () =>
                              _showMessage(context, "Noter l'application"),
                        ),
                        _ProfileActionTile(
                          icon: Icons.delete_outline,
                          iconColor: const Color(0xffDC2626),
                          backgroundColor: const Color(0xffFEE2E2),
                          title: 'Effacer tous les favoris',
                          textColor: const Color(0xffDC2626),
                          trailing: false,
                          onTap: () => _showMessage(
                            context,
                            'Action de suppression non disponible',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    " dAbAli v1.0.0",
                    style: TextStyle(
                      color: Color(0xff9CA3AF),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '(c) 2026 Cuisine Ivoirienne',
                    style: TextStyle(
                      color: Color(0xff9CA3AF),
                      fontSize: 13,
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

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.restaurant_menu,
        size: 36,
        color: Color(0xffF97316),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xffFFEDD5),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final Color? textColor;
  final bool trailing;
  final VoidCallback onTap;

  const _ProfileActionTile({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.onTap,
    this.textColor,
    this.trailing = true,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTextColor = textColor ?? const Color(0xff374151);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: resolvedTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (trailing)
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xff9CA3AF),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
