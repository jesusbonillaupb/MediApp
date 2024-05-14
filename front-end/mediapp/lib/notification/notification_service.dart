import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart'; 

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  // enviar notificacion instantanea
  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0, 
      title, 
      body, 
      notificationDetails
    );
  }

  // notificacion en una determinada fecha
  void scheduleNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    tz.initializeTimeZones(); 
     final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
      final tz.Location colombia = tz.getLocation('America/Bogota');
    // ignore: unused_local_variable
    final tz.TZDateTime agendadaEn = tz.TZDateTime(
    colombia, 2024, 5, 14, 0, 23, 0, 0,
    ); // año, mes, día, hora, minuto, segundo, microsegundo
    print(tz.TZDateTime.now(tz.local));
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        01,
        title,
        body,
       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 60)),
         notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: 'Ths s the data');
    
  }
  void stopNotifications() async{
    await _flutterLocalNotificationsPlugin.cancelAll();

  }
  
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }
  }

