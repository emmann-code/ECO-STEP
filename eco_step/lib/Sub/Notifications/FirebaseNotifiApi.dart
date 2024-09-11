import 'package:eco_step/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FirebaseNotifiApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  FirebaseNotifiApi() {
    _initializeLocalNotifications();
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
    await initPushNotifications();
  }

  Future<void> _initializeLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
    tz.initializeTimeZones();
  }

  Future<void> scheduleDailyNotification({required String title, required String body}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      _nextInstanceOfDailyTime(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_tip_channel',
          'Daily Tips',
          channelDescription: 'Channel for daily tips notifications',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfDailyTime() {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 9); // Schedule at 9 AM daily
    return scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1)) : scheduledDate;
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      navigatorKey.currentState?.pushNamed('/notifi', arguments: message);
    }
  }

  Future<void> _onSelectNotification(NotificationResponse notificationResponse) async {
    navigatorKey.currentState?.pushNamed('/notifi');
  }
}
