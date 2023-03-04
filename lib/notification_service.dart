import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FLutterBoilerPlateNotificationService {
  static final FLutterBoilerPlateNotificationService
      _fLutterBoilerPlateNotificationService =
      FLutterBoilerPlateNotificationService._internal();

  factory FLutterBoilerPlateNotificationService() {
    return _fLutterBoilerPlateNotificationService;
  }

  FLutterBoilerPlateNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'Channel ID',
    'Channel Name',
    channelDescription: "Channel Description",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
    icon:
        '@mipmap/ic_launcher', // specify the small icon to be displayed in the notification bar
  );

  Future<void> showNotifications(String? title, String? body) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> scheduleNotifications() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "This is scheduled Notification",
        "This is scheduled Notification Body!",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showImageNotification(
      String imageUrl, String? title, String? body) async {
    Dio dio = Dio();
    Response<List<int>> response = await dio.post<List<int>>(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
      cancelToken: CancelToken(),
    );

    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.data!)),
      largeIcon:
          ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.data!)),
    );
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'ChannelName',
          channelDescription: "ChannelDescription",
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
          styleInformation: bigPictureStyleInformation,
        ),
      ),
    );
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

///[IF USER CLICKS NOTIFICATION AND WE WANT TO DO SOMETHING WITH IT WE CAN DO IT HERE]
///[THIS PROCESS NOTIFICATION WHEN APP IS IN TERMINATED STATE AND USER CLICKS AT NOTIFICATIN]
Future selectNotification(String? payload) async {
  if (payload != null) {}
}
