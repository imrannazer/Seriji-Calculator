import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../data/backup/siraji_backup_service.dart';
import '../../../data/repositories/calculation_repository_impl.dart';
import '../../../domain/repositories/will_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';
import '../../../widgets/siraji_text_field.dart';
import '../../reports/providers/reports_provider.dart';
import '../../will/providers/will_provider.dart';

class SettingsDataScreen extends StatefulWidget {
  const SettingsDataScreen({super.key});

  @override
  State<SettingsDataScreen> createState() => _SettingsDataScreenState();
}

class _SettingsDataScreenState extends State<SettingsDataScreen> {
  bool _isExporting = false;

  Future<void> _exportBackup(BuildContext context, AppLocalizations loc) async {
    setState(() => _isExporting = true);
    final calcRepo = context.read<CalculationRepositoryImpl?>();
    final willRepo = context.read<WillRepository?>();
    final messenger = ScaffoldMessenger.of(context);

    if (calcRepo != null && willRepo != null) {
      final service = SirajiBackupService(
        calculationRepository: calcRepo,
        willRepository: willRepo,
      );

      final res = await service.generateBackupJson();
      if (res.isSuccess) {
        final jsonString = res.valueOrNull ?? '{}';
        await Share.share(
          jsonString,
          subject: 'Siraji_Backup_${DateTime.now().millisecondsSinceEpoch}.siraji.json',
        );

        messenger.showSnackBar(
          SnackBar(
            content: Text(loc.toastExportSuccess),
            backgroundColor: SirajiColors.success,
          ),
        );
      }
    }

    if (mounted) {
      setState(() => _isExporting = false);
    }
  }

