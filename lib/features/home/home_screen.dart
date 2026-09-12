import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/route_names.dart';
import '../../theme/siraji_colors.dart';
import '../../theme/siraji_spacing.dart';
import '../../theme/siraji_typography.dart';
import '../../widgets/siraji_button.dart';
import '../../widgets/siraji_card.dart';
import '../../widgets/siraji_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return SirajiScaffold(
      title: loc.navHome,
      titleIcon: Icons.home_outlined,
      currentNavIndex: 0,
      body: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= 600;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
              // 1. Hero / Welcome Card
              _HomeHeroCard(loc: loc),
              const SizedBox(height: SirajiSpacing.md),

              // 2. Primary Action: Faraid / Inheritance Calculation
              _PrimaryCalculationCard(loc: loc),
              const SizedBox(height: SirajiSpacing.lg),

              // 3. Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  loc.appSubtitle,
                  style: SirajiTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: SirajiColors.deepGreen,
                  ),
                ),
              ),
              const SizedBox(height: SirajiSpacing.sm),

              // 4. Secondary Action Cards Grid (Responsive)
              if (isTablet)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _ActionCard(
                            icon: Icons.pie_chart_outline,
                            title: loc.actionPropertyTitle,
                            subtitle: loc.actionPropertySubtitle,
                            onTap: () => context.go(RouteNames.calculations),
                          ),
                          const SizedBox(height: SirajiSpacing.md),
                          _ActionCard(
                            icon: Icons.auto_stories_outlined,
                            title: loc.actionKnowledgeTitle,
                            subtitle: loc.actionKnowledgeSubtitle,
                            onTap: () => context.go(RouteNames.knowledge),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: SirajiSpacing.md),
                    Expanded(
                      child: Column(
                        children: [
                          _ActionCard(
                            icon: Icons.article_outlined,
                            title: loc.actionWillTitle,
                            subtitle: loc.actionWillSubtitle,
                            onTap: () => context.go('/will'),
                          ),
                          const SizedBox(height: SirajiSpacing.md),
                          _ActionCard(
                            icon: Icons.bookmark_border_outlined,
                            title: loc.actionReportsTitle,
                            subtitle: loc.actionReportsSubtitle,
                            onTap: () => context.go(RouteNames.reports),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else ...[
                _ActionCard(
                  icon: Icons.pie_chart_outline,
                  title: loc.actionPropertyTitle,
                  subtitle: loc.actionPropertySubtitle,
                  onTap: () => context.go(RouteNames.calculations),
                ),
                const SizedBox(height: SirajiSpacing.sm),
                _ActionCard(
                  icon: Icons.article_outlined,
                  title: loc.actionWillTitle,
                  subtitle: loc.actionWillSubtitle,
                  onTap: () => context.go('/will'),
                ),
                const SizedBox(height: SirajiSpacing.sm),
                _ActionCard(
                  icon: Icons.auto_stories_outlined,
                  title: loc.actionKnowledgeTitle,
                  subtitle: loc.actionKnowledgeSubtitle,
                  onTap: () => context.go(RouteNames.knowledge),
                ),
                const SizedBox(height: SirajiSpacing.sm),
                _ActionCard(
                  icon: Icons.bookmark_border_outlined,
                  title: loc.actionReportsTitle,
                  subtitle: loc.actionReportsSubtitle,
                  onTap: () => context.go(RouteNames.reports),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeroCard extends StatelessWidget {
  const _HomeHeroCard({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SirajiColors.deepGreen,
            SirajiColors.darkGreen,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SirajiColors.darkGreen.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(SirajiSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.homeGreeting,
                    style: SirajiTypography.titleLarge.copyWith(
                      color: SirajiColors.gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.xs),
                  Text(
                    loc.homeHeroDesc,
                    style: SirajiTypography.bodySmall.copyWith(
                      color: SirajiColors.textOnDark.withValues(alpha: 0.85),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: SirajiSpacing.md),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SirajiColors.goldGradient,
                boxShadow: [
                  BoxShadow(
                    color: SirajiColors.gold.withValues(alpha: 0.4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_stories,
                color: SirajiColors.darkGreen,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryCalculationCard extends StatelessWidget {
  const _PrimaryCalculationCard({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SirajiColors.offWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SirajiColors.gold, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: SirajiColors.gold.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(SirajiSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SirajiColors.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calculate_outlined,
                    color: SirajiColors.deepGold,
                    size: 28,
                  ),
                ),
                const SizedBox(width: SirajiSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.primaryActionTitle,
                        style: SirajiTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: SirajiColors.deepGreen,
                        ),
                      ),
                      Text(
                        loc.primaryActionSubtitle,
                        style: SirajiTypography.bodySmall.copyWith(
                          color: SirajiColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: SirajiSpacing.md),
            SirajiButton(
              label: loc.primaryActionCta,
              icon: Icons.arrow_forward,
              fullWidth: true,
              onPressed: () => context.go(RouteNames.calculations),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SirajiCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: SirajiColors.deepGreen.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: SirajiColors.deepGreen, size: 24),
          ),
          const SizedBox(width: SirajiSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: SirajiTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: SirajiTypography.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: SirajiSpacing.xs),
          const Icon(
            Icons.chevron_right,
            color: SirajiColors.textSecondary,
            size: 20,
          ),
        ],
      ),
    );
  }
}


