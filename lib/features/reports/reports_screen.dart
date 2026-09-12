import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../domain/models/calculation.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/route_names.dart';
import '../../pdf/report_pdf_builder.dart';
import '../../theme/siraji_colors.dart';
import '../../theme/siraji_spacing.dart';
import '../../theme/siraji_typography.dart';
import '../../widgets/siraji_button.dart';
import '../../widgets/siraji_card.dart';
import '../../widgets/siraji_scaffold.dart';
import '../../widgets/siraji_text_field.dart';
import 'providers/reports_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportsProvider>().loadCalculations();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmDelete(BuildContext context, Calculation calc, AppLocalizations loc) async {
    final provider = context.read<ReportsProvider>();
    final messenger = ScaffoldMessenger.of(context);

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
      if (ok) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(loc.toastDeletedSuccess),
            backgroundColor: SirajiColors.success,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final provider = context.watch<ReportsProvider>();
    final calculations = provider.getFilteredCalculations();

    return SirajiScaffold(
      title: loc.navReports,
      titleIcon: Icons.assessment_outlined,
      currentNavIndex: 3,
      body: RefreshIndicator(
        onRefresh: () => provider.loadCalculations(),
        color: SirajiColors.deepGreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                  // 1. Hero Card
                  SirajiCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: SirajiColors.gold.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.receipt_long,
                                color: SirajiColors.deepGold,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: SirajiSpacing.sm),
                            Expanded(
                              child: Text(
                                loc.reportsHeader,
                                style: SirajiTypography.titleLarge.copyWith(
                                  color: SirajiColors.deepGreen,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: SirajiSpacing.xs),
                        Text(
                          loc.reportsSubtitle,
                          style: SirajiTypography.bodyMedium.copyWith(
                            color: SirajiColors.textSecondary,
                          ),
                        ),
                        if (provider.calculations.isNotEmpty) ...[
                          const SizedBox(height: SirajiSpacing.md),
                          SirajiTextField(
                            label: '',
                            hint: loc.searchReportsHint,
                            controller: _searchController,
                            prefixIcon: Icons.search,
                            suffixIcon: provider.searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, size: 18),
                                    onPressed: () {
                                      _searchController.clear();
                                      provider.clearSearch();
                                    },
                                  )
                                : null,
                            onChanged: (val) => provider.setSearchQuery(val),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.md),

                  // 2. Calculation Reports List or Empty State
                  if (provider.isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(48),
                        child: CircularProgressIndicator(color: SirajiColors.deepGreen),
                      ),
                    )
                  else if (provider.calculations.isEmpty)
                    SirajiCard(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                          child: Column(
                            children: [
                              Icon(
                                Icons.folder_open_outlined,
                                size: 56,
                                color: SirajiColors.textSecondary.withValues(alpha: 0.4),
                              ),
                              const SizedBox(height: SirajiSpacing.md),
                              Text(
                                loc.emptyReportsTitle,
                                style: SirajiTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: SirajiColors.deepGreen,
                                ),
                              ),
                              const SizedBox(height: SirajiSpacing.xs),
                              Text(
                                loc.emptyReportsDesc,
                                style: SirajiTypography.bodySmall.copyWith(
                                  color: SirajiColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: SirajiSpacing.lg),
                              SirajiButton(
                                label: loc.startFaraidCta,
                                icon: Icons.calculate_outlined,
                                onPressed: () => context.go(RouteNames.calculationFlow),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else if (calculations.isEmpty)
                    SirajiCard(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.search_off,
                                size: 48,
                                color: SirajiColors.textSecondary,
                              ),
                              const SizedBox(height: SirajiSpacing.sm),
                              Text(
                                loc.noReportsFound,
                                style: SirajiTypography.bodyMedium,
                              ),
                              const SizedBox(height: SirajiSpacing.sm),
                              TextButton(
                                onPressed: () {
                                  _searchController.clear();
                                  provider.clearSearch();
                                },
                                child: Text(loc.btnClearSearch),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    ...calculations.map(
                      (calc) => _ReportListItemCard(
                        calculation: calc,
                        languageCode: languageCode,
                        loc: loc,
                        onOpen: () => context.go('/reports/${calc.id}'),
                        onPrint: () => ReportPdfBuilder.printReport(
                          calculation: calc,
                          languageCode: languageCode,
                        ),
                        onShare: () => ReportPdfBuilder.shareReport(
                          calculation: calc,
                          languageCode: languageCode,
                        ),
                        onDelete: () => _confirmDelete(context, calc, loc),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReportListItemCard extends StatelessWidget {
  const _ReportListItemCard({
    required this.calculation,
    required this.languageCode,
    required this.loc,
    required this.onOpen,
    required this.onPrint,
    required this.onShare,
    required this.onDelete,
  });

  final Calculation calculation;
  final String languageCode;
  final AppLocalizations loc;
  final VoidCallback onOpen;
  final VoidCallback onPrint;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {};
    try {
      data = jsonDecode(calculation.dataJson) as Map<String, dynamic>;
    } catch (_) {}

    final deceasedName = data['deceasedName'] ?? calculation.title;
    final netEstate = (data['netDistributableEstate'] as num?)?.toDouble() ?? 0.0;
    final sharesCount = (data['shares'] as List<dynamic>?)?.length ?? 0;
    final dateStr = '${calculation.createdAt.day}/${calculation.createdAt.month}/${calculation.createdAt.year}';

    return Padding(
      padding: const EdgeInsets.only(bottom: SirajiSpacing.sm),
      child: SirajiCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SirajiColors.deepGreen.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    color: SirajiColors.deepGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: SirajiSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deceasedName.toString(),
                        style: SirajiTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: SirajiColors.deepGreen,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${loc.reportMetaDate}: $dateStr • ${loc.reportMetaHeirs}: $sharesCount',
                        style: SirajiTypography.bodySmall.copyWith(
                          color: SirajiColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      netEstate.toStringAsFixed(0),
                      style: SirajiTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: SirajiColors.deepGold,
                      ),
                    ),
                    Text(
                      loc.reportMetaEstate,
                      style: SirajiTypography.labelSmall.copyWith(
                        color: SirajiColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: loc.btnPrintPdf,
                  icon: const Icon(Icons.print_outlined, size: 20, color: SirajiColors.deepGreen),
                  onPressed: onPrint,
                ),
                IconButton(
                  tooltip: loc.btnSharePdf,
                  icon: const Icon(Icons.share_outlined, size: 20, color: SirajiColors.deepGreen),
                  onPressed: onShare,
                ),
                IconButton(
                  tooltip: loc.btnDeleteReport,
                  icon: const Icon(Icons.delete_outline, size: 20, color: SirajiColors.error),
                  onPressed: onDelete,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onOpen,
                  icon: const Icon(Icons.visibility_outlined, size: 16),
                  label: Text(loc.btnOpenReport),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
