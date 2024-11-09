import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zooo_app/gen/assets.gen.dart';
import 'package:zooo_app/logic/entry_fee.dart';
import 'package:zooo_app/ui/pages/fee_calculator/fee_calculator_provider.dart';

/// チケット販売オペレーター⽤⾦額計算プログラムの画面
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 128,
                    backgroundImage: AssetImage(Assets.images.zoooLogo.path),
                  ),
                ),
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
              const SizedBox(height: 32),
              Text(
                '販売合計⾦額:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                '⾦額変更前合計⾦額:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                '⾦額変更明細',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              ref.read(feeCalculatorProviderProvider.notifier).reset(),
          child: const Icon(Icons.refresh),
        ),
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
