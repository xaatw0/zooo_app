/// 各種割引・割り増し処理のベースクラス。Chain of Responsibility パターンを使用
abstract class PriceDeterminingProcess {
  PriceDeterminingProcess? nextProcess;

  String get label;

  /// 現在の割引・割り増しが有効か
  bool isAvailable();

  /// 有効時に実行する割引・割り増しの処理
  int resolvePrice(final int price);

  PriceDeterminingProcess setNext(final PriceDeterminingProcess nextProcess) {
    assert(this.nextProcess == null, '1度しか設定できない');

    this.nextProcess = nextProcess;
    return nextProcess;
  }

  int proceedPrice(final int price) {
    final newPrice = isAvailable() ? resolvePrice(price) : price;
    if (nextProcess != null) {
      return nextProcess!.proceedPrice(newPrice);
    }
    return newPrice;
  }

  String proceedDetail(final String detail) {
    final newDetail = isAvailable() ? '$detail$label,' : detail;
    if (nextProcess != null) {
      return nextProcess!.proceedDetail(newDetail);
    }
    return newDetail;
  }
}
