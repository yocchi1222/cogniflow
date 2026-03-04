import 'package:flutter/material.dart';

import 'app.dart';
import 'data/repositories/daily_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = DailyRepository();
  await repository.init();

  runApp(CogniflowApp(repository: repository));
}
