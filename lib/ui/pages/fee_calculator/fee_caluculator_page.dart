import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zooo_app/gen/assets.gen.dart';
import 'package:zooo_app/logic/entry_fee.dart';
import 'package:zooo_app/ui/pages/fee_calculator/entry_fee_loader.dart';
import 'package:zooo_app/ui/pages/fee_calculator/fee_calculator_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// チケット販売オペレーター⽤⾦額計算プログラムの画面
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: CircleAvatar(
                  radius: 96,
                  backgroundImage: AssetImage(Assets.images.zoooLogo.path),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '現在日時:'
                  '${DateFormat.yMEd().format(ref.watch(feeCalculatorProviderProvider.select((e) => e.currentTime)))}'
                  ' ${DateFormat.Hm().format(ref.watch(feeCalculatorProviderProvider.select((e) => e.currentTime)))}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                    iconSize: 32,
                    onPressed: () => ref
                        .read(feeCalculatorProviderProvider.notifier)
                        .selectDateTime(context),
                    icon: const Icon(Icons.edit))
              ],
            ),
            _InputNumberOfPeopleTile(
                ageGroup: AgeGroup.adult,
                text:
                    '大人　: ${ref.watch(feeCalculatorProviderProvider.select((e) => e.adultCount))}名'),
            _InputNumberOfPeopleTile(
                ageGroup: AgeGroup.child,
                text:
                    '子供　: ${ref.watch(feeCalculatorProviderProvider.select((e) => e.childCount))}名'),
            _InputNumberOfPeopleTile(
                ageGroup: AgeGroup.senior,
                text:
                    'シニア: ${ref.watch(feeCalculatorProviderProvider.select((e) => e.seniorCount))}名'),
            const SizedBox(height: 16),
            SegmentedButton<FeeType>(
              segments: FeeType.values
                  .map((e) => ButtonSegment(value: e, label: Text(e.name)))
                  .toList(),
              selected: {
                ref.watch(
                    feeCalculatorProviderProvider.select((e) => e.feeType))
              },
              onSelectionChanged: (value) => ref
                  .read(feeCalculatorProviderProvider.notifier)
                  .changeFeeType(value.first),
            ),
            ref.watch(loadEntryFeeProvider).when(
                  error: (error, st) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (entryFee) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '販売合計⾦額: ${ref.watch(feeCalculatorProviderProvider.notifier).calcTotalSalesAmount(entryFee)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '⾦額変更前合計⾦額: ${ref.watch(feeCalculatorProviderProvider.notifier).calcTotalAmountBeforeAdjustmentMap(entryFee)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '⾦額変更明細: ${ref.watch(feeCalculatorProviderProvider.notifier).getAdjustmentDetails()}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(feeCalculatorProviderProvider.notifier).reset(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _InputNumberOfPeopleTile extends ConsumerWidget {
  const _InputNumberOfPeopleTile({
    super.key,
    required this.text,
    required this.ageGroup,
  });

  final String text;
  final AgeGroup ageGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(feeCalculatorProviderProvider.notifier);
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        IconButton(
          iconSize: 64,
          onPressed: () => notifier.increase(ageGroup),
          icon: const Icon(Icons.exposure_plus_1),
        ),
        const SizedBox(width: 32),
        IconButton(
          iconSize: 64,
          onPressed: () => notifier.decrease(ageGroup),
          icon: const Icon(Icons.exposure_minus_1_outlined),
        ),
      ],
    );
  }
}
