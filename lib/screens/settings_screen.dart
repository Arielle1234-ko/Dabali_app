import 'package:flutter/material.dart';

import '../widgets/app_scope.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final themeMode = controller.themeMode;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : const Color(0xff111827);
    final subtitleColor = isDark
        ? const Color(0xffD1D5DB)
        : const Color(0xff6B7280);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xff111827) : Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Parametres',
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          _SectionTitle(
            title: 'Apparence',
            subtitle: "Choisissez l'ambiance visuelle de l'application.",
            titleColor: titleColor,
            subtitleColor: subtitleColor,
          ),
          const SizedBox(height: 12),
          _Card(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _ChoiceChipTile(
                  label: 'Systeme',
                  selected: themeMode == ThemeMode.system,
                  onSelected: () => controller.updateThemeMode(ThemeMode.system),
                ),
                _ChoiceChipTile(
                  label: 'Clair',
                  selected: themeMode == ThemeMode.light,
                  onSelected: () => controller.updateThemeMode(ThemeMode.light),
                ),
                _ChoiceChipTile(
                  label: 'Sombre',
                  selected: themeMode == ThemeMode.dark,
                  onSelected: () => controller.updateThemeMode(ThemeMode.dark),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle(
            title: 'Preferences',
            subtitle: 'Personnalisez la langue, les unites et les alertes.',
            titleColor: titleColor,
            subtitleColor: subtitleColor,
          ),
          const SizedBox(height: 12),
          _Card(
            child: Column(
              children: [
                _SettingsDropdown(
                  icon: Icons.language_rounded,
                  title: 'Langue',
                  value: controller.language,
                  items: const ['Francais', 'English'],
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateLanguage(value);
                    }
                  },
                ),
                const Divider(height: 24),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  secondary: const _LeadingIcon(
                    icon: Icons.notifications_active_outlined,
                  ),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Recevoir les nouveautes et suggestions culinaires.',
                    style: TextStyle(color: subtitleColor),
                  ),
                  activeThumbColor: const Color(0xffFF6B00),
                  activeTrackColor: const Color(0xffFED7AA),
                  value: controller.notificationsEnabled,
                  onChanged: controller.updateNotifications,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ChoiceChipTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _ChoiceChipTile({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: const Color(0xffFFEDD5),
      labelStyle: TextStyle(
        color: selected
            ? const Color(0xffC2410C)
            : isDark
            ? const Color(0xffE5E7EB)
            : const Color(0xff4B5563),
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: selected ? const Color(0xffFDBA74) : const Color(0xffE5E7EB),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}

class _SettingsDropdown extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _SettingsDropdown({
    required this.icon,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : const Color(0xff111827);

    return Row(
      children: [
        _LeadingIcon(icon: icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: value,
                  dropdownColor:
                      isDark ? const Color(0xff1F2937) : Colors.white,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xff9CA3AF),
                  ),
                  items: items
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  final IconData icon;

  const _LeadingIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xffFFF7ED),
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: Color(0xffFF6B00),
      ),
    );
  }
}
