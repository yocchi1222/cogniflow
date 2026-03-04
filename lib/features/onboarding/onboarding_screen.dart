import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../data/repositories/daily_repository.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, required this.repository});

  final DailyRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cogniflowへようこそ')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '3〜5分で、今日の5領域コンディションをチェックします。',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Card(
              color: Color(0xFFFFF4E5),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(disclaimerText),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => context.go('/home'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: const Text('はじめる'),
            ),
          ],
        ),
      ),
    );
  }
}
