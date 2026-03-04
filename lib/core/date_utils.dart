DateTime normalizeDate(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

String dateKey(DateTime value) {
  final normalized = normalizeDate(value);
  final month = normalized.month.toString().padLeft(2, '0');
  final day = normalized.day.toString().padLeft(2, '0');
  return '${normalized.year}-$month-$day';
}
