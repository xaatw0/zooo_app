import 'package:flutter/material.dart';
import 'package:zooo_app/gen/assets.gen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
              _InputNumberOfPeopleTile(text: '大人　: 0名'),
              _InputNumberOfPeopleTile(text: '子供　: 0名'),
              _InputNumberOfPeopleTile(text: 'シニア: 0名'),
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
      ),
    );
  }
}

class _InputNumberOfPeopleTile extends StatelessWidget {
  const _InputNumberOfPeopleTile({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
          icon: const Icon(Icons.exposure_plus_1),
        ),
        const SizedBox(width: 32),
        IconButton(
          iconSize: 64,
          onPressed: () {},
          icon: const Icon(Icons.exposure_minus_1_outlined),
        ),
      ],
    );
  }
}
