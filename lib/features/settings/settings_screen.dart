import 'package:flutter/material.dart';

import '../../core/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ListTile(
            title: Text('アプリ名'),
            subtitle: Text('Cogniflow (仮)'),
          ),
          SizedBox(height: 12),
          Card(
            color: Color(0xFFFFF4E5),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(disclaimerText),
            ),
          ),
        ],
      ),
    );
  }
}
