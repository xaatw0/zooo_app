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
  String get label => '休⽇料⾦';

  @override
  int resolvePrice(int price) {
    return price + 200;
  }
}
