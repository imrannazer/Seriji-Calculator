import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/providers/locale_provider.dart';
import '../../navigation/route_names.dart';
import '../../theme/siraji_colors.dart';
import '../../theme/siraji_spacing.dart';
import '../../theme/siraji_typography.dart';
import '../../widgets/siraji_button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedCode = 'en';

  final List<_LanguageOption> _options = const [
    _LanguageOption(
        code: 'ur', nativeName: 'اردو', englishName: 'Urdu', isRTL: true),
    _LanguageOption(
        code: 'en', nativeName: 'English', englishName: 'English', isRTL: false),
    _LanguageOption(
        code: 'ar', nativeName: 'العربية', englishName: 'Arabic', isRTL: true),
  ];

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.read<LocaleProvider>();

    return Scaffold(
      backgroundColor: SirajiColors.deepGreen,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(gradient: SirajiColors.splashGradient),
            ),
            Padding(
              padding: const EdgeInsets.all(SirajiSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'زبان منتخب کریں',
                    style: SirajiTypography.urduDisplay.copyWith(
                      color: SirajiColors.gold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.xs),
                  Text(
                    'Select Language / اختر اللغة',
                    style: SirajiTypography.bodyMedium.copyWith(
                      color: SirajiColors.textOnDark.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.xxl),
                  ..._options.map(
                    (opt) => _LanguageCard(
                      option: opt,
                      isSelected: _selectedCode == opt.code,
                      onTap: () {
                        setState(() => _selectedCode = opt.code);
                        localeProvider.setLanguageCode(opt.code);
                      },
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.xl),
                  SirajiButton(
                    label: 'Continue / جاری رکھیں / متابعة',
                    onPressed: () {
                      localeProvider.setLanguageCode(_selectedCode);
                      context.go(RouteNames.home);
                    },
                    fullWidth: true,
                    variant: SirajiButtonVariant.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption {
  const _LanguageOption({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.isRTL,
  });
  final String code;
  final String nativeName;
  final String englishName;
  final bool isRTL;
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });
  final _LanguageOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: SirajiSpacing.md),
        padding: const EdgeInsets.symmetric(
            horizontal: SirajiSpacing.lg, vertical: SirajiSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? SirajiColors.gold.withValues(alpha: 0.15)
              : SirajiColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? SirajiColors.gold
                : SirajiColors.textOnDark.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? SirajiColors.gold : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? SirajiColors.gold
                      : SirajiColors.textOnDark.withValues(alpha: 0.4),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check,
                      size: 14, color: SirajiColors.darkGreen)
                  : null,
            ),
            const SizedBox(width: SirajiSpacing.md),
            Expanded(
              child: Directionality(
                textDirection:
                    option.isRTL ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  crossAxisAlignment: option.isRTL
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.nativeName,
                      style: (option.code == 'ur'
                              ? SirajiTypography.urduBody
                              : option.code == 'ar'
                                  ? SirajiTypography.arabicHeadline
                                  : SirajiTypography.titleMedium)
                          .copyWith(
                        color: isSelected
                            ? SirajiColors.gold
                            : SirajiColors.textOnDark,
                      ),
                    ),
                    Text(
                      option.englishName,
                      style: SirajiTypography.bodySmall.copyWith(
                        color: SirajiColors.textOnDark.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
