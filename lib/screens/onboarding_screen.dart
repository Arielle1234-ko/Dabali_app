import 'package:flutter/material.dart';

import 'main_navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingContent> _pages = const [
    _OnboardingContent(
      title: "Bienvenue sur O'dAbAli",
      description:
          "Decouvrez des recettes, explorez des cuisines variees et retrouvez facilement vos plats preferes.",
      icon: Icons.ramen_dining_rounded,
      accentColor: Color(0xffFF6B00),
    ),
    _OnboardingContent(
      title: "Une application simple et gourmande",
      description:
          "Consultez les details des recettes, inspirez-vous au quotidien et connectez-vous pour personnaliser votre experience.",
      icon: Icons.auto_awesome_rounded,
      accentColor: Color(0xff10B981),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(),
      ),
    );
  }

  void _goToNextPage() {
    if (_currentPage == _pages.length - 1) {
      _finishOnboarding();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _goToPreviousPage() {
    if (_currentPage == 0) return;

    _pageController.previousPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _skipOnboarding() {
    _finishOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff111827) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: const Text(
                    'Passer',
                    style: TextStyle(
                      color: Color(0xffFF6B00),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return _OnboardingPage(
                      currentPage: _currentPage,
                      pageCount: _pages.length,
                      title: page.title,
                      description: page.description,
                      icon: page.icon,
                      accentColor: page.accentColor,
                    );
                  },
                ),
              ),
              Row(
                children: [
                  if (_currentPage == 1)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _goToPreviousPage,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xff374151),
                          side: const BorderSide(color: Color(0xffD1D5DB)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text(
                          'Retour',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  else
                    const Spacer(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _goToNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF6B00),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: Text(
                        _currentPage == _pages.length - 1 ? 'Continuer' : 'Suivant',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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

class _OnboardingPage extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  const _OnboardingPage({
    required this.currentPage,
    required this.pageCount,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _OnboardingIllustration(
            icon: icon,
            accentColor: accentColor,
          ),
          const SizedBox(height: 28),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xff111827),
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    isDark ? const Color(0xffD1D5DB) : const Color(0xff6B7280),
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pageCount,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _PageIndicator(
                  isActive: index == currentPage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: isActive ? 30 : 10,
      height: isActive ? 12 : 10,
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
                colors: [Color(0xffFF6B00), Color(0xffFF9C55)],
              )
            : null,
        color: isActive ? null : const Color(0xffE5E7EB),
        borderRadius: BorderRadius.circular(999),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xffFF6B00).withValues(alpha: 0.24),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
    );
  }
}

class _OnboardingContent {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  const _OnboardingContent({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });
}

class _OnboardingIllustration extends StatelessWidget {
  final IconData icon;
  final Color accentColor;

  const _OnboardingIllustration({
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 22,
            left: 18,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 18,
            right: 20,
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: 248,
            height: 248,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColor.withValues(alpha: 0.16),
                  const Color(0xffFFF7ED),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          Container(
            width: 156,
            height: 156,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(44),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.24),
                  blurRadius: 26,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  icon,
                  color: Colors.white,
                  size: 72,
                );
              },
            ),
          ),
          Positioned(
            top: 34,
            right: 28,
            child: _FloatingIcon(
              icon: Icons.favorite_rounded,
              color: accentColor,
            ),
          ),
          Positioned(
            bottom: 34,
            left: 28,
            child: _FloatingIcon(
              icon: icon,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _FloatingIcon({
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: color),
    );
  }
}
