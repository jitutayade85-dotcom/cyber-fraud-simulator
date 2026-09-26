import 'package:flutter/material.dart';
import 'models/scam_scenario.dart';
import 'screens/dashboard_screen.dart';
import 'screens/simulation_screen.dart';
import 'services/notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Background notifications aur tap action initialize karna
  await NotificationService.init((scamId) {
    // Jab user phone ke status bar me notification par tap karega, direct simulation screen khulegi
    final scam = appScams.firstWhere(
      (s) => s.id == scamId,
      orElse: () => appScams[0],
    );

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => SimulationScreen(scam: scam),
      ),
    );
  });

  runApp(const CyberSafeApp());
}

class CyberSafeApp extends StatelessWidget {
  const CyberSafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Cyber Safe CEP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F2942),
          primary: const Color(0xFF0F2942),
          secondary: const Color(0xFFC59B27),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF0F2942),
          foregroundColor: Colors.white,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
