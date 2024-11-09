import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../gen/assets.gen.dart';
import '../../../logic/entry_fee.dart';

part 'entry_fee_loader.g.dart';

@riverpod
Future<Map<FeeType, EntryFee>> loadEntryFee(Ref ref) async {
  final jsonData = rootBundle.loadString(Assets.data.entryFee);
  return EntryFee.loadJson(await jsonData);
}
