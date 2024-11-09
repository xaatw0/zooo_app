import 'package:zooo_app/logic/price_determining_factors/adjustment_price_and_details.dart';
import 'package:zooo_app/logic/price_determining_factors/price_determining_process.dart';

/// 休⽇料⾦休⽇は200円増とする。
class HolidaySurcharge extends PriceDeterminingProcess {
  HolidaySurcharge(this.currentTime);

  final DateTime currentTime;

  @override
  bool isAvailable() {
    return switch (currentTime.weekday) {
      DateTime.saturday || DateTime.sunday => true,
      _ => false,
    };
  }

  @override
  AdjustmentPriceAndDetails resolvePrice(AdjustmentPriceAndDetails value) {
    return AdjustmentPriceAndDetails(
      value.price + 200,
      '${value.details}休⽇料⾦適応,',
    );
  }

  @override
  String get label => '休⽇料⾦';

  @override
  int resolvePrice2(int price) {
    return price + 200;
  }
}
