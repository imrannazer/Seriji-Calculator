import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_config.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';

class SettingsAboutScreen extends StatelessWidget {
  const SettingsAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return SirajiScaffold(
      title: loc.aboutTitle,
      titleIcon: Icons.info_outline,
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
                // 1. App Logo & Version Card
                SirajiCard(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SirajiColors.goldGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: SirajiColors.gold.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.auto_stories, color: SirajiColors.darkGreen, size: 32),
                          ),
                          const SizedBox(height: SirajiSpacing.sm),
                          Text(
                            AppConfig.appName,
                            style: SirajiTypography.headlineMedium.copyWith(
                              color: SirajiColors.deepGreen,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            loc.appTagline,
                            style: SirajiTypography.bodySmall.copyWith(
                              color: SirajiColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: SirajiSpacing.md),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                            decoration: BoxDecoration(
                              color: SirajiColors.deepGreen.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: SirajiColors.divider),
                            ),
                            child: Text(
                              '${loc.aboutVersion} ${AppConfig.version} (${loc.aboutBuild} ${AppConfig.buildNumber})',
                              style: SirajiTypography.labelSmall.copyWith(
                                color: SirajiColors.deepGreen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 2. Jurisprudential Sources
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.library_books, color: SirajiColors.deepGold, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            loc.aboutSourcesTitle,
                            style: SirajiTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: SirajiColors.deepGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SirajiSpacing.xs),
                      Text(
                        loc.aboutSourcesText,
                        style: SirajiTypography.bodyMedium.copyWith(
                          color: SirajiColors.textPrimary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 3. Legal & Religious Disclaimer
                Container(
                  padding: const EdgeInsets.all(SirajiSpacing.md),
                  decoration: BoxDecoration(
                    color: SirajiColors.gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: SirajiColors.gold),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.shield_outlined, color: SirajiColors.deepGold, size: 24),
                      const SizedBox(width: SirajiSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.aboutDisclaimerTitle,
                              style: SirajiTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: SirajiColors.deepGreen,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              loc.aboutDisclaimerText,
                              style: SirajiTypography.bodySmall.copyWith(
                                color: SirajiColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),
                SirajiButton(
                  label: loc.btnBack,
                  variant: SirajiButtonVariant.secondary,
                  fullWidth: true,
                  onPressed: () => context.go(RouteNames.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
