import 'package:flutter_test/flutter_test.dart';
import 'package:zooo_app/logic/price_determining_factors/adjustment_price_and_details.dart';
import 'package:zooo_app/logic/price_determining_factors/evening_discount.dart';

void main() {
  test('isAvailable', () {
    expect(
      EveningDiscount(DateTime(2024, 1, 1, 10, 0, 0)).isAvailable(),
      isFalse,
    );
    expect(
      EveningDiscount(DateTime(2024, 1, 1, 16, 59, 59)).isAvailable(),
      isFalse,
    );

    // 17時以降に有効
    expect(
      EveningDiscount(DateTime(2024, 1, 1, 17, 0, 0)).isAvailable(),
      isTrue,
    );
    expect(
      EveningDiscount(DateTime(2024, 1, 1, 17, 0, 1)).isAvailable(),
      isTrue,
    );
    expect(
      EveningDiscount(DateTime(2024, 1, 1, 23, 59, 59)).isAvailable(),
      isTrue,
    );
  });
  group('resolvePrice', () {
    test('単体割引', () {
      final result = EveningDiscount(DateTime(2024, 1, 1, 17, 0, 0))
          .resolvePrice(const AdjustmentPriceAndDetails(500, ''));
      expect(result.price, equals(400));
      expect(result.details, '夕方料金適応,');
    });
    test('複数割引', () {
      final result = EveningDiscount(DateTime(2024, 1, 1, 17, 0, 0))
          .resolvePrice(const AdjustmentPriceAndDetails(400, 'ABC'));
      expect(result.price, equals(300));
      expect(result.details, 'ABC夕方料金適応,');
    });
  });
}
