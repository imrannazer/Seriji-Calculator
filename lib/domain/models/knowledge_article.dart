import 'package:equatable/equatable.dart';

class KnowledgeCategory extends Equatable {
  const KnowledgeCategory({
    required this.id,
    required this.iconName,
    required this.nameEn,
    required this.nameUr,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionUr,
    required this.descriptionAr,
    this.sortOrder = 0,
  });

  final String id;
  final String iconName;
  final String nameEn;
  final String nameUr;
  final String nameAr;
  final String descriptionEn;
  final String descriptionUr;
  final String descriptionAr;
  final int sortOrder;

  String localizedName(String languageCode) => switch (languageCode) {
        'ur' => nameUr,
        'ar' => nameAr,
        _ => nameEn,
      };

  String localizedDescription(String languageCode) => switch (languageCode) {
        'ur' => descriptionUr,
        'ar' => descriptionAr,
        _ => descriptionEn,
      };

  @override
  List<Object?> get props => [id, iconName, nameEn, nameUr, nameAr, sortOrder];
}

class KnowledgeReference extends Equatable {
  const KnowledgeReference({
    required this.source,
    required this.citation,
    this.notes,
  });

  final String source;
  final String citation;
  final String? notes;

  @override
  List<Object?> get props => [source, citation, notes];
}

class KnowledgeArticle extends Equatable {
  const KnowledgeArticle({
    required this.id,
    required this.categoryId,
    required this.titleEn,
    required this.titleUr,
    required this.titleAr,
    required this.summaryEn,
    required this.summaryUr,
    required this.summaryAr,
    required this.contentEn,
    required this.contentUr,
    required this.contentAr,
    this.references = const [],
    this.relatedArticleIds = const [],
    this.readingTimeMinutes = 3,
    this.sortOrder = 0,
  });

  final String id;
  final String categoryId;
  final String titleEn;
  final String titleUr;
  final String titleAr;
  final String summaryEn;
  final String summaryUr;
  final String summaryAr;
  final String contentEn;
  final String contentUr;
  final String contentAr;
  final List<KnowledgeReference> references;
  final List<String> relatedArticleIds;
  final int readingTimeMinutes;
  final int sortOrder;

  String localizedTitle(String languageCode) => switch (languageCode) {
        'ur' => titleUr,
        'ar' => titleAr,
        _ => titleEn,
      };

  String localizedSummary(String languageCode) => switch (languageCode) {
        'ur' => summaryUr,
        'ar' => summaryAr,
        _ => summaryEn,
      };

  String localizedContent(String languageCode) => switch (languageCode) {
        'ur' => contentUr,
        'ar' => contentAr,
        _ => contentEn,
      };

  @override
  List<Object?> get props => [
        id,
        categoryId,
        titleEn,
        titleUr,
        titleAr,
        summaryEn,
        sortOrder,
      ];
}
