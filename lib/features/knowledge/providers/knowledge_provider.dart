import 'package:flutter/material.dart';
import '../../../domain/models/knowledge_article.dart';
import '../data/knowledge_repository.dart';

class KnowledgeProvider extends ChangeNotifier {
  KnowledgeProvider();

  String? _selectedCategoryId;
  String _searchQuery = '';

  String? get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;

  List<KnowledgeCategory> get categories => KnowledgeData.categories;
  List<KnowledgeArticle> get allArticles => KnowledgeData.articles;

  void selectCategory(String? categoryId) {
    if (_selectedCategoryId == categoryId) {
      _selectedCategoryId = null; // Toggle off to 'All'
    } else {
      _selectedCategoryId = categoryId;
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  List<KnowledgeArticle> getFilteredArticles(String languageCode) {
    var list = KnowledgeData.articles;

    // Filter by Category
    if (_selectedCategoryId != null && _selectedCategoryId!.isNotEmpty) {
      list = list.where((a) => a.categoryId == _selectedCategoryId).toList();
    }

    // Filter by Search Query
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((a) {
        final title = a.localizedTitle(languageCode).toLowerCase();
        final summary = a.localizedSummary(languageCode).toLowerCase();
        final content = a.localizedContent(languageCode).toLowerCase();
        return title.contains(q) || summary.contains(q) || content.contains(q);
      }).toList();
    }

    return list;
  }

  KnowledgeArticle? getArticleById(String id) {
    return KnowledgeData.articles.where((a) => a.id == id).firstOrNull;
  }

  KnowledgeCategory? getCategoryById(String categoryId) {
    return KnowledgeData.categories.where((c) => c.id == categoryId).firstOrNull;
  }

  List<KnowledgeArticle> getRelatedArticles(KnowledgeArticle article) {
    return KnowledgeData.articles
        .where((a) => article.relatedArticleIds.contains(a.id))
        .toList();
  }
}
