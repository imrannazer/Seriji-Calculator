import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';

class SettingsLanguageScreen extends StatelessWidget {
  const SettingsLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    final currentCode = localeProvider.locale.languageCode;

    final languages = [
      (
        code: 'en',
        nativeName: 'English',
        englishName: 'English',
        subtitle: 'Left-to-Right (LTR)',
      ),
      (
        code: 'ur',
        nativeName: 'اردو',
        englishName: 'Urdu',
        subtitle: 'دائیں سے بائیں (RTL)',
      ),
      (
        code: 'ar',
        nativeName: 'العربية',
        englishName: 'Arabic',
        subtitle: 'من اليمين إلى اليسار (RTL)',
      ),
    ];

    return SirajiScaffold(
      title: loc.settingsLanguage,
      titleIcon: Icons.language,
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
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.languageSelectionTitle,
                        style: SirajiTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: SirajiColors.deepGreen,
                        ),
                      ),
                      const SizedBox(height: SirajiSpacing.xs),
                      Text(
                        loc.settingsLanguageDesc,
                        style: SirajiTypography.bodySmall,
                      ),
                      const SizedBox(height: SirajiSpacing.md),
                      ...languages.map(
                        (lang) => _LanguageSelectionTile(
                          code: lang.code,
                          nativeName: lang.nativeName,
                          englishName: lang.englishName,
                          subtitle: lang.subtitle,
                          isSelected: currentCode == lang.code,
                          onSelect: () {
                            localeProvider.setLocale(Locale(lang.code));
                          },
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

class _LanguageSelectionTile extends StatelessWidget {
  const _LanguageSelectionTile({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.subtitle,
    required this.isSelected,
    required this.onSelect,
  });

  final String code;
  final String nativeName;
  final String englishName;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected ? SirajiColors.gold.withValues(alpha: 0.1) : SirajiColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? SirajiColors.gold : SirajiColors.divider,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? SirajiColors.deepGreen : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? SirajiColors.deepGreen : SirajiColors.divider,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 16, color: SirajiColors.textOnDark)
                    : null,
              ),
              const SizedBox(width: SirajiSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nativeName,
                      style: SirajiTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isSelected ? SirajiColors.deepGreen : SirajiColors.textPrimary,
                      ),
                    ),
                    Text(
                      '$englishName • $subtitle',
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
    );
  }
}
