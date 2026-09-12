import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/features/knowledge/data/knowledge_repository.dart';
import 'package:siraji/features/knowledge/providers/knowledge_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late KnowledgeProvider provider;

  setUp(() {
    provider = KnowledgeProvider();
  });

  group('Phase 3 Knowledge Education System Tests', () {
    test('KnowledgeData contains all 8 foundational categories', () {
      const categories = KnowledgeData.categories;
      expect(categories.length, 8);

      final categoryIds = categories.map((c) => c.id).toSet();
      expect(categoryIds, containsAll([
        'intro',
        'principles',
        'heirs',
        'shares',
        'residuaries',
        'exclusion',
        'distribution',
        'terminology',
      ]));

      // Verify each category has EN, UR, and AR names
      for (final cat in categories) {
        expect(cat.nameEn.isNotEmpty, isTrue);
        expect(cat.nameUr.isNotEmpty, isTrue);
        expect(cat.nameAr.isNotEmpty, isTrue);
      }
    });

    test('All Knowledge articles have verified multilingual content and references', () {
      const articles = KnowledgeData.articles;
      expect(articles.isNotEmpty, isTrue);

      for (final art in articles) {
        expect(art.id.isNotEmpty, isTrue);
        expect(art.titleEn.isNotEmpty, isTrue);
        expect(art.titleUr.isNotEmpty, isTrue);
        expect(art.titleAr.isNotEmpty, isTrue);

        expect(art.summaryEn.isNotEmpty, isTrue);
        expect(art.summaryUr.isNotEmpty, isTrue);
        expect(art.summaryAr.isNotEmpty, isTrue);

        expect(art.contentEn.isNotEmpty, isTrue);
        expect(art.contentUr.isNotEmpty, isTrue);
        expect(art.contentAr.isNotEmpty, isTrue);

        expect(art.references.isNotEmpty, isTrue);
      }
    });

    test('Category filtering filters articles accurately', () {
      expect(provider.getFilteredArticles('en').length, KnowledgeData.articles.length);

      provider.selectCategory('shares');
      final sharesArticles = provider.getFilteredArticles('en');
      expect(sharesArticles.isNotEmpty, isTrue);
      expect(sharesArticles.every((a) => a.categoryId == 'shares'), isTrue);

      // Deselect (toggle to all)
      provider.selectCategory('shares');
      expect(provider.getFilteredArticles('en').length, KnowledgeData.articles.length);
    });

    test('Multilingual Search filters articles in English, Urdu, and Arabic', () {
      // English search
      provider.setSearchQuery('Quranic');
      final enResults = provider.getFilteredArticles('en');
      expect(enResults.isNotEmpty, isTrue);

      // Urdu search
      provider.setSearchQuery('قرآن');
      final urResults = provider.getFilteredArticles('ur');
      expect(urResults.isNotEmpty, isTrue);

      // Arabic search
      provider.setSearchQuery('الفروض');
      final arResults = provider.getFilteredArticles('ar');
      expect(arResults.isNotEmpty, isTrue);

      // Clear search
      provider.clearSearch();
      expect(provider.getFilteredArticles('en').length, KnowledgeData.articles.length);
    });

    test('Related articles resolution works for connected topics', () {
      final faraidArticle = provider.getArticleById('what-is-faraid');
      expect(faraidArticle, isNotNull);

      final related = provider.getRelatedArticles(faraidArticle!);
      expect(related.isNotEmpty, isTrue);
      expect(related.map((r) => r.id), contains('estate-and-deductions'));
    });
  });
}
