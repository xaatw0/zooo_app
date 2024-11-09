/// チケット販売オペレーター⽤⾦額計算プログラムのモデル
class FeeCalculatorModel {
  FeeCalculatorModel({
    required this.adultCount,
    required this.childCount,
    required this.seniorCount,
  });

  /// 大人の人数
  final int adultCount;

  /// 子供の人数
  final int childCount;

  /// シニアの人数
  final int seniorCount;

  factory FeeCalculatorModel.zero() {
    return FeeCalculatorModel(adultCount: 0, childCount: 0, seniorCount: 0);
  }

  FeeCalculatorModel copyWith({
    int? adultCount,
    int? childCount,
    int? seniorCount,
  }) {
    return FeeCalculatorModel(
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      seniorCount: seniorCount ?? this.seniorCount,
    );
  }
}
