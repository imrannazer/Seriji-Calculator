import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../domain/models/calculation.dart';
import '../../../domain/repositories/calculation_repository.dart';

class ReportsProvider extends ChangeNotifier {
  ReportsProvider({CalculationRepository? repository}) : _repository = repository;

  final CalculationRepository? _repository;

  List<Calculation> _calculations = [];
  List<Calculation> get calculations => List.unmodifiable(_calculations);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  Future<void> loadCalculations() async {
    if (_repository == null) return;
    _isLoading = true;
    notifyListeners();

    final res = await _repository.getAllCalculations();
    if (res.isSuccess) {
      _calculations = res.valueOrNull ?? [];
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Calculation> getFilteredCalculations() {
    if (_searchQuery.isEmpty) return _calculations;
    final q = _searchQuery.toLowerCase();
    return _calculations.where((c) {
      final title = c.title.toLowerCase();
      var deceasedName = '';
      try {
        final data = jsonDecode(c.dataJson) as Map<String, dynamic>;
        deceasedName = (data['deceasedName'] as String? ?? '').toLowerCase();
      } catch (_) {}
      return title.contains(q) || deceasedName.contains(q);
    }).toList();
  }

  Calculation? getCalculationById(String id) {
    return _calculations.where((c) => c.id == id).firstOrNull;
  }

  Future<bool> deleteCalculation(String id) async {
    if (_repository == null) return false;
    final res = await _repository.deleteCalculation(id);
    if (res.isSuccess) {
      _calculations.removeWhere((c) => c.id == id);
      notifyListeners();
      return true;
    }
    return false;
  }
}
