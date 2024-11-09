import 'package:flutter_test/flutter_test.dart';
import 'package:zooo_app/logic/price_determining_factors/group_discount.dart';

void main() {
  group('isAvailable', () {
    test('0大人 + 0子供*0.5 = 0', () {
      final groupDiscount = GroupDiscount(0, 0);
      expect(groupDiscount.isAvailable(), false);
    });

    test('8大人 + 3子供*0.5 = 9.5', () {
      final groupDiscount = GroupDiscount(8, 3);
      expect(groupDiscount.isAvailable(), false);
    });

    test('8大人 + 4子供*0.5 = 10.0', () {
      final groupDiscount = GroupDiscount(8, 4);
      expect(groupDiscount.isAvailable(), true);
    });

    test('8大人 + 5子供*0.5 = 10.5', () {
      final groupDiscount = GroupDiscount(8, 5);
      expect(groupDiscount.isAvailable(), true);
    });

    test('9大人 + 0子供*0.5 = 9.0', () {
      final groupDiscount = GroupDiscount(9, 0);
      expect(groupDiscount.isAvailable(), false);
    });

    test('10大人 + 0子供*0.5 = 10.0', () {
      final groupDiscount = GroupDiscount(10, 0);
      expect(groupDiscount.isAvailable(), true);
    });

    test('0大人 + 19子供*0.5 = 9.5', () {
      final groupDiscount = GroupDiscount(0, 19);
      expect(groupDiscount.isAvailable(), false);
    });

    test('0大人 + 20子供*0.5 = 10.0', () {
      final groupDiscount = GroupDiscount(0, 20);
      expect(groupDiscount.isAvailable(), true);
    });
  });

  group('resolvePrice', () {
    test('割引・割り増し', () {
      expect(
        GroupDiscount(8, 4).resolvePrice(100),
        90,
      );
    });
  });
}
