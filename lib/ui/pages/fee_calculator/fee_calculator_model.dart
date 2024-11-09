/// チケット販売オペレーター⽤⾦額計算プログラムのモデル
class FeeCalculatorModel {
  FeeCalculatorModel({
    required this.currentTime,
    required this.adultCount,
    required this.childCount,
    required this.seniorCount,
  });

  final DateTime currentTime;

  /// 大人の人数
  final int adultCount;

  /// 子供の人数
  final int childCount;

  /// シニアの人数
  final int seniorCount;

  factory FeeCalculatorModel.zero() {
    return FeeCalculatorModel(
      currentTime: DateTime.now(),
      adultCount: 0,
      childCount: 0,
      seniorCount: 0,
    );
  }

  FeeCalculatorModel copyWith({
    DateTime? currentTime,
    int? adultCount,
    int? childCount,
    int? seniorCount,
  }) {
    return FeeCalculatorModel(
      currentTime: currentTime ?? this.currentTime,
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      seniorCount: seniorCount ?? this.seniorCount,
    );
  }
}
