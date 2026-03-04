import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/date_utils.dart';
import '../../data/models/daily_session.dart';
import '../../data/repositories/daily_repository.dart';

class TestFlowScreen extends StatefulWidget {
  const TestFlowScreen({super.key, required this.repository});

  final DailyRepository repository;

  @override
  State<TestFlowScreen> createState() => _TestFlowScreenState();
}

class _TestFlowScreenState extends State<TestFlowScreen> {
  int _step = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Flow (ダミー)')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('ダミー課題 $_step / 5', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Phase 1では課題は未実装です。\n「次へ」で進みます。'),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () async {
                if (_step < 5) {
                  setState(() => _step++);
                  return;
                }

                final session = _createDummySession();
                await widget.repository.saveSession(session);

                if (!context.mounted) return;
                context.go('/result', extra: session);
              },
              style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: Text(_step < 5 ? '次へ' : '結果を見る'),
            ),
          ],
        ),
      ),
    );
  }

  DailySession _createDummySession() {
    final random = Random();
    return DailySession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: normalizeDate(DateTime.now()),
      scores: {for (final key in domainKeys) key: 50 + random.nextInt(51)},
      createdAt: DateTime.now(),
    );
  }
}
