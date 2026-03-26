import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : const Color(0xff111827);
    final subtitleColor = isDark
        ? const Color(0xffD1D5DB)
        : const Color(0xff6B7280);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 24),
              Text(
                "Creer un compte",
                style: TextStyle(
                  color: titleColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Inscrivez-vous pour enregistrer vos recettes favorites et retrouver votre univers culinaire.",
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              const _SignupField(
                label: 'Nom complet',
                hint: 'Chef Ivoirien',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              const _SignupField(
                label: 'Adresse email',
                hint: 'chef@email.com',
                icon: Icons.mail_outline,
              ),
              const SizedBox(height: 16),
              const _SignupField(
                label: 'Mot de passe',
                hint: 'Choisissez un mot de passe',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              const _SignupField(
                label: 'Confirmer le mot de passe',
                hint: 'Retapez le mot de passe',
                icon: Icons.lock_reset_outlined,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Compte cree en mode demonstration'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF6B00),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'J ai deja un compte',
                    style: TextStyle(
                      color: Color(0xffFF6B00),
                      fontWeight: FontWeight.w700,
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

class _SignupField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;

  const _SignupField({
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDark ? const Color(0xffE5E7EB) : const Color(0xff374151);
    final fillColor = isDark ? const Color(0xff1F2937) : Colors.white;
    final iconColor = isDark ? const Color(0xffD1D5DB) : const Color(0xff9CA3AF);
    final borderColor = isDark ? const Color(0xff374151) : const Color(0xffE5E7EB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: iconColor),
            prefixIcon: Icon(icon, color: iconColor),
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xffFF6B00), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
