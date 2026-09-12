import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../domain/models/will.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/route_names.dart';
import '../../theme/siraji_colors.dart';
import '../../theme/siraji_spacing.dart';
import '../../theme/siraji_typography.dart';
import '../../widgets/siraji_button.dart';
import '../../widgets/siraji_card.dart';
import '../../widgets/siraji_scaffold.dart';
import '../../widgets/siraji_text_field.dart';
import 'providers/will_provider.dart';

class WillScreen extends StatefulWidget {
  const WillScreen({super.key});

  @override
  State<WillScreen> createState() => _WillScreenState();
}

class _WillScreenState extends State<WillScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WillProvider>().loadWills();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmDelete(BuildContext context, Will will, AppLocalizations loc) async {
    final provider = context.read<WillProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: SirajiColors.error, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                loc.dialogDeleteWillTitle,
                style: SirajiTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SirajiColors.deepGreen,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          loc.dialogDeleteWillMessage,
          style: SirajiTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(loc.dialogDeleteCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SirajiColors.error,
              foregroundColor: SirajiColors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(loc.dialogDeleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final ok = await provider.deleteWill(will.id);
      if (ok) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(loc.toastWillDeletedSuccess),
            backgroundColor: SirajiColors.success,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final provider = context.watch<WillProvider>();
    final wills = provider.getFilteredWills();

    return SirajiScaffold(
      title: loc.actionWillTitle,
      titleIcon: Icons.history_edu,
      currentNavIndex: 0,
      body: RefreshIndicator(
        onRefresh: () => provider.loadWills(),
        color: SirajiColors.deepGreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                  // 1. Hero Card
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
                              child: const Icon(Icons.history_edu, color: SirajiColors.deepGold, size: 26),
                            ),
                            const SizedBox(width: SirajiSpacing.sm),
                            Expanded(
                              child: Text(
                                loc.willSectionHeader,
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
                          loc.willSectionSubtitle,
                          style: SirajiTypography.bodyMedium.copyWith(
                            color: SirajiColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: SirajiSpacing.md),
                        Row(
                          children: [
                            Expanded(
                              child: SirajiButton(
                                label: loc.btnCreateNewWill,
                                icon: Icons.add,
                                onPressed: () => context.go(RouteNames.newWill),
                              ),
                            ),
                          ],
                        ),
                        if (provider.wills.isNotEmpty) ...[
                          const SizedBox(height: SirajiSpacing.md),
                          SirajiTextField(
                            label: '',
                            hint: loc.searchWillsHint,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.md),

                  // 2. Saved Wills List or Empty State
                  if (provider.isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(48),
                        child: CircularProgressIndicator(color: SirajiColors.deepGreen),
                      ),
                    )
                  else if (provider.wills.isEmpty)
                    SirajiCard(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                          child: Column(
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                size: 56,
                                color: SirajiColors.textSecondary.withValues(alpha: 0.4),
                              ),
                              const SizedBox(height: SirajiSpacing.md),
                              Text(
                                loc.emptyWillsTitle,
                                style: SirajiTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: SirajiColors.deepGreen,
                                ),
                              ),
                              const SizedBox(height: SirajiSpacing.xs),
                              Text(
                                loc.emptyWillsDesc,
                                style: SirajiTypography.bodySmall.copyWith(
                                  color: SirajiColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: SirajiSpacing.lg),
                              SirajiButton(
                                label: loc.btnCreateNewWill,
                                icon: Icons.add,
                                onPressed: () => context.go(RouteNames.newWill),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else if (wills.isEmpty)
                    SirajiCard(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                          child: Column(
                            children: [
                              const Icon(Icons.search_off, size: 48, color: SirajiColors.textSecondary),
                              const SizedBox(height: SirajiSpacing.sm),
                              Text(loc.noReportsFound, style: SirajiTypography.bodyMedium),
                              const SizedBox(height: SirajiSpacing.sm),
                              TextButton(
                                onPressed: () {
                                  _searchController.clear();
                                  provider.clearSearch();
                                },
                                child: Text(loc.btnClearSearch),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    ...wills.map(
                      (will) => _WillListItemCard(
                        will: will,
                        loc: loc,
                        onEdit: () => context.go('/will/${will.id}'),
                        onDelete: () => _confirmDelete(context, will, loc),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WillListItemCard extends StatelessWidget {
  const _WillListItemCard({
    required this.will,
    required this.loc,
    required this.onEdit,
    required this.onDelete,
  });

  final Will will;
  final AppLocalizations loc;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final statusLabel = switch (will.status) {
      WillStatus.draft => loc.statusDraft,
      WillStatus.reviewed => loc.statusReviewed,
      WillStatus.finalized => loc.statusFinalized,
    };

    final statusColor = switch (will.status) {
      WillStatus.draft => SirajiColors.textSecondary,
      WillStatus.reviewed => SirajiColors.info,
      WillStatus.finalized => SirajiColors.success,
    };

    final dateStr = '${will.createdAt.day}/${will.createdAt.month}/${will.createdAt.year}';

    return Padding(
      padding: const EdgeInsets.only(bottom: SirajiSpacing.sm),
      child: SirajiCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SirajiColors.deepGreen.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.history_edu,
                    color: SirajiColors.deepGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: SirajiSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        will.testatorName,
                        style: SirajiTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: SirajiColors.deepGreen,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${loc.reportMetaDate}: $dateStr',
                        style: SirajiTypography.bodySmall.copyWith(
                          color: SirajiColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (will.bequestNotes != null && will.bequestNotes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                will.bequestNotes!,
                style: SirajiTypography.bodySmall.copyWith(color: SirajiColors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: loc.btnDeleteReport,
                  icon: const Icon(Icons.delete_outline, size: 20, color: SirajiColors.error),
                  onPressed: onDelete,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: Text(loc.btnEdit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
