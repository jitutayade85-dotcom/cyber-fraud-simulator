import 'package:flutter/material.dart';
import '../models/scam_scenario.dart';

class FeedbackScreen extends StatelessWidget {
  final ScamScenario scam;
  final bool userSucceeded;

  const FeedbackScreen({super.key, required this.scam, required this.userSucceeded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis & Red Flags'),
        backgroundColor: userSucceeded ? Colors.green.shade800 : Colors.red.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: userSucceeded ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: userSucceeded ? Colors.green : Colors.red),
              ),
              child: Row(
                children: [
                  Icon(
                    userSucceeded ? Icons.check_circle : Icons.warning_rounded,
                    color: userSucceeded ? Colors.green : Colors.red,
                    size: 36,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      userSucceeded ? 'Great Job! You spotted the scam.' : 'Compromised! In real life you would lose funds.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: userSucceeded ? Colors.green.shade900 : Colors.red.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('🔍 How This Scam Works:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(scam.explanation, style: const TextStyle(fontSize: 14, height: 1.4)),
            const Divider(height: 32),
            const Text('⚡ Psychological Trigger:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Text(scam.urgencyTrigger, style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600)),
            const Divider(height: 32),
            const Text('🛡️ Golden Rule to Remember:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Text(scam.goldenRule, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F2942),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Dashboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
