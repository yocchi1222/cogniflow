import '../../core/date_utils.dart';

class DailyNote {
  DailyNote({
    required this.date,
    required this.sleepHours,
    required this.mood,
    required this.note,
  });

  final DateTime date;
  final double sleepHours;
  final int mood;
  final String note;

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'sleepHours': sleepHours,
      'mood': mood,
      'note': note,
    };
  }

  factory DailyNote.fromMap(Map<dynamic, dynamic> map) {
    return DailyNote(
      date: normalizeDate(DateTime.parse(map['date'] as String)),
      sleepHours: (map['sleepHours'] as num).toDouble(),
      mood: map['mood'] as int,
      note: map['note'] as String,
    );
  }
}
