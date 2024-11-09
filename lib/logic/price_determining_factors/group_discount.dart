import 'package:zooo_app/logic/price_determining_factors/adjustment_price_and_details.dart';
import 'package:zooo_app/logic/price_determining_factors/price_determining_process.dart';

/// 団体割引 10⼈以上だと10%割引(⼦供は0.5⼈換算とする)
class GroupDiscount extends PriceDeterminingProcess {
  static const kMinimumNumberOfGroup = 10;

  GroupDiscount(this.numberOfAdult, this.numberOfChildren);

  final int numberOfAdult;
  final int numberOfChildren;

  @override
  bool isAvailable() {
    return kMinimumNumberOfGroup <= (numberOfAdult + numberOfChildren * 0.5);
  }

  @override
  AdjustmentPriceAndDetails resolvePrice(
      final AdjustmentPriceAndDetails value) {
    return AdjustmentPriceAndDetails(
        (value.price * 0.9).floor(), '${value.details}団体割引適応,');
  }

  @override
  String get label => '団体割引';

  @override
  int resolvePrice2(int price) {
    return (price * 0.9).floor();
  }
}
