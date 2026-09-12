import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/calculation_repository_impl.dart';
import '../../domain/models/calculation.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/route_names.dart';
import '../../theme/siraji_colors.dart';
import '../../theme/siraji_spacing.dart';
import '../../theme/siraji_typography.dart';
import '../../widgets/siraji_button.dart';
import '../../widgets/siraji_card.dart';
import '../../widgets/siraji_scaffold.dart';
import 'providers/calculation_flow_provider.dart';

class CalculationsScreen extends StatefulWidget {
  const CalculationsScreen({super.key});

  @override
  State<CalculationsScreen> createState() => _CalculationsScreenState();
}

class _CalculationsScreenState extends State<CalculationsScreen> {
  List<Calculation> _savedCalculations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final repo = context.read<CalculationRepositoryImpl?>();
    if (repo != null) {
      final res = await repo.getAllCalculations();
      if (mounted && res.isSuccess) {
        setState(() {
          _savedCalculations = res.valueOrNull ?? [];
          _isLoading = false;
        });
        return;
      }
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final flowProvider = context.read<CalculationFlowProvider>();

    return SirajiScaffold(
      title: loc.navCalculations,
      titleIcon: Icons.calculate_outlined,
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
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.calculationsHeader,
                        style: SirajiTypography.headlineMedium.copyWith(
                          color: SirajiColors.deepGreen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: SirajiSpacing.xs),
                      Text(
                        loc.calculationsIntro,
                        style: SirajiTypography.bodyMedium.copyWith(
                          color: SirajiColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: SirajiSpacing.lg),
                      SirajiButton(
                        label: loc.startFaraidCta,
                        icon: Icons.add,
                        fullWidth: true,
                        onPressed: () {
                          flowProvider.reset();
                          context.go(RouteNames.calculationFlow);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),
                Text(
                  loc.recentCalculations,
                  style: SirajiTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: SirajiSpacing.sm),
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(color: SirajiColors.deepGreen),
                    ),
                  )
                else if (_savedCalculations.isEmpty)
                  SirajiCard(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.history,
                              size: 40,
                              color: SirajiColors.textSecondary.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: SirajiSpacing.sm),
                            Text(
                              loc.noCalculationsYet,
                              style: SirajiTypography.bodySmall.copyWith(
                                color: SirajiColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  ..._savedCalculations.map((calc) => _SavedCalculationCard(calc: calc)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SavedCalculationCard extends StatelessWidget {
  const _SavedCalculationCard({required this.calc});
  final Calculation calc;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {};
    try {
      data = jsonDecode(calc.dataJson) as Map<String, dynamic>;
    } catch (_) {}

    final deceasedName = data['deceasedName'] ?? calc.title;
    final netEstate = data['netDistributableEstate'] ?? 0.0;
    final dateStr = '${calc.createdAt.day}/${calc.createdAt.month}/${calc.createdAt.year}';

    return Padding(
      padding: const EdgeInsets.only(bottom: SirajiSpacing.sm),
      child: SirajiCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: SirajiColors.gold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.receipt_long, color: SirajiColors.deepGold),
            ),
            const SizedBox(width: SirajiSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deceasedName.toString(),
                    style: SirajiTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Net: ${netEstate.toString()} • $dateStr',
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
    );
  }
}
