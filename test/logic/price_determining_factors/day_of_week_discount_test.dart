import 'package:flutter_test/flutter_test.dart';
import 'package:zooo_app/logic/price_determining_factors/day_of_week_discount.dart';

void main() {
  group('isAvailable', () {
    test('曜日の確認 ', () {
      expect(
        DayOfWeekDiscount(DateTime(2024, 1, 1)).isAvailable(), // 月曜日
        isTrue,
      );
      expect(DayOfWeekDiscount(DateTime(2024, 1, 2)).isAvailable(), isFalse);
      expect(DayOfWeekDiscount(DateTime(2024, 1, 3)).isAvailable(), isTrue);
      expect(DayOfWeekDiscount(DateTime(2024, 1, 4)).isAvailable(), isFalse);
      expect(DayOfWeekDiscount(DateTime(2024, 1, 5)).isAvailable(), isFalse);
      expect(DayOfWeekDiscount(DateTime(2024, 1, 6)).isAvailable(), isFalse);
      expect(DayOfWeekDiscount(DateTime(2024, 1, 7)).isAvailable(), isFalse);
    });
  });

  group('resolvePrice', () {
    test('割引・割り増し', () {
      expect(DayOfWeekDiscount(DateTime(2024, 1, 3)).resolvePrice(500), 400);
    });
  });
}
