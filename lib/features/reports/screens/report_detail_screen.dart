import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/calculation.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../pdf/report_pdf_builder.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';
import '../providers/reports_provider.dart';

class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key, required this.reportId});

  final String reportId;

  Future<void> _confirmDelete(BuildContext context, Calculation calc, AppLocalizations loc) async {
    final provider = context.read<ReportsProvider>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: SirajiColors.error, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                loc.dialogDeleteTitle,
                style: SirajiTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SirajiColors.deepGreen,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          loc.dialogDeleteMessage,
          style: SirajiTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(loc.dialogDeleteCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SirajiColors.error,
              foregroundColor: SirajiColors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(loc.dialogDeleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final ok = await provider.deleteCalculation(calc.id);
      if (ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.toastDeletedSuccess),
            backgroundColor: SirajiColors.success,
          ),
        );
        context.go(RouteNames.reports);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final provider = context.watch<ReportsProvider>();
    final calculation = provider.getCalculationById(reportId);

    if (calculation == null) {
      return SirajiScaffold(
        title: loc.reportDetailsTitle,
        titleIcon: Icons.assessment_outlined,
        currentNavIndex: 3,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: SirajiColors.error),
              const SizedBox(height: SirajiSpacing.md),
              Text(
                loc.noReportsFound,
                style: SirajiTypography.titleMedium,
              ),
              const SizedBox(height: SirajiSpacing.md),
              SirajiButton(
                label: loc.btnBack,
                onPressed: () => context.go(RouteNames.reports),
              ),
            ],
          ),
        ),
      );
    }

    Map<String, dynamic> data = {};
    try {
      data = jsonDecode(calculation.dataJson) as Map<String, dynamic>;
    } catch (_) {}

    final deceasedName = data['deceasedName'] ?? calculation.title;
    final grossAssets = (data['grossAssets'] as num?)?.toDouble() ?? 0.0;
    final debts = (data['debts'] as num?)?.toDouble() ?? 0.0;
    final funeral = (data['funeralExpenses'] as num?)?.toDouble() ?? 0.0;
    final bequest = (data['bequestAmount'] as num?)?.toDouble() ?? 0.0;
    final netEstate = (data['netDistributableEstate'] as num?)?.toDouble() ?? 0.0;
    final sharesList = (data['shares'] as List<dynamic>?) ?? [];
    final dateStr = '${calculation.createdAt.day}/${calculation.createdAt.month}/${calculation.createdAt.year}';

    return SirajiScaffold(
      title: loc.reportDetailsTitle,
      titleIcon: Icons.assessment_outlined,
      currentNavIndex: 3,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: SirajiSpacing.pagePadding,
          right: SirajiSpacing.pagePadding,
          top: SirajiSpacing.md,
          bottom: SirajiSpacing.footerHeight + SirajiSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Report Header Banner
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
                        child: const Icon(Icons.description, color: SirajiColors.gold, size: 28),
                      ),
                      const SizedBox(width: SirajiSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deceasedName.toString(),
                              style: SirajiTypography.titleLarge.copyWith(
                                color: SirajiColors.gold,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${loc.reportMetaDate}: $dateStr • ${loc.netDistributableEstate}: ${netEstate.toStringAsFixed(0)}',
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

                // 2. Estate Summary Card
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
                      _DetailRow(label: loc.resultGrossValue, value: grossAssets.toStringAsFixed(0)),
                      if (debts > 0)
                        _DetailRow(label: loc.fieldDebts, value: '- ${debts.toStringAsFixed(0)}', isDeduction: true),
                      if (funeral > 0)
                        _DetailRow(label: loc.fieldFuneral, value: '- ${funeral.toStringAsFixed(0)}', isDeduction: true),
                      if (bequest > 0)
                        _DetailRow(label: loc.fieldBequest, value: '- ${bequest.toStringAsFixed(0)}', isDeduction: true),
                      const Divider(height: 20),
                      _DetailRow(
                        label: loc.resultNetEstate,
                        value: netEstate.toStringAsFixed(0),
                        isHighlight: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 3. Heirs Breakdown
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
                      ...sharesList.map((item) {
                        final map = item as Map<String, dynamic>;
                        final heirId = (map['heirId'] as String?)?.toUpperCase() ?? '';
                        final fraction = map['fraction']?.toString() ?? '';
                        final percentage = map['percentage']?.toString() ?? '';
                        final amount = (map['amount'] as num?)?.toDouble() ?? 0.0;
                        final count = int.tryParse(map['count']?.toString() ?? '1') ?? 1;
                        final type = map['type']?.toString() ?? 'fixed';
                        final indivAmount = count > 0 ? amount / count : amount;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: SirajiColors.gold.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: SirajiColors.gold.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: SirajiColors.gold.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person, size: 18, color: SirajiColors.deepGold),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          heirId,
                                          style: SirajiTypography.titleMedium.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: SirajiColors.deepGreen,
                                          ),
                                        ),
                                        if (count > 1) ...[
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                            decoration: BoxDecoration(
                                              color: SirajiColors.deepGreen,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'x$count',
                                              style: const TextStyle(
                                                color: SirajiColors.textOnDark,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      '$type • $fraction ($percentage)',
                                      style: SirajiTypography.bodySmall.copyWith(
                                        color: SirajiColors.deepGold,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    amount.toStringAsFixed(0),
                                    style: SirajiTypography.titleMedium.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: SirajiColors.deepGreen,
                                    ),
                                  ),
                                  if (count > 1)
                                    Text(
                                      '${loc.resultTablePerPerson}: ${indivAmount.toStringAsFixed(0)}',
                                      style: SirajiTypography.labelSmall.copyWith(
                                        color: SirajiColors.textSecondary,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 4. Disclaimer Box
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
                        child: Text(
                          loc.resultDisclaimerText,
                          style: SirajiTypography.bodySmall.copyWith(
                            color: SirajiColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),

                // 5. Action Buttons (Print, Share, Delete)
                Row(
                  children: [
                    Expanded(
                      child: SirajiButton(
                        label: loc.btnPrintPdf,
                        icon: Icons.print,
                        onPressed: () => ReportPdfBuilder.printReport(
                          calculation: calculation,
                          languageCode: languageCode,
                        ),
                      ),
                    ),
                    const SizedBox(width: SirajiSpacing.sm),
                    Expanded(
                      child: SirajiButton(
                        label: loc.btnSharePdf,
                        icon: Icons.share,
                        variant: SirajiButtonVariant.secondary,
                        onPressed: () => ReportPdfBuilder.shareReport(
                          calculation: calculation,
                          languageCode: languageCode,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SirajiSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: SirajiButton(
                        label: loc.btnDeleteReport,
                        icon: Icons.delete_outline,
                        variant: SirajiButtonVariant.text,
                        onPressed: () => _confirmDelete(context, calculation, loc),
                      ),
                    ),
                    const SizedBox(width: SirajiSpacing.sm),
                    Expanded(
                      child: SirajiButton(
                        label: loc.btnBack,
                        variant: SirajiButtonVariant.text,
                        onPressed: () => context.go(RouteNames.reports),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
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
