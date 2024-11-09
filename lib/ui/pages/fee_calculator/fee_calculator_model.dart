import 'package:zooo_app/logic/entry_fee.dart';

/// チケット販売オペレーター⽤⾦額計算プログラムのモデル
class FeeCalculatorModel {
  FeeCalculatorModel({
    required this.currentTime,
    required this.adultCount,
    required this.childCount,
    required this.seniorCount,
    required this.feeType,
  });

  /// 限定となる日時
  final DateTime currentTime;

  /// 大人の人数
  final int adultCount;

  /// 子供の人数
  final int childCount;

  /// シニアの人数
  final int seniorCount;

  /// チケットの種類
  FeeType feeType;

  factory FeeCalculatorModel.zero() {
    return FeeCalculatorModel(
      currentTime: DateTime.now(),
      adultCount: 0,
      childCount: 0,
      seniorCount: 0,
      feeType: FeeType.normal,
    );
  }

  FeeCalculatorModel copyWith({
    DateTime? currentTime,
    int? adultCount,
    int? childCount,
    int? seniorCount,
    FeeType? feeType,
  }) {
    return FeeCalculatorModel(
      currentTime: currentTime ?? this.currentTime,
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      seniorCount: seniorCount ?? this.seniorCount,
      feeType: feeType ?? this.feeType,
    );
  }
}
