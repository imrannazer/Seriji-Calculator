import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/relationship.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';
import '../../../widgets/siraji_text_field.dart';
import '../providers/calculation_flow_provider.dart';
import '../widgets/heir_counter_tile.dart';
import '../widgets/step_progress_indicator.dart';

class CalculationFlowScreen extends StatefulWidget {
  const CalculationFlowScreen({super.key});

  @override
  State<CalculationFlowScreen> createState() => _CalculationFlowScreenState();
}

class _CalculationFlowScreenState extends State<CalculationFlowScreen> {
  final _grossController = TextEditingController();
  final _debtsController = TextEditingController();
  final _funeralController = TextEditingController();
  final _bequestController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<CalculationFlowProvider>();
    if (provider.grossAssets > 0) {
      _grossController.text = provider.grossAssets.toStringAsFixed(0);
    }
    if (provider.debts > 0) {
      _debtsController.text = provider.debts.toStringAsFixed(0);
    }
    if (provider.funeralExpenses > 0) {
      _funeralController.text = provider.funeralExpenses.toStringAsFixed(0);
    }
    if (provider.bequestAmount > 0) {
      _bequestController.text = provider.bequestAmount.toStringAsFixed(0);
    }
    _nameController.text = provider.deceasedName;
  }

  @override
  void dispose() {
    _grossController.dispose();
    _debtsController.dispose();
    _funeralController.dispose();
    _bequestController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _syncEstate(CalculationFlowProvider provider) {
    final gross = double.tryParse(_grossController.text.trim()) ?? 0.0;
    final debts = double.tryParse(_debtsController.text.trim()) ?? 0.0;
    final funeral = double.tryParse(_funeralController.text.trim()) ?? 0.0;
    final bequest = double.tryParse(_bequestController.text.trim()) ?? 0.0;
    provider.setEstateInfo(
      grossAssets: gross,
      debts: debts,
      funeralExpenses: funeral,
      bequestAmount: bequest,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final provider = context.watch<CalculationFlowProvider>();
    final step = provider.currentStep;

    final stepLabels = [
      loc.stepEstateTitle,
      loc.stepDeceasedTitle,
      loc.stepHeirsTitle,
      loc.stepReviewTitle,
    ];

    String stepHeaderTitle;
    switch (step) {
      case 0:
        stepHeaderTitle = loc.stepEstateTitle;
        break;
      case 1:
        stepHeaderTitle = loc.stepDeceasedTitle;
        break;
      case 2:
        stepHeaderTitle = loc.stepHeirsTitle;
        break;
      case 3:
      default:
        stepHeaderTitle = loc.stepReviewTitle;
        break;
    }

    return SirajiScaffold(
      title: stepHeaderTitle,
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
                StepProgressIndicator(
                  currentStep: step,
                  steps: stepLabels,
                ),
                const SizedBox(height: SirajiSpacing.md),
                if (step == 0)
                  _buildEstateStep(context, provider, loc)
                else if (step == 1)
                  _buildDeceasedStep(context, provider, loc)
                else if (step == 2)
                  _buildHeirsStep(context, provider, loc)
                else
                  _buildReviewStep(context, provider, loc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ──────────────── STEP 0: ESTATE ────────────────
  Widget _buildEstateStep(
    BuildContext context,
    CalculationFlowProvider provider,
    AppLocalizations loc,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SirajiCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.stepEstateTitle,
                style: SirajiTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SirajiColors.deepGreen,
                ),
              ),
              const SizedBox(height: SirajiSpacing.xs),
              Text(
                loc.appSubtitle,
                style: SirajiTypography.bodySmall,
              ),
              const SizedBox(height: SirajiSpacing.lg),
              SirajiTextField(
                label: loc.fieldGrossAssets,
                hint: loc.fieldGrossAssetsHint,
                controller: _grossController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.account_balance_wallet_outlined,
                onChanged: (_) => _syncEstate(provider),
              ),
              const SizedBox(height: SirajiSpacing.md),
              SirajiTextField(
                label: loc.fieldDebts,
                hint: loc.fieldDebtsHint,
                controller: _debtsController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.receipt_long_outlined,
                onChanged: (_) => _syncEstate(provider),
              ),
              const SizedBox(height: SirajiSpacing.md),
              SirajiTextField(
                label: loc.fieldFuneral,
                hint: loc.fieldFuneralHint,
                controller: _funeralController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.local_florist_outlined,
                onChanged: (_) => _syncEstate(provider),
              ),
              const SizedBox(height: SirajiSpacing.md),
              SirajiTextField(
                label: loc.fieldBequest,
                hint: loc.fieldBequestHint,
                controller: _bequestController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.history_edu_outlined,
                onChanged: (_) => _syncEstate(provider),
              ),
              const Divider(height: 32),
              Container(
                padding: const EdgeInsets.all(SirajiSpacing.md),
                decoration: BoxDecoration(
                  color: SirajiColors.deepGreen.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: SirajiColors.gold.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.netDistributableEstate,
                      style: SirajiTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: SirajiColors.deepGreen,
                      ),
                    ),
                    Text(
                      provider.netDistributableEstate.toStringAsFixed(0),
                      style: SirajiTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: SirajiColors.deepGold,
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
          label: loc.btnNext,
          icon: Icons.arrow_forward,
          fullWidth: true,
          onPressed: () {
            _syncEstate(provider);
            if (provider.grossAssets <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(loc.valEstateValueRequired),
                  backgroundColor: SirajiColors.error,
                ),
              );
              return;
            }
            if ((provider.debts + provider.funeralExpenses) > provider.grossAssets) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(loc.valDebtsExceedEstate),
                  backgroundColor: SirajiColors.error,
                ),
              );
              return;
            }
            provider.nextStep();
          },
        ),
      ],
    );
  }

  // ──────────────── STEP 1: DECEASED ────────────────
  Widget _buildDeceasedStep(
    BuildContext context,
    CalculationFlowProvider provider,
    AppLocalizations loc,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SirajiCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.stepDeceasedTitle,
                style: SirajiTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SirajiColors.deepGreen,
                ),
              ),
              const SizedBox(height: SirajiSpacing.lg),
              SirajiTextField(
                label: loc.fieldDeceasedName,
                hint: loc.fieldDeceasedNameHint,
                controller: _nameController,
                prefixIcon: Icons.person_outline,
                onChanged: (val) {
                  provider.setDeceasedInfo(
                    name: val,
                    gender: provider.deceasedGender,
                    maritalStatus: provider.maritalStatus,
                  );
                },
              ),
              const SizedBox(height: SirajiSpacing.lg),
              Text(
                loc.fieldDeceasedGender,
                style: SirajiTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: SirajiSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: _SelectableCard(
                      label: loc.genderMale,
                      icon: Icons.man,
                      isSelected: provider.deceasedGender == Gender.male,
                      onTap: () {
                        provider.setDeceasedInfo(
                          name: _nameController.text,
                          gender: Gender.male,
                          maritalStatus: provider.maritalStatus,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: SirajiSpacing.sm),
                  Expanded(
                    child: _SelectableCard(
                      label: loc.genderFemale,
                      icon: Icons.woman,
                      isSelected: provider.deceasedGender == Gender.female,
                      onTap: () {
                        provider.setDeceasedInfo(
                          name: _nameController.text,
                          gender: Gender.female,
                          maritalStatus: provider.maritalStatus,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SirajiSpacing.lg),
              Text(
                loc.fieldMaritalStatus,
                style: SirajiTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: SirajiSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: _SelectableCard(
                      label: loc.maritalMarried,
                      isSelected: provider.maritalStatus == 'married',
                      onTap: () {
                        provider.setDeceasedInfo(
                          name: _nameController.text,
                          gender: provider.deceasedGender,
                          maritalStatus: 'married',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: SirajiSpacing.xs),
                  Expanded(
                    child: _SelectableCard(
                      label: loc.maritalSingle,
                      isSelected: provider.maritalStatus == 'single',
                      onTap: () {
                        provider.setDeceasedInfo(
                          name: _nameController.text,
                          gender: provider.deceasedGender,
                          maritalStatus: 'single',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: SirajiSpacing.xs),
                  Expanded(
                    child: _SelectableCard(
                      label: loc.maritalWidowed,
                      isSelected: provider.maritalStatus == 'widowed',
                      onTap: () {
                        provider.setDeceasedInfo(
                          name: _nameController.text,
                          gender: provider.deceasedGender,
                          maritalStatus: 'widowed',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: SirajiSpacing.lg),
        Row(
          children: [
            Expanded(
              child: SirajiButton(
                label: loc.btnBack,
                variant: SirajiButtonVariant.secondary,
                onPressed: () => provider.previousStep(),
              ),
            ),
            const SizedBox(width: SirajiSpacing.md),
            Expanded(
              child: SirajiButton(
                label: loc.btnNext,
                icon: Icons.arrow_forward,
                onPressed: () {
                  if (_nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(loc.valDeceasedNameRequired),
                        backgroundColor: SirajiColors.error,
                      ),
                    );
                    return;
                  }
                  provider.nextStep();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ──────────────── STEP 2: HEIRS ────────────────
  Widget _buildHeirsStep(
    BuildContext context,
    CalculationFlowProvider provider,
    AppLocalizations loc,
  ) {
    final isDeceasedMale = provider.deceasedGender == Gender.male;

    final primaryHeirs = [
      if (isDeceasedMale)
        (rel: Relationship.wife, title: loc.heirWife, max: 4)
      else
        (rel: Relationship.husband, title: loc.heirHusband, max: 1),
      (rel: Relationship.son, title: loc.heirSon, max: null),
      (rel: Relationship.daughter, title: loc.heirDaughter, max: null),
      (rel: Relationship.father, title: loc.heirFather, max: 1),
      (rel: Relationship.mother, title: loc.heirMother, max: 1),
    ];

    final secondaryHeirs = [
      (rel: Relationship.grandfather, title: loc.heirGrandfather, max: 1),
      (rel: Relationship.grandmother, title: loc.heirGrandmother, max: 1),
      (rel: Relationship.maternalGrandmother, title: loc.heirMaternalGrandmother, max: 1),
      (rel: Relationship.grandson, title: loc.heirGrandson, max: null),
      (rel: Relationship.granddaughter, title: loc.heirGranddaughter, max: null),
      (rel: Relationship.fullBrother, title: loc.heirFullBrother, max: null),
      (rel: Relationship.fullSister, title: loc.heirFullSister, max: null),
      (rel: Relationship.paternalHalfBrother, title: loc.heirPaternalHalfBrother, max: null),
      (rel: Relationship.paternalHalfSister, title: loc.heirPaternalHalfSister, max: null),
      (rel: Relationship.maternalHalfBrother, title: loc.heirMaternalHalfBrother, max: null),
      (rel: Relationship.maternalHalfSister, title: loc.heirMaternalHalfSister, max: null),
      (rel: Relationship.paternalUncle, title: loc.heirPaternalUncle, max: null),
      (rel: Relationship.paternalUnclesSon, title: loc.heirPaternalUnclesSon, max: null),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Primary Heirs
        Text(
          loc.heirsPrimarySection,
          style: SirajiTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: SirajiColors.deepGreen,
          ),
        ),
        const SizedBox(height: SirajiSpacing.sm),
        ...primaryHeirs.map(
          (h) => HeirCounterTile(
            title: h.title,
            count: provider.getHeirCount(h.rel),
            maxCount: h.max,
            onIncrement: () => provider.incrementHeir(h.rel),
            onDecrement: () => provider.decrementHeir(h.rel),
          ),
        ),
        const SizedBox(height: SirajiSpacing.lg),

        // Secondary Heirs Accordion / Section
        Text(
          loc.heirsSecondarySection,
          style: SirajiTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: SirajiColors.deepGreen,
          ),
        ),
        const SizedBox(height: SirajiSpacing.sm),
        ...secondaryHeirs.map(
          (h) => HeirCounterTile(
            title: h.title,
            count: provider.getHeirCount(h.rel),
            maxCount: h.max,
            onIncrement: () => provider.incrementHeir(h.rel),
            onDecrement: () => provider.decrementHeir(h.rel),
          ),
        ),
        const SizedBox(height: SirajiSpacing.lg),
        Row(
          children: [
            Expanded(
              child: SirajiButton(
                label: loc.btnBack,
                variant: SirajiButtonVariant.secondary,
                onPressed: () => provider.previousStep(),
              ),
            ),
            const SizedBox(width: SirajiSpacing.md),
            Expanded(
              child: SirajiButton(
                label: loc.btnNext,
                icon: Icons.arrow_forward,
                onPressed: () {
                  if (provider.totalHeirCount == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(loc.valAtLeastOneHeir),
                        backgroundColor: SirajiColors.error,
                      ),
                    );
                    return;
                  }
                  provider.nextStep();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ──────────────── STEP 3: REVIEW ────────────────
  Widget _buildReviewStep(
    BuildContext context,
    CalculationFlowProvider provider,
    AppLocalizations loc,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SirajiCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.stepDeceasedTitle,
                    style: SirajiTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: SirajiColors.deepGreen,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => provider.setStep(1),
                    icon: const Icon(Icons.edit, size: 16),
                    label: Text(loc.btnEdit),
                  ),
                ],
              ),
              Text('${loc.fieldDeceasedName}: ${provider.deceasedName}'),
              Text(
                '${loc.fieldDeceasedGender}: ${provider.deceasedGender == Gender.male ? loc.genderMale : loc.genderFemale}',
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.stepEstateTitle,
                    style: SirajiTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: SirajiColors.deepGreen,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => provider.setStep(0),
                    icon: const Icon(Icons.edit, size: 16),
                    label: Text(loc.btnEdit),
                  ),
                ],
              ),
              Text('${loc.fieldGrossAssets}: ${provider.grossAssets.toStringAsFixed(0)}'),
              if (provider.debts > 0)
                Text('${loc.fieldDebts}: ${provider.debts.toStringAsFixed(0)}'),
              if (provider.funeralExpenses > 0)
                Text('${loc.fieldFuneral}: ${provider.funeralExpenses.toStringAsFixed(0)}'),
              if (provider.bequestAmount > 0)
                Text('${loc.fieldBequest}: ${provider.bequestAmount.toStringAsFixed(0)}'),
              Text(
                '${loc.netDistributableEstate}: ${provider.netDistributableEstate.toStringAsFixed(0)}',
                style: SirajiTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SirajiColors.deepGold,
                ),
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.stepHeirsTitle,
                    style: SirajiTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: SirajiColors.deepGreen,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => provider.setStep(2),
                    icon: const Icon(Icons.edit, size: 16),
                    label: Text(loc.btnEdit),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: provider.heirCounts.entries.map((e) {
                  return Chip(
                    label: Text('${e.key.name}: ${e.value}'),
                    backgroundColor: SirajiColors.gold.withValues(alpha: 0.15),
                    side: const BorderSide(color: SirajiColors.gold),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: SirajiSpacing.lg),
        Row(
          children: [
            Expanded(
              child: SirajiButton(
                label: loc.btnBack,
                variant: SirajiButtonVariant.secondary,
                onPressed: () => provider.previousStep(),
              ),
            ),
            const SizedBox(width: SirajiSpacing.md),
            Expanded(
              child: SirajiButton(
                label: loc.btnCalculate,
                icon: Icons.calculate,
                onPressed: () {
                  final ok = provider.calculate();
                  if (ok) {
                    context.go(RouteNames.calculationResult);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(provider.errorMessage ?? loc.toastValidationFailed),
                        backgroundColor: SirajiColors.error,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SelectableCard extends StatelessWidget {
  const _SelectableCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? SirajiColors.gold.withValues(alpha: 0.15)
              : SirajiColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? SirajiColors.gold : SirajiColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isSelected ? SirajiColors.deepGreen : SirajiColors.textSecondary,
              ),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Text(
                label,
                style: SirajiTypography.labelSmall.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? SirajiColors.deepGreen : SirajiColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
