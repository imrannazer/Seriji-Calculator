import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/domain/models/share.dart';

void main() {
  group('Share Model Tests', () {
    test('Share percentage and fraction string formatting', () {
      const share = Share(
        heirId: 'h1',
        numerator: 1,
        denominator: 8,
        decimalValue: 0.125,
        shareType: ShareType.fixed,
      );

      expect(share.fractionString, '1/8');
      expect(share.percentageString, '12.50%');
      expect(share.shareType, ShareType.fixed);
    });

    test('Share.zero default values', () {
      expect(Share.zero.decimalValue, 0.0);
      expect(Share.zero.shareType, ShareType.excluded);
    });
  });
}
