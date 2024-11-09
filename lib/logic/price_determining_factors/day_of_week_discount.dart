import 'package:zooo_app/logic/price_determining_factors/adjustment_price_and_details.dart';
import 'package:zooo_app/logic/price_determining_factors/price_determining_process.dart';

/// ⽉⽔割引⽉曜と⽔曜は100円引きとする。
class DayOfWeekDiscount extends PriceDeterminingProcess {
  DayOfWeekDiscount(this.currentTime);

  final DateTime currentTime;

  @override
  bool isAvailable() {
    return switch (currentTime.weekday) {
      DateTime.monday || DateTime.wednesday => true,
      _ => false,
    };
  }

  @override
  AdjustmentPriceAndDetails resolvePrice(AdjustmentPriceAndDetails value) {
    return AdjustmentPriceAndDetails(
      value.price - 100,
      '${value.details}⽉⽔割引適応,',
    );
  }
}
