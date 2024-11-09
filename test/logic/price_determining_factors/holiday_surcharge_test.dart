import 'package:flutter_test/flutter_test.dart';
import 'package:zooo_app/logic/price_determining_factors/adjustment_price_and_details.dart';
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

  group('HolidaySurcharge - resolvePrice', () {
    test('should add 200 to price and append details on holiday', () {
      final result = HolidaySurcharge(DateTime(2024, 1, 6)) // Saturday
          .resolvePrice(const AdjustmentPriceAndDetails(500, ''));
      expect(result.price, equals(700));
      expect(result.details, '休⽇料⾦適応,');
    });

    test('should add 200 to price with existing details', () {
      final result = HolidaySurcharge(DateTime(2024, 1, 6)) // Saturday
          .resolvePrice(const AdjustmentPriceAndDetails(400, 'ABC'));
      expect(result.price, equals(600));
      expect(result.details, 'ABC休⽇料⾦適応,');
    });
  });
}
