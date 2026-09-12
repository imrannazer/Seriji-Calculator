import 'dart:convert';
import '../../core/result/result.dart';
import '../../domain/models/calculation.dart';
import '../../domain/models/will.dart';
import '../../domain/repositories/calculation_repository.dart';
import '../../domain/repositories/will_repository.dart';

class BackupPreview {
  const BackupPreview({
    required this.calculationCount,
    required this.willCount,
    required this.exportedAt,
    required this.schemaVersion,
    required this.calculations,
    required this.wills,
  });

  final int calculationCount;
  final int willCount;
  final DateTime exportedAt;
  final int schemaVersion;
  final List<Calculation> calculations;
  final List<Will> wills;
}

class SirajiBackupService {
  SirajiBackupService({
    required CalculationRepository calculationRepository,
    required WillRepository willRepository,
  })  : _calcRepo = calculationRepository,
        _willRepo = willRepository;

  final CalculationRepository _calcRepo;
  final WillRepository _willRepo;

  static const String formatIdentifier = 'siraji';
  static const int currentSchemaVersion = 1;

  /// Generate JSON backup payload
  Future<Result<String>> generateBackupJson() async {
    try {
      final calcRes = await _calcRepo.getAllCalculations();
      final willRes = await _willRepo.getAllWills();

      final calculations = calcRes.valueOrNull ?? [];
      final wills = willRes.valueOrNull ?? [];

      final backupData = {
        'format': formatIdentifier,
        'schemaVersion': currentSchemaVersion,
        'exportedAt': DateTime.now().toIso8601String(),
        'calculations': calculations
            .map((c) => {
                  'id': c.id,
                  'title': c.title,
                  'createdAt': c.createdAt.toIso8601String(),
                  'updatedAt': c.updatedAt?.toIso8601String(),
                  'dataJson': c.dataJson,
                  'schemaVersion': c.schemaVersion,
                })
            .toList(),
        'wills': wills
            .map((w) => {
                  'id': w.id,
                  'testatorName': w.testatorName,
                  'createdAt': w.createdAt.toIso8601String(),
                  'updatedAt': w.updatedAt?.toIso8601String(),
                  'status': w.status.name,
                  'bequestNotes': w.bequestNotes,
                  'dataJson': w.dataJson,
                  'schemaVersion': w.schemaVersion,
                })
            .toList(),
      };

      final jsonStr = const JsonEncoder.withIndent('  ').convert(backupData);
      return Success(jsonStr);
    } catch (e) {
      return Failure('Failed to generate backup: $e');
    }
  }

  /// Validate imported JSON string and produce a preview
  Result<BackupPreview> validateImportJson(String jsonString) {
    try {
      if (jsonString.trim().isEmpty) {
        return const Failure('Backup file is empty.');
      }

      final dynamic parsed = jsonDecode(jsonString);
      if (parsed is! Map<String, dynamic>) {
        return const Failure('Invalid data format. File must contain a JSON object.');
      }

      if (parsed['format'] != formatIdentifier) {
        return const Failure('Unsupported file format. Not a valid Siraji backup file.');
      }

      final schemaVer = parsed['schemaVersion'];
      if (schemaVer is! int) {
        return const Failure('Malformed file. Missing schema version.');
      }

      if (schemaVer > currentSchemaVersion) {
        return Failure(
          'This backup was created with a newer version of Siraji (Schema v$schemaVer). Please update the application to import this file.',
        );
      }

      final exportedAtStr = parsed['exportedAt'] as String? ?? '';
      final exportedAt = DateTime.tryParse(exportedAtStr) ?? DateTime.now();

      final rawCalculations = parsed['calculations'] as List<dynamic>? ?? [];
      final rawWills = parsed['wills'] as List<dynamic>? ?? [];

      final validCalculations = <Calculation>[];
      for (final item in rawCalculations) {
        if (item is Map<String, dynamic>) {
          final id = item['id']?.toString() ?? '';
          final title = item['title']?.toString() ?? '';
          final createdAtStr = item['createdAt']?.toString() ?? '';
          final createdAt = DateTime.tryParse(createdAtStr) ?? DateTime.now();
          final updatedAtStr = item['updatedAt']?.toString();
          final updatedAt = updatedAtStr != null ? DateTime.tryParse(updatedAtStr) : null;
          final dataJson = item['dataJson']?.toString() ?? '{}';
          final sVer = item['schemaVersion'] is int ? item['schemaVersion'] as int : 1;

          if (id.isNotEmpty && title.isNotEmpty) {
            validCalculations.add(Calculation(
              id: id,
              title: title,
              createdAt: createdAt,
              updatedAt: updatedAt,
              dataJson: dataJson,
              schemaVersion: sVer,
            ));
          }
        }
      }

      final validWills = <Will>[];
      for (final item in rawWills) {
        if (item is Map<String, dynamic>) {
          final id = item['id']?.toString() ?? '';
          final testatorName = item['testatorName']?.toString() ?? '';
          final createdAtStr = item['createdAt']?.toString() ?? '';
          final createdAt = DateTime.tryParse(createdAtStr) ?? DateTime.now();
          final updatedAtStr = item['updatedAt']?.toString();
          final updatedAt = updatedAtStr != null ? DateTime.tryParse(updatedAtStr) : null;
          final statusStr = item['status']?.toString() ?? 'draft';
          final status = WillStatus.values.firstWhere(
            (s) => s.name == statusStr,
            orElse: () => WillStatus.draft,
          );
          final bequestNotes = item['bequestNotes']?.toString();
          final dataJson = item['dataJson']?.toString();
          final sVer = item['schemaVersion'] is int ? item['schemaVersion'] as int : 1;

          if (id.isNotEmpty && testatorName.isNotEmpty) {
            validWills.add(Will(
              id: id,
              testatorName: testatorName,
              createdAt: createdAt,
              updatedAt: updatedAt,
              status: status,
              bequestNotes: bequestNotes,
              dataJson: dataJson,
              schemaVersion: sVer,
            ));
          }
        }
      }

      return Success(BackupPreview(
        calculationCount: validCalculations.length,
        willCount: validWills.length,
        exportedAt: exportedAt,
        schemaVersion: schemaVer,
        calculations: validCalculations,
        wills: validWills,
      ));
    } catch (e) {
      return Failure('Corrupt backup file: $e');
    }
  }

  /// Execute restore from validated preview
  Future<Result<int>> restoreFromPreview(BackupPreview preview) async {
    try {
      int restoredCount = 0;

      for (final calc in preview.calculations) {
        final res = await _calcRepo.saveCalculation(calc);
        if (res.isSuccess) restoredCount++;
      }

      for (final will in preview.wills) {
        final res = await _willRepo.saveWill(will);
        if (res.isSuccess) restoredCount++;
      }

      return Success(restoredCount);
    } catch (e) {
      return Failure('Restore operation failed: $e');
    }
  }
}
