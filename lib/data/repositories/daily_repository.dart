import 'package:hive_flutter/hive_flutter.dart';

import '../../core/date_utils.dart';
import '../models/daily_note.dart';
import '../models/daily_session.dart';

class DailyRepository {
  static const _sessionBoxName = 'daily_sessions';
  static const _noteBoxName = 'daily_notes';

  late Box<Map> _sessionBox;
  late Box<Map> _noteBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _sessionBox = await Hive.openBox<Map>(_sessionBoxName);
    _noteBox = await Hive.openBox<Map>(_noteBoxName);
  }

  Future<void> saveSession(DailySession session) async {
    await _sessionBox.put(dateKey(session.date), session.toMap());
  }

  Future<void> saveNote(DailyNote note) async {
    await _noteBox.put(dateKey(note.date), note.toMap());
  }

  DailySession? getSessionByDate(DateTime date) {
    final raw = _sessionBox.get(dateKey(date));
    if (raw == null) return null;
    return DailySession.fromMap(raw);
  }

  DailyNote? getNoteByDate(DateTime date) {
    final raw = _noteBox.get(dateKey(date));
    if (raw == null) return null;
    return DailyNote.fromMap(raw);
  }

  List<DailySession> getSessions() {
    final sessions = _sessionBox.values.map(DailySession.fromMap).toList();
    sessions.sort((a, b) => b.date.compareTo(a.date));
    return sessions;
  }

  DailySession? getPreviousSession(DateTime date) {
    final sessions = getSessions();
    for (final session in sessions) {
      if (session.date.isBefore(normalizeDate(date))) {
        return session;
      }
    }
    return null;
  }
}
