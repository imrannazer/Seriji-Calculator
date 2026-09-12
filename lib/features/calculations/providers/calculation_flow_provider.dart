import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../calculation_engine/faraid_engine.dart';
import '../../../domain/models/asset.dart';
import '../../../domain/models/calculation.dart';
import '../../../domain/models/calculation_result.dart';
import '../../../domain/models/estate.dart';
import '../../../domain/models/heir.dart';
import '../../../domain/models/relationship.dart';
import '../../../domain/repositories/calculation_repository.dart';

class CalculationFlowProvider extends ChangeNotifier {
  CalculationFlowProvider({
    FaraidEngine? engine,
  }) : _engine = engine ?? FaraidEngine();

  final FaraidEngine _engine;

  int _currentStep = 0;
  int get currentStep => _currentStep;

  // Step 1: Estate
  double _grossAssets = 0.0;
  double _debts = 0.0;
  double _funeralExpenses = 0.0;
  double _bequestAmount = 0.0;

  double get grossAssets => _grossAssets;
  double get debts => _debts;
  double get funeralExpenses => _funeralExpenses;
  double get bequestAmount => _bequestAmount;

  double get netDistributableEstate {
    final afterDebts = _grossAssets - _debts - _funeralExpenses;
    final maxBequest = (afterDebts * (1.0 / 3.0)).clamp(0.0, double.infinity);
    final effectiveBequest = _bequestAmount.clamp(0.0, maxBequest);
    return (afterDebts - effectiveBequest).clamp(0.0, double.infinity);
  }

  // Step 2: Deceased
  String _deceasedName = '';
  Gender _deceasedGender = Gender.male;
  String _maritalStatus = 'married';

  String get deceasedName => _deceasedName;
  Gender get deceasedGender => _deceasedGender;
  String get maritalStatus => _maritalStatus;

  // Step 3: Heirs
  final Map<Relationship, int> _heirCounts = {};
  Map<Relationship, int> get heirCounts => Map.unmodifiable(_heirCounts);

  int getHeirCount(Relationship rel) => _heirCounts[rel] ?? 0;

  int get totalHeirCount => _heirCounts.values.fold(0, (sum, c) => sum + c);

  // Result & Saved state
  CalculationResult? _result;
  CalculationResult? get result => _result;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  bool _isSaved = false;
  bool get isSaved => _isSaved;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Setters & Navigation
  void setStep(int step) {
    _currentStep = step.clamp(0, 4);
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 4) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void setEstateInfo({
    required double grossAssets,
    required double debts,
    required double funeralExpenses,
    required double bequestAmount,
  }) {
    _grossAssets = grossAssets;
    _debts = debts;
    _funeralExpenses = funeralExpenses;
    _bequestAmount = bequestAmount;
    notifyListeners();
  }

  void setDeceasedInfo({
    required String name,
    required Gender gender,
    required String maritalStatus,
  }) {
    _deceasedName = name;
    _deceasedGender = gender;
    _maritalStatus = maritalStatus;

    if (gender == Gender.male) {
      _heirCounts.remove(Relationship.husband);
    } else {
      _heirCounts.remove(Relationship.wife);
    }
    notifyListeners();
  }

  void setHeirCount(Relationship rel, int count) {
    if (count <= 0) {
      _heirCounts.remove(rel);
    } else {
      if (rel == Relationship.husband && count > 1) count = 1;
      if (rel == Relationship.wife && count > 4) count = 4;
      if (rel == Relationship.father && count > 1) count = 1;
      if (rel == Relationship.mother && count > 1) count = 1;
      if (rel == Relationship.grandfather && count > 1) count = 1;
      if (rel == Relationship.grandmother && count > 1) count = 1;
      if (rel == Relationship.maternalGrandmother && count > 1) count = 1;

      _heirCounts[rel] = count;
    }
    notifyListeners();
  }

  void incrementHeir(Relationship rel) {
    final current = getHeirCount(rel);
    setHeirCount(rel, current + 1);
  }

  void decrementHeir(Relationship rel) {
    final current = getHeirCount(rel);
    if (current > 0) {
      setHeirCount(rel, current - 1);
    }
  }

  bool calculate() {
    _errorMessage = null;

    final heirsList = <Heir>[];
    for (final entry in _heirCounts.entries) {
      if (entry.value > 0) {
        heirsList.add(Heir(
          id: entry.key.name,
          relationship: entry.key,
          name: entry.key.name,
          count: entry.value,
        ));
      }
    }

    final bequestFraction = _grossAssets > 0 ? (_bequestAmount / _grossAssets).clamp(0.0, 1 / 3) : 0.0;

    final estate = Estate(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      deceasedName: _deceasedName.trim().isEmpty ? 'Deceased' : _deceasedName.trim(),
      heirs: heirsList,
      assets: [
        Asset(
          id: 'asset_1',
          name: 'Estate Assets',
          type: AssetType.cash,
          value: _grossAssets,
        ),
      ],
      totalDebts: _debts,
      funeralExpenses: _funeralExpenses,
      bequestFraction: bequestFraction,
    );

    final res = _engine.calculate(estate);
    if (res.isSuccess) {
      _result = res.valueOrNull;
      _isSaved = false;
      _currentStep = 4;
      notifyListeners();
      return true;
    } else {
      _errorMessage = res.errorOrNull;
      notifyListeners();
      return false;
    }
  }

  Future<bool> saveCalculation(CalculationRepository repository) async {
    if (_result == null) return false;

    _isSaving = true;
    notifyListeners();

    try {
      final jsonMap = {
        'id': _result!.id,
        'deceasedName': _result!.estate.deceasedName,
        'grossAssets': _grossAssets,
        'debts': _debts,
        'funeralExpenses': _funeralExpenses,
        'bequestAmount': _bequestAmount,
        'netDistributableEstate': _result!.estate.netDistributableValue,
        'calculatedAt': _result!.calculatedAt.toIso8601String(),
        'shares': _result!.shares
            .map((s) => {
                  'heirId': s.heirId,
                  'fraction': s.fractionString,
                  'percentage': s.percentageString,
                  'amount': s.amount,
                  'count': s.count,
                  'type': s.shareType.name,
                  'explanation': s.explanation,
                })
            .toList(),
      };

      final calculation = Calculation(
        id: _result!.id,
        title: '${_result!.estate.deceasedName} — ${_grossAssets.toStringAsFixed(0)}',
        createdAt: _result!.calculatedAt,
        dataJson: jsonEncode(jsonMap),
      );

      final saveRes = await repository.saveCalculation(calculation);
      if (saveRes.isSuccess) {
        _isSaved = true;
        _isSaving = false;
        notifyListeners();
        return true;
      }
    } catch (_) {}

    _isSaving = false;
    notifyListeners();
    return false;
  }

  void reset() {
    _currentStep = 0;
    _grossAssets = 0.0;
    _debts = 0.0;
    _funeralExpenses = 0.0;
    _bequestAmount = 0.0;
    _deceasedName = '';
    _deceasedGender = Gender.male;
    _maritalStatus = 'married';
    _heirCounts.clear();
    _result = null;
    _isSaved = false;
    _errorMessage = null;
    notifyListeners();
  }
}
