import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/date_utils.dart';
import '../../data/repositories/daily_repository.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.repository});

  final DailyRepository repository;

  @override
  Widget build(BuildContext context) {
    final sessions = repository.getSessions();

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: sessions.isEmpty
          ? const Center(child: Text('まだ履歴がありません。'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                final total = session.scores.values.reduce((a, b) => a + b);
                final average = (total / session.scores.length).toStringAsFixed(1);
                return Card(
                  child: ListTile(
                    title: Text(dateKey(session.date)),
                    subtitle: Text('平均スコア: $average'),
                    onTap: () => context.go('/history-detail', extra: session),
                  ),
                );
              },
            ),
    );
  }
}
