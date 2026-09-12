import 'package:flutter/material.dart';
import '../../../domain/models/will.dart';
import '../../../domain/repositories/will_repository.dart';

class WillProvider extends ChangeNotifier {
  WillProvider({WillRepository? repository}) : _repository = repository;

  final WillRepository? _repository;

  List<Will> _wills = [];
  List<Will> get wills => List.unmodifiable(_wills);

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

  Future<void> loadWills() async {
    if (_repository == null) return;
    _isLoading = true;
    notifyListeners();

    final res = await _repository.getAllWills();
    if (res.isSuccess) {
      _wills = res.valueOrNull ?? [];
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Will> getFilteredWills() {
    if (_searchQuery.isEmpty) return _wills;
    final q = _searchQuery.toLowerCase();
    return _wills.where((w) {
      final name = w.testatorName.toLowerCase();
      final notes = (w.bequestNotes ?? '').toLowerCase();
      return name.contains(q) || notes.contains(q);
    }).toList();
  }

  Will? getWillById(String id) {
    return _wills.where((w) => w.id == id).firstOrNull;
  }

  Future<bool> saveWill(Will will) async {
    if (_repository == null) return false;
    final res = await _repository.saveWill(will);
    if (res.isSuccess) {
      _wills.removeWhere((w) => w.id == will.id);
      _wills.insert(0, will);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> deleteWill(String id) async {
    if (_repository == null) return false;
    final res = await _repository.deleteWill(id);
    if (res.isSuccess) {
      _wills.removeWhere((w) => w.id == id);
      notifyListeners();
      return true;
    }
    return false;
  }
}
