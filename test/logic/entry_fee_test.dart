import 'package:flutter_test/flutter_test.dart';
import 'package:zooo_app/logic/entry_fee.dart';

main() {
  test('loadJson', () {
    const jsonData = '''
{
  "entryFees": {
    "normal": {
      "adult": 100,
      "child": 200,
      "senior": 300
    },
    "special": {
      "adult": 400,
      "child": 500,
      "senior": 600
    }
  }
}
''';
    final entryFees = EntryFee.loadJson(jsonData);

    expect(entryFees[FeeType.normal]!.adult, equals(100));
    expect(entryFees[FeeType.normal]!.child, equals(200));
    expect(entryFees[FeeType.normal]!.senior, equals(300));

    expect(entryFees[FeeType.special]!.adult, equals(400));
    expect(entryFees[FeeType.special]!.child, equals(500));
    expect(entryFees[FeeType.special]!.senior, equals(600));
  });
}
