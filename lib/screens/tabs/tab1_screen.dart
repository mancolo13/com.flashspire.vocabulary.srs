import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/routing_service.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({super.key});

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> {
  bool _flipped = false;
  int _cardIndex = 0;

  final cards = [
    {'word': 'Serendipity', 'phonetic': '/ˌser.ənˈdɪp.ə.t̬i/', 'def': 'The occurrence of events by chance in a happy or beneficial way.'},
    {'word': 'Ephemeral', 'phonetic': '/ɪˈfem.ər.əl/', 'def': 'Lasting for a very short time.'},
    {'word': 'Resilience', 'phonetic': '/rɪˈzɪl.jəns/', 'def': 'The capacity to recover quickly from difficulties.'},
  ];

  @override
  Widget build(BuildContext context) {
    final cur = cards[_cardIndex % cards.length];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlashSpire • SRS Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.stars_rounded, color: AppTheme.secondary),
            onPressed: () => RoutingService.openRegistrationUrl(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => setState(() => _flipped = !_flipped),
              child: Container(
                width: double.infinity,
                height: 220,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.primary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cur['word'] as String, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 6),
                    Text(cur['phonetic'] as String, style: const TextStyle(color: AppTheme.primary, fontSize: 14)),
                    if (_flipped) ...[
                      const Divider(color: Colors.white24, height: 28),
                      Text(cur['def'] as String, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ] else ...[
                      const SizedBox(height: 20),
                      const Text('(Tap card to reveal definition)', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() { _cardIndex++; _flipped = false; }),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                    child: const Text('Hard'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() { _cardIndex++; _flipped = false; }),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.black),
                    child: const Text('Easy (Passed)'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
