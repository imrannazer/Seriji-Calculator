import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/calculation_repository_impl.dart';
import '../../../domain/models/share.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';
import '../providers/calculation_flow_provider.dart';

class CalculationResultScreen extends StatelessWidget {
  const CalculationResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final provider = context.watch<CalculationFlowProvider>();
    final result = provider.result;

    if (result == null) {
      return SirajiScaffold(
        title: loc.resultTitle,
        titleIcon: Icons.calculate_outlined,
        currentNavIndex: 1,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.noCalculationsYet,
                style: SirajiTypography.bodyMedium,
              ),
              const SizedBox(height: SirajiSpacing.md),
              SirajiButton(
                label: loc.btnBackToCalculations,
                onPressed: () => context.go(RouteNames.calculations),
              ),
            ],
          ),
        ),
      );
    }

    final repo = context.read<CalculationRepositoryImpl?>();

    return SirajiScaffold(
      title: loc.resultTitle,
      titleIcon: Icons.assessment_outlined,
      currentNavIndex: 1,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: SirajiSpacing.pagePadding,
          right: SirajiSpacing.pagePadding,
          top: SirajiSpacing.md,
          bottom: SirajiSpacing.footerHeight + SirajiSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(SirajiSpacing.md),
                  decoration: BoxDecoration(
                    gradient: SirajiColors.headerGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: SirajiColors.darkGreen.withValues(alpha: 0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: SirajiColors.gold.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle_outline, color: SirajiColors.gold, size: 28),
                      ),
                      const SizedBox(width: SirajiSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.estate.deceasedName,
                              style: SirajiTypography.titleLarge.copyWith(
                                color: SirajiColors.gold,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${loc.netDistributableEstate}: ${result.estate.netDistributableValue.toStringAsFixed(0)}',
                              style: SirajiTypography.bodySmall.copyWith(
                                color: SirajiColors.textOnDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.resultEstateSummary,
                        style: SirajiTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: SirajiColors.deepGreen,
                        ),
                      ),
                      const Divider(height: 20),
                      _SummaryRow(label: loc.resultGrossValue, value: provider.grossAssets.toStringAsFixed(0)),
                      if (provider.debts > 0)
                        _SummaryRow(label: loc.fieldDebts, value: '- ${provider.debts.toStringAsFixed(0)}', isDeduction: true),
                      if (provider.funeralExpenses > 0)
                        _SummaryRow(label: loc.fieldFuneral, value: '- ${provider.funeralExpenses.toStringAsFixed(0)}', isDeduction: true),
                      if (provider.bequestAmount > 0)
                        _SummaryRow(label: loc.fieldBequest, value: '- ${provider.bequestAmount.toStringAsFixed(0)}', isDeduction: true),
                      const Divider(height: 20),
                      _SummaryRow(
                        label: loc.resultNetEstate,
                        value: result.estate.netDistributableValue.toStringAsFixed(0),
                        isHighlight: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.resultHeirsBreakdown,
                        style: SirajiTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: SirajiColors.deepGreen,
                        ),
                      ),
                      const SizedBox(height: SirajiSpacing.md),
                      ...result.shares.map((share) => _ShareCardItem(share: share, loc: loc)),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.menu_book, color: SirajiColors.deepGold, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            loc.resultExplanationTitle,
                            style: SirajiTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: SirajiColors.deepGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SirajiSpacing.sm),
                      ...result.shares.where((s) => s.explanation != null && s.explanation!.isNotEmpty).map(
                            (s) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('• ', style: TextStyle(color: SirajiColors.gold, fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      '${s.heirId.toUpperCase()}: ${s.explanation!}',
                                      style: SirajiTypography.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),
                Container(
                  padding: const EdgeInsets.all(SirajiSpacing.md),
                  decoration: BoxDecoration(
                    color: SirajiColors.gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: SirajiColors.gold),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, color: SirajiColors.deepGold, size: 22),
                      const SizedBox(width: SirajiSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.resultDisclaimerTitle,
                              style: SirajiTypography.labelLarge.copyWith(
                                fontWeight: FontWeight.w700,
                                color: SirajiColors.deepGreen,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              loc.resultDisclaimerText,
                              style: SirajiTypography.bodySmall.copyWith(
                                color: SirajiColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: SirajiButton(
                        label: provider.isSaved ? loc.toastSavedSuccess : loc.btnSaveCalculation,
                        icon: provider.isSaved ? Icons.check : Icons.save_alt,
                        isLoading: provider.isSaving,
                        isEnabled: !provider.isSaved && repo != null,
                        variant: SirajiButtonVariant.primary,
                        onPressed: repo == null
                            ? null
                            : () async {
                                final messenger = ScaffoldMessenger.of(context);
                                final ok = await provider.saveCalculation(repo);
                                if (ok) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(loc.toastSavedSuccess),
                                      backgroundColor: SirajiColors.success,
                                    ),
                                  );
                                }
                              },
                      ),
                    ),
                    const SizedBox(width: SirajiSpacing.sm),
                    Expanded(
                      child: SirajiButton(
                        label: loc.btnNewCalculation,
                        icon: Icons.refresh,
                        variant: SirajiButtonVariant.secondary,
                        onPressed: () {
                          provider.reset();
                          context.go(RouteNames.calculationFlow);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SirajiSpacing.sm),
                SirajiButton(
                  label: loc.btnBackToCalculations,
                  variant: SirajiButtonVariant.text,
                  fullWidth: true,
                  onPressed: () => context.go(RouteNames.calculations),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isDeduction = false,
    this.isHighlight = false,
  });

  final String label;
  final String value;
  final bool isDeduction;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isHighlight
                ? SirajiTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)
                : SirajiTypography.bodyMedium,
          ),
          Text(
            value,
            style: isHighlight
                ? SirajiTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: SirajiColors.deepGold,
                  )
                : SirajiTypography.bodyMedium.copyWith(
                    color: isDeduction ? SirajiColors.error : SirajiColors.textPrimary,
                    fontWeight: isDeduction ? FontWeight.w600 : FontWeight.w400,
                  ),
          ),
        ],
      ),
    );
  }
}

