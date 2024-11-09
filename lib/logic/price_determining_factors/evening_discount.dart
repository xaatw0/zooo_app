import 'package:zooo_app/logic/price_determining_factors/price_determining_process.dart';

/// ⼣⽅料⾦ ⼣⽅17時以降は100円引きとする。
class EveningDiscount extends PriceDeterminingProcess {
  static const kHourOfBreakTime = 17;

  EveningDiscount(this.currentTime);

  final DateTime currentTime;

  @override
  bool isAvailable() {
    return kHourOfBreakTime <= currentTime.hour;
  }

  @override
  String get label => '夕方料金';

  @override
  int resolvePrice(int price) {
    return price - 100;
  }
}
