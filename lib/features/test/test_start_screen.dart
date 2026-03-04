import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/daily_repository.dart';

class TestStartScreen extends StatelessWidget {
  const TestStartScreen({super.key, required this.repository});

  final DailyRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Start')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('5つの短い課題で、今日のコンディションを測ります。'),
            const SizedBox(height: 16),
            const Text('所要時間: 約3〜5分'),
            const Spacer(),
            FilledButton(
              onPressed: () => context.go('/test-flow'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: const Text('テストを開始'),
            ),
          ],
        ),
      ),
    );
  }
}
