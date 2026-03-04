import '../../core/constants.dart';
import '../../core/date_utils.dart';

class DailySession {
  DailySession({
    required this.id,
    required this.date,
    required this.scores,
    required this.createdAt,
  });

  final String id;
  final DateTime date;
  final Map<String, int> scores;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'scores': scores,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DailySession.fromMap(Map<dynamic, dynamic> map) {
    final rawScores = (map['scores'] as Map).cast<String, dynamic>();

    final normalizedScores = <String, int>{
      for (final key in domainKeys) key: (rawScores[key] ?? 0) as int,
    };

    return DailySession(
      id: map['id'] as String,
      date: normalizeDate(DateTime.parse(map['date'] as String)),
      scores: normalizedScores,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
