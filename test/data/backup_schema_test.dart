import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/core/constants/app_constants.dart';

void main() {
  group('Backup Schema Tests', () {
    test('Backup schema version is defined and positive', () {
      expect(AppConstants.backupSchemaVersion, greaterThan(0));
      expect(AppConstants.backupFileExtension, '.siraji');
    });
  });
}
