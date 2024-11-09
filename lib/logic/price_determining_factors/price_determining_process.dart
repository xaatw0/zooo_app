import 'adjustment_price_and_details.dart';

abstract class PriceDeterminingProcess {
  PriceDeterminingProcess? nextProcess;

  String get label;

  /// 現在の割引・割り増しが有効か
  bool isAvailable();

  /// 有効時に実行する割引・割り増しの処理
  AdjustmentPriceAndDetails resolvePrice(final AdjustmentPriceAndDetails value);

  int resolvePrice2(final int price);

  String proceedDetail(final String detail) {
    final newDetail = isAvailable() ? '$detail$label,' : detail;
    if (nextProcess != null) {
      return nextProcess!.proceedDetail(newDetail);
    }
    return newDetail;
  }

  PriceDeterminingProcess setNext(final PriceDeterminingProcess nextProcess) {
    assert(this.nextProcess == null, '1度しか設定できない');

    this.nextProcess = nextProcess;
    return nextProcess;
  }

  AdjustmentPriceAndDetails proceed(final AdjustmentPriceAndDetails value) {
    final newValue = isAvailable() ? resolvePrice(value) : value;
    if (nextProcess != null) {
      return nextProcess!.proceed(newValue);
    }
    return newValue;
  }

  int proceedPrice(final int price) {
    final newPrice = isAvailable() ? resolvePrice2(price) : price;
    if (nextProcess != null) {
      return nextProcess!.proceedPrice(newPrice);
    }
    return newPrice;
  }
}
