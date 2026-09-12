import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/relationship.dart';
import '../../../domain/models/will.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';
import '../../../widgets/siraji_text_field.dart';
import '../../calculations/providers/calculation_flow_provider.dart';
import '../providers/will_provider.dart';

class WillEditorScreen extends StatefulWidget {
  const WillEditorScreen({super.key, this.willId});

  final String? willId;

  @override
  State<WillEditorScreen> createState() => _WillEditorScreenState();
}

class _WillEditorScreenState extends State<WillEditorScreen> {
  final _testatorNameController = TextEditingController();
  final _grossAssetsController = TextEditingController(text: '0');
  final _debtsController = TextEditingController(text: '0');
  final _funeralController = TextEditingController(text: '0');
  final _bequestAmountController = TextEditingController(text: '0');
  final _bequestNotesController = TextEditingController();

  Gender _deceasedGender = Gender.male;
  String _maritalStatus = 'married';
  WillStatus _willStatus = WillStatus.draft;

  final Map<Relationship, int> _heirCounts = {};
  String? _nameError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadExistingData();
    });
  }

  void _loadExistingData() {
    if (widget.willId != null && widget.willId!.isNotEmpty) {
      final willProvider = context.read<WillProvider>();
      final existing = willProvider.getWillById(widget.willId!);
      if (existing != null) {
        _testatorNameController.text = existing.testatorName;
        _bequestNotesController.text = existing.bequestNotes ?? '';
        _willStatus = existing.status;

        if (existing.dataJson != null) {
          try {
            final map = jsonDecode(existing.dataJson!) as Map<String, dynamic>;
            _grossAssetsController.text = (map['grossAssets'] ?? 0).toString();
            _debtsController.text = (map['debts'] ?? 0).toString();
            _funeralController.text = (map['funeralExpenses'] ?? 0).toString();
            _bequestAmountController.text = (map['bequestAmount'] ?? 0).toString();
            _maritalStatus = (map['maritalStatus'] as String?) ?? 'married';
            final genderStr = (map['gender'] as String?) ?? 'male';
            _deceasedGender = genderStr == 'female' ? Gender.female : Gender.male;

            final rawHeirs = map['heirs'] as Map<String, dynamic>? ?? {};
            for (final entry in rawHeirs.entries) {
              final rel = Relationship.values.firstWhere(
                (r) => r.name == entry.key,
                orElse: () => Relationship.son,
              );
              _heirCounts[rel] = int.tryParse(entry.value.toString()) ?? 0;
            }
          } catch (_) {}
        }
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _testatorNameController.dispose();
    _grossAssetsController.dispose();
    _debtsController.dispose();
    _funeralController.dispose();
    _bequestAmountController.dispose();
    _bequestNotesController.dispose();
    super.dispose();
  }

  void _updateHeirCount(Relationship rel, int count) {
    setState(() {
      if (count <= 0) {
        _heirCounts.remove(rel);
      } else {
        _heirCounts[rel] = count;
      }
    });
  }

  bool _validate(AppLocalizations loc) {
    if (_testatorNameController.text.trim().isEmpty) {
      setState(() => _nameError = loc.valDeceasedNameRequired);
      return false;
    }
    setState(() => _nameError = null);
    return true;
  }

  Future<void> _saveProfile(BuildContext context, AppLocalizations loc) async {
    if (!_validate(loc)) return;

    final gross = double.tryParse(_grossAssetsController.text) ?? 0.0;
    final debts = double.tryParse(_debtsController.text) ?? 0.0;
    final funeral = double.tryParse(_funeralController.text) ?? 0.0;
    final bequest = double.tryParse(_bequestAmountController.text) ?? 0.0;

    final dataMap = {
      'testatorName': _testatorNameController.text.trim(),
      'gender': _deceasedGender.name,
      'maritalStatus': _maritalStatus,
      'grossAssets': gross,
      'debts': debts,
      'funeralExpenses': funeral,
      'bequestAmount': bequest,
      'heirs': _heirCounts.map((k, v) => MapEntry(k.name, v)),
    };

    final willId = widget.willId ?? 'will_${DateTime.now().millisecondsSinceEpoch}';
    final will = Will(
      id: willId,
      testatorName: _testatorNameController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: _willStatus,
      bequestNotes: _bequestNotesController.text.trim(),
      dataJson: jsonEncode(dataMap),
      schemaVersion: 1,
    );

    final ok = await context.read<WillProvider>().saveWill(will);
    if (ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.toastWillSavedSuccess),
          backgroundColor: SirajiColors.success,
        ),
      );
      context.go('/will');
    }
  }

  void _calculateAndReview(BuildContext context, AppLocalizations loc) {
    if (!_validate(loc)) return;

    final gross = double.tryParse(_grossAssetsController.text) ?? 0.0;
    final debts = double.tryParse(_debtsController.text) ?? 0.0;
    final funeral = double.tryParse(_funeralController.text) ?? 0.0;
    final bequest = double.tryParse(_bequestAmountController.text) ?? 0.0;

    final flowProvider = context.read<CalculationFlowProvider>();
    flowProvider.setDeceasedInfo(
      name: _testatorNameController.text.trim(),
      gender: _deceasedGender,
      maritalStatus: _maritalStatus,
    );
    flowProvider.setEstateInfo(
      grossAssets: gross,
      debts: debts,
      funeralExpenses: funeral,
      bequestAmount: bequest,
    );

    for (final rel in Relationship.values) {
      flowProvider.setHeirCount(rel, _heirCounts[rel] ?? 0);
    }

    final calculated = flowProvider.calculate();
    if (calculated) {
      context.go(RouteNames.calculationResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return SirajiScaffold(
      title: widget.willId != null ? loc.btnEdit : loc.btnCreateNewWill,
      titleIcon: Icons.history_edu,
      currentNavIndex: 0,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: SirajiSpacing.pagePadding,
          right: SirajiSpacing.pagePadding,
          top: SirajiSpacing.md,
          bottom: SirajiSpacing.footerHeight + SirajiSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Testator Details Section
                _SectionHeader(title: loc.stepDeceasedTitle),
                const SizedBox(height: 6),
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SirajiTextField(
                        label: loc.fieldDeceasedName,
                        hint: loc.fieldDeceasedNameHint,
                        controller: _testatorNameController,
                        errorText: _nameError,
                        prefixIcon: Icons.person_outline,
                        onChanged: (_) {
                          if (_nameError != null) setState(() => _nameError = null);
                        },
                      ),
                      const SizedBox(height: SirajiSpacing.md),
                      Text(
                        loc.fieldDeceasedGender,
                        style: SirajiTypography.titleMedium.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: _RadioSelectCard(
                              label: loc.genderMale,
                              isSelected: _deceasedGender == Gender.male,
                              onSelect: () => setState(() => _deceasedGender = Gender.male),
                            ),
                          ),
                          const SizedBox(width: SirajiSpacing.sm),
                          Expanded(
                            child: _RadioSelectCard(
                              label: loc.genderFemale,
                              isSelected: _deceasedGender == Gender.female,
                              onSelect: () => setState(() => _deceasedGender = Gender.female),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SirajiSpacing.md),
                      Text(
                        loc.statusSelectorLabel,
                        style: SirajiTypography.titleMedium.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<WillStatus>(
                        value: _willStatus,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: SirajiColors.offWhite,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: [
                          DropdownMenuItem(value: WillStatus.draft, child: Text(loc.statusDraft)),
                          DropdownMenuItem(value: WillStatus.reviewed, child: Text(loc.statusReviewed)),
                          DropdownMenuItem(value: WillStatus.finalized, child: Text(loc.statusFinalized)),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _willStatus = val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),

                // 2. Estate & Deductions Section
                _SectionHeader(title: loc.stepEstateTitle),
                const SizedBox(height: 6),
                SirajiCard(
                  child: Column(
                    children: [
                      SirajiTextField(
                        label: loc.fieldGrossAssets,
                        hint: loc.fieldGrossAssetsHint,
                        controller: _grossAssetsController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.account_balance_wallet_outlined,
                      ),
                      const SizedBox(height: SirajiSpacing.sm),
                      SirajiTextField(
                        label: loc.fieldDebts,
                        hint: loc.fieldDebtsHint,
                        controller: _debtsController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.money_off_outlined,
                      ),
                      const SizedBox(height: SirajiSpacing.sm),
                      SirajiTextField(
                        label: loc.fieldFuneral,
                        hint: loc.fieldFuneralHint,
                        controller: _funeralController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.airline_seat_flat_outlined,
                      ),
                      const SizedBox(height: SirajiSpacing.sm),
                      SirajiTextField(
                        label: loc.fieldBequest,
                        hint: loc.fieldBequestHint,
                        controller: _bequestAmountController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.favorite_outline,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),

                // 3. Heirs Selection Section
                _SectionHeader(title: loc.stepHeirsTitle),
                const SizedBox(height: 6),
                SirajiCard(
                  child: Column(
                    children: [
                      if (_deceasedGender == Gender.male)
                        _HeirCounterRow(
                          label: loc.heirWife,
                          count: _heirCounts[Relationship.wife] ?? 0,
                          maxCount: 4,
                          onChanged: (c) => _updateHeirCount(Relationship.wife, c),
                        )
                      else
                        _HeirCounterRow(
                          label: loc.heirHusband,
                          count: _heirCounts[Relationship.husband] ?? 0,
                          maxCount: 1,
                          onChanged: (c) => _updateHeirCount(Relationship.husband, c),
                        ),
                      const Divider(height: 12),
                      _HeirCounterRow(
                        label: loc.heirSon,
                        count: _heirCounts[Relationship.son] ?? 0,
                        onChanged: (c) => _updateHeirCount(Relationship.son, c),
                      ),
                      const Divider(height: 12),
                      _HeirCounterRow(
                        label: loc.heirDaughter,
                        count: _heirCounts[Relationship.daughter] ?? 0,
                        onChanged: (c) => _updateHeirCount(Relationship.daughter, c),
                      ),
                      const Divider(height: 12),
                      _HeirCounterRow(
                        label: loc.heirFather,
                        count: _heirCounts[Relationship.father] ?? 0,
                        maxCount: 1,
                        onChanged: (c) => _updateHeirCount(Relationship.father, c),
                      ),
                      const Divider(height: 12),
                      _HeirCounterRow(
                        label: loc.heirMother,
                        count: _heirCounts[Relationship.mother] ?? 0,
                        maxCount: 1,
                        onChanged: (c) => _updateHeirCount(Relationship.mother, c),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),

                // 4. Bequest (Wasiyyah) Instructions
                _SectionHeader(title: loc.actionWillTitle),
                const SizedBox(height: 6),
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SirajiTextField(
                        label: loc.fieldBequestNotes,
                        hint: loc.fieldBequestNotesHint,
                        controller: _bequestNotesController,
                        maxLines: 4,
                        prefixIcon: Icons.notes_outlined,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.xl),

                // 5. Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: SirajiButton(
                        label: loc.btnSaveCalculation,
                        icon: Icons.save_outlined,
                        onPressed: () => _saveProfile(context, loc),
                      ),
                    ),
                    const SizedBox(width: SirajiSpacing.sm),
                    Expanded(
                      child: SirajiButton(
                        label: loc.btnCalculateFaraid,
                        icon: Icons.calculate_outlined,
                        variant: SirajiButtonVariant.secondary,
                        onPressed: () => _calculateAndReview(context, loc),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SirajiSpacing.sm),
                SirajiButton(
                  label: loc.btnBack,
                  variant: SirajiButtonVariant.text,
                  fullWidth: true,
                  onPressed: () => context.go('/will'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
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

class _RadioSelectCard extends StatelessWidget {
  const _RadioSelectCard({
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? SirajiColors.deepGreen : SirajiColors.offWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? SirajiColors.deepGreen : SirajiColors.divider,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: SirajiTypography.labelLarge.copyWith(
              color: isSelected ? SirajiColors.textOnDark : SirajiColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeirCounterRow extends StatelessWidget {
  const _HeirCounterRow({
    required this.label,
    required this.count,
    required this.onChanged,
    this.maxCount = 20,
  });

  final String label;
  final int count;
  final ValueChanged<int> onChanged;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: SirajiTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: SirajiColors.offWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: SirajiColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 16),
                onPressed: count > 0 ? () => onChanged(count - 1) : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  count.toString(),
                  style: SirajiTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: SirajiColors.deepGreen,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 16),
                onPressed: count < maxCount ? () => onChanged(count + 1) : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
