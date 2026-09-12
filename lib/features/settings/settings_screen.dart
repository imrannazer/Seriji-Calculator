import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/providers/locale_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/route_names.dart';
import '../../theme/siraji_colors.dart';
import '../../theme/siraji_spacing.dart';
import '../../theme/siraji_typography.dart';
import '../../widgets/siraji_card.dart';
import '../../widgets/siraji_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    final currentLangCode = localeProvider.locale.languageCode;

    final currentLangLabel = switch (currentLangCode) {
      'ur' => 'اردو (Urdu)',
      'ar' => 'العربية (Arabic)',
      _ => 'English',
    };

    return SirajiScaffold(
      title: loc.navSettings,
      titleIcon: Icons.settings_outlined,
      currentNavIndex: 4,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: SirajiSpacing.pagePadding,
          right: SirajiSpacing.pagePadding,
          top: SirajiSpacing.md,
          bottom: SirajiSpacing.footerHeight + SirajiSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. General Preferences (Language)
                _SettingsSectionHeader(title: loc.settingsSectionGeneral),
                const SizedBox(height: SirajiSpacing.xs),
                SirajiCard(
                  child: _SettingsTile(
                    icon: Icons.language,
                    title: loc.settingsLanguage,
                    subtitle: currentLangLabel,
                    onTap: () => context.go(RouteNames.settingsLanguage),
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),

                // 2. Data & Privacy Management
                _SettingsSectionHeader(title: loc.settingsSectionData),
                const SizedBox(height: SirajiSpacing.xs),
                SirajiCard(
                  child: _SettingsTile(
                    icon: Icons.storage_outlined,
                    title: loc.settingsData,
                    subtitle: loc.settingsDataDesc,
                    onTap: () => context.go(RouteNames.settingsData),
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),

                // 3. Help & User Guide
                _SettingsSectionHeader(title: loc.settingsSectionHelp),
                const SizedBox(height: SirajiSpacing.xs),
                SirajiCard(
                  child: _SettingsTile(
                    icon: Icons.help_outline,
                    title: loc.settingsHelp,
                    subtitle: loc.settingsHelpDesc,
                    onTap: () => context.go(RouteNames.settingsHelp),
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),

                // 4. About & Legal
                _SettingsSectionHeader(title: loc.settingsSectionAbout),
                const SizedBox(height: SirajiSpacing.xs),
                SirajiCard(
                  child: _SettingsTile(
                    icon: Icons.info_outline,
                    title: loc.settingsAbout,
                    subtitle: loc.settingsAboutDesc,
                    onTap: () => context.go(RouteNames.settingsAbout),
                  ),
                ),
                const SizedBox(height: SirajiSpacing.xl),

                // App Branding Footer
                Center(
                  child: Column(
                    children: [
                      Text(
                        loc.appName,
                        style: SirajiTypography.titleMedium.copyWith(
                          color: SirajiColors.deepGold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        loc.appTagline,
                        style: SirajiTypography.bodySmall.copyWith(
                          color: SirajiColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  const _SettingsSectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: SirajiTypography.titleMedium.copyWith(
          fontWeight: FontWeight.w700,
          color: SirajiColors.deepGreen,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: SirajiColors.deepGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: SirajiColors.deepGreen, size: 22),
            ),
            const SizedBox(width: SirajiSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: SirajiTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: SirajiTypography.bodySmall.copyWith(
                      color: SirajiColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: SirajiColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
