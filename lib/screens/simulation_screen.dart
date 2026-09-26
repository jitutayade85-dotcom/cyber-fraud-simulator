import 'package:flutter/material.dart';
import '../models/scam_scenario.dart';
import 'feedback_screen.dart';

class SimulationScreen extends StatefulWidget {
  final ScamScenario scam;
  const SimulationScreen({super.key, required this.scam});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  bool inspectedUrl = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.scam.title),
        backgroundColor: const Color(0xFF0F2942),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Realistic Phone Screen Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.indigo.shade100,
                          child: Icon(
                            widget.scam.type == 'upi'
                                ? Icons.account_balance_wallet
                                : widget.scam.type == 'whatsapp'
                                    ? Icons.chat
                                    : Icons.sms,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.scam.sender, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text('Incoming ${widget.scam.type.toUpperCase()}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Text(
                      widget.scam.body,
                      style: const TextStyle(fontSize: 15, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    if (widget.scam.fakeUrl != 'None (Direct Call Trap)')
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.link, color: Colors.blue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                inspectedUrl ? '⚠️ Real Destination: ${widget.scam.fakeUrl}' : 'Tap inspect button below to verify link',
                                style: TextStyle(
                                  color: inspectedUrl ? Colors.red : Colors.blue,
                                  fontWeight: inspectedUrl ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Inspection Tool Button
            OutlinedButton.icon(
              icon: const Icon(Icons.search),
              label: Text(inspectedUrl ? 'URL Inspected' : 'Inspect Link & Sender Details'),
              onPressed: () {
                setState(() => inspectedUrl = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Inspecting domain: ${widget.scam.fakeUrl}')),
                );
              },
            ),

            const Spacer(),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      // User fell into trap
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FeedbackScreen(scam: widget.scam, userSucceeded: false),
                        ),
                      );
                    },
                    child: const Text('Proceed / Safe'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      // User correctly spotted fraud
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FeedbackScreen(scam: widget.scam, userSucceeded: true),
                        ),
                      );
                    },
                    child: const Text('Report Fraud 🚨'),
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
