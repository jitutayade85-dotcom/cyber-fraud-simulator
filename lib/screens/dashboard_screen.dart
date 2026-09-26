import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/scam_scenario.dart';
import '../services/certificate_service.dart';
import '../services/notification_service.dart';
import 'simulation_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int trappedCount = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      trappedCount = prefs.getInt('trapped_count') ?? 0;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    collegeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Vigilance Score Calculation
    int vigilanceScore = (100 - (trappedCount * 20)).clamp(20, 100);
    bool isVigilant = vigilanceScore >= 70;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CEP: Cyber Fraud Simulator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Cyber Safety Scorecard Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Cyber Vigilance Score',
                      style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$vigilanceScore%',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: isVigilant ? const Color(0xFF15803D) : const Color(0xFFDC2626),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isVigilant ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isVigilant ? 'Category: Cyber Vigilant' : 'Category: High Risk (Vulnerable)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isVigilant ? const Color(0xFF15803D) : const Color(0xFFDC2626),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Traps triggered without verification: $trappedCount',
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Instant Demo Trigger Button (For College Evaluator Presentation)
            ElevatedButton.icon(
              icon: const Icon(Icons.flash_on),
              label: const Text('Trigger Test Scam Notification (Demo)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC59B27),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                NotificationService.triggerDemoNow('elec_01');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Simulated alert triggered in notification bar!')),
                );
              },
            ),
            const SizedBox(height: 24),

            // 3. Manual Practice Scenarios List
            const Text(
              'Practice Scam Scenarios',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
            ),
            const SizedBox(height: 10),
            ...appScams.map((scam) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFEEF2F6),
                      child: Icon(
                        scam.type == 'upi'
                            ? Icons.currency_rupee
                            : scam.type == 'whatsapp'
                                ? Icons.chat
                                : Icons.message,
                        color: const Color(0xFF0F2942),
                      ),
                    ),
                    title: Text(scam.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    subtitle: Text(scam.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SimulationScreen(scam: scam)),
                      );
                    },
                  ),
                )),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // 4. Official Certificate Generator Form
            const Text(
              'Claim Official Certificate',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Student / Participant Full Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: collegeController,
              decoration: InputDecoration(
                labelText: 'College / School / Village Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Download Official Certificate (PDF)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F2942),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final studentName = nameController.text.trim();
                if (studentName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter student name first!')),
                  );
                  return;
                }

                final now = DateTime.now();
                final issueDate = '${now.day.toString().padLeft(2, '0')} ${_getMonthName(now.month)} ${now.year}';
                final verificationId = 'CEP-${now.year}-${now.millisecondsSinceEpoch.toString().substring(7)}';

                CertificateService.generateAndDownload(
                  studentName: studentName,
                  category: isVigilant ? 'Cyber Vigilant' : 'Trained Participant',
                  score: vigilanceScore,
                  verificationId: verificationId,
                  issueDate: issueDate,
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month - 1];
  }
}