class _ShareCardItem extends StatelessWidget {
  const _ShareCardItem({required this.share, required this.loc});
  final Share share;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final isExcluded = share.shareType == ShareType.excluded;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isExcluded
            ? SirajiColors.divider.withValues(alpha: 0.15)
            : SirajiColors.gold.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isExcluded ? SirajiColors.divider : SirajiColors.gold.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isExcluded ? SirajiColors.divider : SirajiColors.gold.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isExcluded ? Icons.block : Icons.person,
              size: 18,
              color: isExcluded ? SirajiColors.textSecondary : SirajiColors.deepGold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      share.heirId.toUpperCase(),
                      style: SirajiTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isExcluded ? SirajiColors.textSecondary : SirajiColors.deepGreen,
                      ),
                    ),
                    if (share.count > 1) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: SirajiColors.deepGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'x${share.count}',
                          style: const TextStyle(color: SirajiColors.textOnDark, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  isExcluded ? (share.explanation ?? 'Excluded') : '${share.shareType.name.toUpperCase()} • ${share.percentageString}',
                  style: SirajiTypography.bodySmall.copyWith(
                    color: isExcluded ? SirajiColors.textSecondary : SirajiColors.deepGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (!isExcluded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  share.amount.toStringAsFixed(0),
                  style: SirajiTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: SirajiColors.deepGreen,
                  ),
                ),
                if (share.count > 1)
                  Text(
                    '${loc.resultTablePerPerson}: ${share.individualAmount.toStringAsFixed(0)}',
                    style: SirajiTypography.labelSmall.copyWith(
                      color: SirajiColors.textSecondary,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
