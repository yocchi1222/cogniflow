import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/date_utils.dart';
import '../../data/models/daily_note.dart';
import '../../data/models/daily_session.dart';
import '../../data/repositories/daily_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.repository});

  final DailyRepository repository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _sleepController;
  late TextEditingController _noteController;
  int _mood = 0;

  @override
  void initState() {
    super.initState();
    _sleepController = TextEditingController(text: '7.0');
    _noteController = TextEditingController();

    final todayNote = widget.repository.getNoteByDate(DateTime.now());
    if (todayNote != null) {
      _sleepController.text = todayNote.sleepHours.toString();
      _noteController.text = todayNote.note;
      _mood = todayNote.mood;
    }
  }

  @override
  void dispose() {
    _sleepController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = widget.repository.getSessionByDate(DateTime.now());
    final previous = widget.repository.getPreviousSession(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            '今日: ${dateKey(DateTime.now())}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _SessionSummaryCard(today: today, previous: previous),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('今日のメモ', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _sleepController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: '睡眠時間 (h)'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    initialValue: _mood,
                    decoration: const InputDecoration(labelText: '気分 (-5〜+5)'),
                    items: List.generate(
                      11,
                      (index) {
                        final value = index - 5;
                        return DropdownMenuItem(value: value, child: Text('$value'));
                      },
                    ),
                    onChanged: (value) => setState(() => _mood = value ?? 0),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _noteController,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'ひとことメモ'),
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    onPressed: _saveNote,
                    child: const Text('メモを保存'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => context.go('/test-start'),
            style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
            child: const Text('今日のチェックを開始'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => context.go('/history'),
            child: const Text('履歴を見る'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => context.go('/settings'),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveNote() async {
    final sleep = double.tryParse(_sleepController.text) ?? 0;
    final note = DailyNote(
      date: normalizeDate(DateTime.now()),
      sleepHours: sleep,
      mood: _mood.clamp(-5, 5),
      note: _noteController.text.trim(),
    );

    await widget.repository.saveNote(note);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('メモを保存しました')),
    );
  }
}

class _SessionSummaryCard extends StatelessWidget {
  const _SessionSummaryCard({required this.today, required this.previous});

  final DailySession? today;
  final DailySession? previous;

  @override
  Widget build(BuildContext context) {
    if (today == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('まだ今日の結果がありません。'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('今日の結果', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...domainKeys.map(
              (key) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '${domainLabels[key]}: ${today!.scores[key]} ${_deltaSymbol(today!.scores[key]!, previous?.scores[key])}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _deltaSymbol(int current, int? previousValue) {
    if (previousValue == null) return '→';
    if (current > previousValue) return '↑';
    if (current < previousValue) return '↓';
    return '→';
  }
}