  Future<void> _promptImportBackup(BuildContext context, AppLocalizations loc) async {
    final calcRepo = context.read<CalculationRepositoryImpl?>();
    final willRepo = context.read<WillRepository?>();
    final reportsProvider = context.read<ReportsProvider>();
    final willProvider = context.read<WillProvider>();
    final messenger = ScaffoldMessenger.of(context);

    if (calcRepo == null || willRepo == null) return;

    final inputController = TextEditingController();

    final inputConfirmed = await showDialog<String?>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          loc.settingsDataImport,
          style: SirajiTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: SirajiColors.deepGreen,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.settingsDataImportDesc,
              style: SirajiTypography.bodySmall,
            ),
            const SizedBox(height: 12),
            SirajiTextField(
              label: '',
              hint: 'Paste .siraji.json content here...',
              controller: inputController,
              maxLines: 5,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: Text(loc.dialogDeleteCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: SirajiColors.deepGreen),
            onPressed: () => Navigator.of(ctx).pop(inputController.text.trim()),
            child: Text(loc.btnNext),
          ),
        ],
      ),
    );

    if (inputConfirmed == null || inputConfirmed.isEmpty) return;

    final service = SirajiBackupService(
      calculationRepository: calcRepo,
      willRepository: willRepo,
    );

    final validationRes = service.validateImportJson(inputConfirmed);

    if (validationRes.isFailure) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('${loc.errorImportFailed}: ${validationRes.errorOrNull}'),
          backgroundColor: SirajiColors.error,
        ),
      );
      return;
    }

    final preview = validationRes.valueOrNull!;

    if (!context.mounted) return;

    // Show Preview Dialog before executing restore
    final proceed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.inventory_2_outlined, color: SirajiColors.deepGreen, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                loc.dialogImportPreviewTitle,
                style: SirajiTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SirajiColors.deepGreen,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.dialogImportPreviewDesc, style: SirajiTypography.bodySmall),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: SirajiColors.gold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: SirajiColors.gold),
              ),
              child: Column(
                children: [
                  _PreviewRow(label: loc.importPreviewCalculations, count: preview.calculationCount),
                  const Divider(height: 12),
                  _PreviewRow(label: loc.importPreviewWills, count: preview.willCount),
                  const Divider(height: 12),
                  _PreviewRow(label: loc.importPreviewSchema, count: preview.schemaVersion),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(loc.dialogDeleteCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: SirajiColors.deepGreen),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(loc.btnConfirmImport),
          ),
        ],
      ),
    );

    if (proceed == true) {
      final restoreRes = await service.restoreFromPreview(preview);
      if (restoreRes.isSuccess) {
        await reportsProvider.loadCalculations();
        await willProvider.loadWills();

        messenger.showSnackBar(
          SnackBar(
            content: Text(loc.toastImportSuccess),
            backgroundColor: SirajiColors.success,
          ),
        );
      }
    }
  }

  Future<void> _confirmClearAll(BuildContext context, AppLocalizations loc) async {
    final calcRepo = context.read<CalculationRepositoryImpl?>();
    final willRepo = context.read<WillRepository?>();
    final reportsProvider = context.read<ReportsProvider>();
    final willProvider = context.read<WillProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.delete_forever, color: SirajiColors.error, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                loc.dialogClearDataTitle,
                style: SirajiTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SirajiColors.deepGreen,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          loc.dialogClearDataMessage,
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
            child: Text(loc.dialogClearDataConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true && calcRepo != null && willRepo != null) {
      await calcRepo.deleteAllCalculations();
      await willRepo.deleteAllWills();
      await reportsProvider.loadCalculations();
      await willProvider.loadWills();

      messenger.showSnackBar(
        SnackBar(
          content: Text(loc.toastClearedSuccess),
          backgroundColor: SirajiColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return SirajiScaffold(
      title: loc.settingsData,
      titleIcon: Icons.storage_outlined,
      currentNavIndex: 4,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: SirajiSpacing.pagePadding,
          right: SirajiSpacing.pagePadding,
          top: SirajiSpacing.md,
          bottom: SirajiSpacing.footerHeight + SirajiSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Storage Privacy Banner
                Container(
                  padding: const EdgeInsets.all(SirajiSpacing.md),
                  decoration: BoxDecoration(
                    color: SirajiColors.gold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: SirajiColors.gold),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.shield_outlined, color: SirajiColors.deepGold, size: 26),
                      const SizedBox(width: SirajiSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.settingsDataStorageTitle,
                              style: SirajiTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: SirajiColors.deepGreen,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              loc.settingsDataStorageDesc,
                              style: SirajiTypography.bodySmall.copyWith(
                                color: SirajiColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),

                // 2. Data Actions (Export, Import, Clear)
                SirajiCard(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: SirajiColors.deepGreen.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.file_download_outlined, color: SirajiColors.deepGreen),
                        ),
                        title: Text(
                          loc.settingsDataExport,
                          style: SirajiTypography.titleMedium.copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          loc.settingsDataExportDesc,
                          style: SirajiTypography.bodySmall.copyWith(color: SirajiColors.textSecondary),
                        ),
                        trailing: _isExporting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: SirajiColors.deepGreen),
                              )
                            : const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: _isExporting ? null : () => _exportBackup(context, loc),
                      ),
                      const Divider(height: 24),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: SirajiColors.deepGold.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.file_upload_outlined, color: SirajiColors.deepGold),
                        ),
                        title: Text(
                          loc.settingsDataImport,
                          style: SirajiTypography.titleMedium.copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          loc.settingsDataImportDesc,
                          style: SirajiTypography.bodySmall.copyWith(color: SirajiColors.textSecondary),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () => _promptImportBackup(context, loc),
                      ),
                      const Divider(height: 24),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: SirajiColors.error.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.delete_forever, color: SirajiColors.error),
                        ),
                        title: Text(
                          loc.settingsDataClearAll,
                          style: SirajiTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: SirajiColors.error,
                          ),
                        ),
                        subtitle: Text(
                          loc.settingsDataClearAllDesc,
                          style: SirajiTypography.bodySmall.copyWith(color: SirajiColors.textSecondary),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: SirajiColors.error),
                        onTap: () => _confirmClearAll(context, loc),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.lg),
                SirajiButton(
                  label: loc.btnBack,
                  variant: SirajiButtonVariant.secondary,
                  fullWidth: true,
                  onPressed: () => context.go(RouteNames.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({required this.label, required this.count});
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: SirajiTypography.bodySmall),
        Text(
          count.toString(),
          style: SirajiTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: SirajiColors.deepGreen,
          ),
        ),
      ],
    );
  }
}
