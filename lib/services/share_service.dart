import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/recipe.dart';

class ShareService {
  static Future<void> copyCustomText(
    BuildContext context,
    String text, {
    required String successMessage,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(successMessage),
      ),
    );
  }

  static String recipeLink(Recipe recipe) {
    return 'https://odabali.app/recipes/${recipe.id}';
  }

  static String recipeMessage(Recipe recipe) {
    return "Decouvre ${recipe.title} sur O'dAbAli : ${recipeLink(recipe)}";
  }

  static Future<void> shareToWhatsApp(BuildContext context, Recipe recipe) async {
    final uri = Uri.parse(
      'https://wa.me/?text=${Uri.encodeComponent(recipeMessage(recipe))}',
    );
    await _launchOrNotify(context, uri);
  }

  static Future<void> shareToFacebook(BuildContext context, Recipe recipe) async {
    final uri = Uri.parse(
      'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(recipeLink(recipe))}&quote=${Uri.encodeComponent(recipe.title)}',
    );
    await _launchOrNotify(context, uri);
  }

  static Future<void> copyRecipeLink(BuildContext context, Recipe recipe) async {
    await Clipboard.setData(
      ClipboardData(text: recipeLink(recipe)),
    );

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lien de la recette copie'),
      ),
    );
  }

  static Future<void> _launchOrNotify(
    BuildContext context,
    Uri uri,
  ) async {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (launched || !context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Impossible de lancer le partage sur cet appareil'),
      ),
    );
  }
}
