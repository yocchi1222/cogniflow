import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/date_utils.dart';
import '../../data/models/daily_session.dart';
import '../../data/repositories/daily_repository.dart';

class HistoryDetailScreen extends StatelessWidget {
  const HistoryDetailScreen({
    super.key,
    required this.repository,
    required this.session,
  });

  final DailyRepository repository;
  final DailySession session;

  @override
  Widget build(BuildContext context) {
    final note = repository.getNoteByDate(session.date);

    return Scaffold(
      appBar: AppBar(title: Text('Detail ${dateKey(session.date)}')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ...domainKeys.map(
            (key) => ListTile(
              title: Text(domainLabels[key] ?? key),
              trailing: Text('${session.scores[key]}'),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('睡眠時間'),
            trailing: Text(note != null ? '${note.sleepHours}h' : '-'),
          ),
          ListTile(
            title: const Text('気分'),
            trailing: Text(note != null ? '${note.mood}' : '-'),
          ),
          ListTile(
            title: const Text('メモ'),
            subtitle: Text(note?.note.isNotEmpty == true ? note!.note : 'なし'),
          ),
        ],
      ),
    );
  }
}
