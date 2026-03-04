import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../data/models/daily_session.dart';
import '../../data/repositories/daily_repository.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.repository, required this.session});

  final DailyRepository repository;
  final DailySession session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('今日のスコア', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...domainKeys.map(
            (key) => Card(
              child: ListTile(
                title: Text(domainLabels[key] ?? key),
                trailing: Text('${session.scores[key]}'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => context.go('/history'),
            child: const Text('履歴へ'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Homeへ戻る'),
          ),
        ],
      ),
    );
  }
}
