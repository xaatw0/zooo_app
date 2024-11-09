import 'dart:convert';

///チケットの種類
enum FeeType {
  /// 通常
  normal,

  /// 特別
  special;
}

/// 顧客区分
enum AgeGroup {
  adult,
  child,
  senior;
}

/// ⼊園チケットの1人あたりの料金一覧
class EntryFee {
  final int adult;
  final int child;
  final int senior;

  EntryFee({required this.adult, required this.child, required this.senior});

  factory EntryFee.fromJson(Map<String, dynamic> json) {
    return EntryFee(
      adult: json['adult'],
      child: json['child'],
      senior: json['senior'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'child': child,
      'senior': senior,
    };
  }

  /// チケットの種類毎に対する⼊園チケットの料金一覧を取得する
  static Map<FeeType, EntryFee> loadJson(String jsonData) {
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final entryFeesData = decodedData['entryFees'] as Map<String, dynamic>;

    return {
      for (final feeType in FeeType.values)
        feeType: EntryFee.fromJson(entryFeesData[feeType.name]),
    };
  }
}
