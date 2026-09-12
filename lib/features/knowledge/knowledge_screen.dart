import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../domain/models/knowledge_article.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/siraji_colors.dart';
import '../../theme/siraji_spacing.dart';
import '../../theme/siraji_typography.dart';
import '../../widgets/siraji_card.dart';
import '../../widgets/siraji_scaffold.dart';
import '../../widgets/siraji_text_field.dart';
import 'providers/knowledge_provider.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final provider = context.watch<KnowledgeProvider>();
    final articles = provider.getFilteredArticles(languageCode);
    final categories = provider.categories;

    return SirajiScaffold(
      title: loc.navKnowledge,
      titleIcon: Icons.menu_book,
      currentNavIndex: 2,
      body: SingleChildScrollView(
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
                // 1. Hero Knowledge Header Card
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
                              Icons.auto_stories,
                              color: SirajiColors.deepGold,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: SirajiSpacing.sm),
                          Expanded(
                            child: Text(
                              loc.knowledgeHeader,
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
                        loc.knowledgeIntro,
                        style: SirajiTypography.bodyMedium.copyWith(
                          color: SirajiColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: SirajiSpacing.md),
                      // Search Bar
                      SirajiTextField(
                        label: '',
                        hint: loc.searchKnowledgeHint,
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
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 2. Category Filter Horizontal Scroll
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final isSelected = provider.selectedCategoryId == null;
                        return _CategoryFilterChip(
                          label: loc.categoryAll,
                          isSelected: isSelected,
                          onTap: () => provider.selectCategory(null),
                        );
                      }
                      final cat = categories[index - 1];
                      final isSelected = provider.selectedCategoryId == cat.id;
                      return _CategoryFilterChip(
                        label: cat.localizedName(languageCode),
                        isSelected: isSelected,
                        onTap: () => provider.selectCategory(cat.id),
                      );
                    },
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 3. Articles List or Empty Search State
                if (articles.isEmpty)
                  SirajiCard(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48,
                              color: SirajiColors.textSecondary.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: SirajiSpacing.sm),
                            Text(
                              loc.noArticlesFound,
                              style: SirajiTypography.bodyMedium.copyWith(
                                color: SirajiColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: SirajiSpacing.md),
                            TextButton(
                              onPressed: () {
                                _searchController.clear();
                                provider.clearSearch();
                                provider.selectCategory(null);
                              },
                              child: Text(loc.btnClearSearch),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  ...articles.map(
                    (art) => _ArticleListItemCard(
                      article: art,
                      languageCode: languageCode,
                      minReadSuffix: loc.minRead,
                      readTopicText: loc.btnReadArticle,
                      categoryName: provider
                              .getCategoryById(art.categoryId)
                              ?.localizedName(languageCode) ??
                          '',
                      onTap: () => context.go('/knowledge/${art.id}'),
                    ),
                  ),

                const SizedBox(height: SirajiSpacing.lg),
                // 4. Scholarly Grounding Notice
                Container(
                  padding: const EdgeInsets.all(SirajiSpacing.md),
                  decoration: BoxDecoration(
                    color: SirajiColors.offWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: SirajiColors.divider),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.verified_outlined,
                        color: SirajiColors.deepGold,
                        size: 20,
                      ),
                      const SizedBox(width: SirajiSpacing.sm),
                      Expanded(
                        child: Text(
                          loc.knowledgeDisclaimer,
                          style: SirajiTypography.labelSmall.copyWith(
                            color: SirajiColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryFilterChip extends StatelessWidget {
  const _CategoryFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? SirajiColors.deepGreen : SirajiColors.offWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? SirajiColors.deepGreen : SirajiColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: SirajiColors.darkGreen.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: SirajiTypography.labelSmall.copyWith(
              color: isSelected ? SirajiColors.textOnDark : SirajiColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticleListItemCard extends StatelessWidget {
  const _ArticleListItemCard({
    required this.article,
    required this.languageCode,
    required this.categoryName,
    required this.minReadSuffix,
    required this.readTopicText,
    required this.onTap,
  });

  final KnowledgeArticle article;
  final String languageCode;
  final String categoryName;
  final String minReadSuffix;
  final String readTopicText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SirajiSpacing.sm),
      child: SirajiCard(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: SirajiColors.gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        categoryName,
                        style: SirajiTypography.labelSmall.copyWith(
                          color: SirajiColors.deepGold,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 13, color: SirajiColors.textSecondary),
                        const SizedBox(width: 3),
                        Text(
                          '${article.readingTimeMinutes} $minReadSuffix',
                          style: SirajiTypography.labelSmall.copyWith(
                            color: SirajiColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: SirajiSpacing.sm),
                Text(
                  article.localizedTitle(languageCode),
                  style: SirajiTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: SirajiColors.deepGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  article.localizedSummary(languageCode),
                  style: SirajiTypography.bodySmall.copyWith(
                    color: SirajiColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: SirajiSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      readTopicText,
                      style: SirajiTypography.labelSmall.copyWith(
                        color: SirajiColors.deepGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 11,
                      color: SirajiColors.deepGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
