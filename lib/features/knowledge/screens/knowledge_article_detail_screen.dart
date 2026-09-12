import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';
import '../providers/knowledge_provider.dart';

class KnowledgeArticleDetailScreen extends StatelessWidget {
  const KnowledgeArticleDetailScreen({super.key, required this.articleId});

  final String articleId;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final provider = context.watch<KnowledgeProvider>();
    final article = provider.getArticleById(articleId);

    if (article == null) {
      return SirajiScaffold(
        title: loc.navKnowledge,
        titleIcon: Icons.menu_book,
        currentNavIndex: 2,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: SirajiColors.error),
              const SizedBox(height: SirajiSpacing.md),
              Text(
                loc.noArticlesFound,
                style: SirajiTypography.titleMedium,
              ),
              const SizedBox(height: SirajiSpacing.md),
              SirajiButton(
                label: loc.btnBack,
                onPressed: () => context.go(RouteNames.knowledge),
              ),
            ],
          ),
        ),
      );
    }

    final category = provider.getCategoryById(article.categoryId);
    final relatedArticles = provider.getRelatedArticles(article);

    return SirajiScaffold(
      title: article.localizedTitle(languageCode),
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
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Article Header Banner
                Container(
                  padding: const EdgeInsets.all(SirajiSpacing.md),
                  decoration: BoxDecoration(
                    gradient: SirajiColors.headerGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: SirajiColors.darkGreen.withValues(alpha: 0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (category != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: SirajiColors.gold.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                category.localizedName(languageCode),
                                style: SirajiTypography.labelSmall.copyWith(
                                  color: SirajiColors.gold,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              const Icon(Icons.schedule, size: 14, color: SirajiColors.textOnDark),
                              const SizedBox(width: 4),
                              Text(
                                '${article.readingTimeMinutes} ${loc.minRead}',
                                style: SirajiTypography.labelSmall.copyWith(
                                  color: SirajiColors.textOnDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: SirajiSpacing.sm),
                      Text(
                        article.localizedTitle(languageCode),
                        style: SirajiTypography.headlineMedium.copyWith(
                          color: SirajiColors.gold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 2. Summary Callout Card
                Container(
                  padding: const EdgeInsets.all(SirajiSpacing.md),
                  decoration: BoxDecoration(
                    color: SirajiColors.gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: SirajiColors.gold.withValues(alpha: 0.6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.format_quote, color: SirajiColors.deepGold, size: 24),
                      const SizedBox(width: SirajiSpacing.sm),
                      Expanded(
                        child: Text(
                          article.localizedSummary(languageCode),
                          style: SirajiTypography.bodyMedium.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: SirajiColors.deepGreen,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 3. Article Body Content
                SirajiCard(
                  child: _ArticleContentRenderer(
                    content: article.localizedContent(languageCode),
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 4. Scholarly Sources & References Card
                if (article.references.isNotEmpty) ...[
                  SirajiCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.library_books, color: SirajiColors.deepGold, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              loc.articleReferencesTitle,
                              style: SirajiTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: SirajiColors.deepGreen,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        ...article.references.map(
                          (ref) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ', style: TextStyle(color: SirajiColors.gold, fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: SirajiTypography.bodySmall,
                                      children: [
                                        TextSpan(
                                          text: '${ref.source}: ',
                                          style: const TextStyle(fontWeight: FontWeight.w700, color: SirajiColors.textPrimary),
                                        ),
                                        TextSpan(
                                          text: ref.citation,
                                          style: const TextStyle(color: SirajiColors.textSecondary),
                                        ),
                                        if (ref.notes != null)
                                          TextSpan(
                                            text: ' (${ref.notes})',
                                            style: const TextStyle(fontStyle: FontStyle.italic),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.md),
                ],

                // 5. Related Topics Section
                if (relatedArticles.isNotEmpty) ...[
                  Text(
                    loc.articleRelatedTitle,
                    style: SirajiTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: SirajiColors.deepGreen,
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.sm),
                  ...relatedArticles.map(
                    (rel) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SirajiCard(
                        child: InkWell(
                          onTap: () => context.go('/knowledge/${rel.id}'),
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                const Icon(Icons.article_outlined, color: SirajiColors.deepGold, size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rel.localizedTitle(languageCode),
                                        style: SirajiTypography.titleMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        rel.localizedSummary(languageCode),
                                        style: SirajiTypography.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 12, color: SirajiColors.deepGreen),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.md),
                ],

                // 6. Action Buttons: "Try in Calculator" & "Back"
                SirajiButton(
                  label: loc.btnTryInCalculator,
                  icon: Icons.calculate,
                  fullWidth: true,
                  onPressed: () => context.go(RouteNames.calculationFlow),
                ),
                const SizedBox(height: SirajiSpacing.sm),
                SirajiButton(
                  label: loc.btnBack,
                  variant: SirajiButtonVariant.secondary,
                  fullWidth: true,
                  onPressed: () => context.go(RouteNames.knowledge),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticleContentRenderer extends StatelessWidget {
  const _ArticleContentRenderer({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      if (line.isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      if (line.startsWith('### ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 6),
            child: Text(
              line.substring(4),
              style: SirajiTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: SirajiColors.deepGreen,
              ),
            ),
          ),
        );
      } else if (line.startsWith('> ')) {
        widgets.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: SirajiColors.deepGreen.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: const Border(
                left: BorderSide(color: SirajiColors.gold, width: 3),
              ),
            ),
            child: Text(
              line.substring(2),
              style: SirajiTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: SirajiColors.deepGreen,
                height: 1.6,
              ),
            ),
          ),
        );
      } else if (line.startsWith('* ') || line.startsWith('- ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: SirajiColors.deepGold, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    line.substring(2).replaceAll('**', ''),
                    style: SirajiTypography.bodyMedium.copyWith(height: 1.6),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (RegExp(r'^\d+\.\s').hasMatch(line)) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 6),
            child: Text(
              line.replaceAll('**', ''),
              style: SirajiTypography.bodyMedium.copyWith(height: 1.6),
            ),
          ),
        );
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              line.replaceAll('**', '').replaceAll('*', ''),
              style: SirajiTypography.bodyMedium.copyWith(height: 1.6),
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }
}
