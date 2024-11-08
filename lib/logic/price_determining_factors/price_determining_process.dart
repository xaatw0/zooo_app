import 'adjustment_price_and_details.dart';

abstract class PriceDeterminingProcess {
  PriceDeterminingProcess? nextProcess;

  /// 現在の割引・割り増しが有効か
  bool isAvailable();

  /// 有効時に実行する割引・割り増しの処理
  AdjustmentPriceAndDetails resolvePrice(final AdjustmentPriceAndDetails value);

  void setNext(final PriceDeterminingProcess? nextProcess) {
    assert(nextProcess == null, '1度しか設定できない');

    this.nextProcess = nextProcess;
  }

  AdjustmentPriceAndDetails proceed(final AdjustmentPriceAndDetails value) {
    final newValue = isAvailable() ? resolvePrice(value) : value;
    if (nextProcess != null) {
      return nextProcess!.proceed(newValue);
    }
    return newValue;
  }
}
