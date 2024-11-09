import 'package:flutter_test/flutter_test.dart';
import 'package:zooo_app/logic/price_determining_factors/group_discount.dart';

void main() {
  group('proceedPrice', () {
    test('isAvailableが有効のため、割引あり', () {
      final result = GroupDiscount(8, 4).proceedPrice(100);
      expect(result, equals(90));
    });
    test('isAvailableが無効のため、割引なし', () {
      final result = GroupDiscount(0, 0).proceedPrice(100);
      expect(result, equals(100));
    });
  });
  group('proceedDetail', () {
    test('isAvailableが有効のため、割引あり', () {
      final result = GroupDiscount(8, 4).proceedDetail('');
      expect(result, equals('団体割引,'));
    });
    test('isAvailableが無効のため、割引なし', () {
      final result = GroupDiscount(0, 0).proceedDetail('');
      expect(result, equals(''));
    });

    test('他割引あり', () {
      final result = GroupDiscount(8, 4).proceedDetail('他割引,');
      expect(result, equals('他割引,団体割引,'));
    });
  });
}
