import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/scam_scenario.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const String taskName = "randomScamNotificationTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final now = DateTime.now();
    // Subah 9 AM se raat 9 PM ke beech random notification
    if (now.hour >= 9 && now.hour <= 21) {
      if (Random().nextBool()) {
        final randomScam = appScams[Random().nextInt(appScams.length)];

        const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
          'scam_sim_channel',
          'Cyber Safety Alerts',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

        await flutterLocalNotificationsPlugin.show(
          Random().nextInt(1000),
          randomScam.title,
          randomScam.body,
          const NotificationDetails(android: androidDetails),
          payload: randomScam.id,
        );
      }
    }
    return Future.value(true);
  });
}

class NotificationService {
  static Future<void> init(Function(String scamId) onSelectNotification) async {
    const AndroidInitializationSettings initAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initAndroid),
      onDidReceiveNotificationResponse: (response) async {
        if (response.payload != null) {
          final prefs = await SharedPreferences.getInstance();
          int trapped = prefs.getInt('trapped_count') ?? 0;
          await prefs.setInt('trapped_count', trapped + 1);
          onSelectNotification(response.payload!);
        }
      },
    );

    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager().registerPeriodicTask(
      "periodic_scam_trigger",
      taskName,
      frequency: const Duration(hours: 2),
    );
  }

  static Future<void> triggerDemoNow(String scamId) async {
    final scam = appScams.firstWhere((s) => s.id == scamId);
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'scam_sim_channel',
      'Cyber Safety Alerts',
      importance: Importance.max,
      priority: Priority.high,
    );
    await flutterLocalNotificationsPlugin.show(
      101,
      scam.title,
      scam.body,
      const NotificationDetails(android: androidDetails),
      payload: scam.id,
    );
  }
}
