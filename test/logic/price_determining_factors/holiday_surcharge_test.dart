import 'package:flutter_test/flutter_test.dart';
import 'package:zooo_app/logic/price_determining_factors/holiday_surcharge.dart';

void main() {
  group('HolidaySurcharge - isAvailable', () {
    test('月-金曜日', () {
      for (int i = 1; i < 6; i++) {
        final surcharge = HolidaySurcharge(DateTime(2024, 1, i)); // Friday
        expect(surcharge.isAvailable(), isFalse);
      }
    });

    test('土曜日', () {
      final surcharge = HolidaySurcharge(DateTime(2024, 1, 6)); // Saturday
      expect(surcharge.isAvailable(), isTrue);
    });

    test('日曜日', () {
      final surcharge = HolidaySurcharge(DateTime(2024, 1, 7)); // Sunday
      expect(surcharge.isAvailable(), isTrue);
    });
  });

  group('resolvePrice', () {
    test('割引・割り増し', () {
      expect(
        HolidaySurcharge(DateTime(2024, 1, 6)).resolvePrice(500),
        700,
      );

      expect(
        HolidaySurcharge(DateTime(2024, 1, 6)).resolvePrice(400),
        600,
      );
    });
  });
}
