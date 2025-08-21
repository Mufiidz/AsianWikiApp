import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../model/asianwiki_type.dart';
import '../../model/notification_payload.dart';
import '../../model/person.dart' as model;
import '../../model/show.dart';
import '../../screens/detail/person/detail_person_screen.dart';
import '../../screens/detail/show/detail_show_screen.dart';
import '../../screens/webview/webview_screen.dart';
import '../../utils/export_utils.dart';
import '../env.dart';

abstract class NotificationService {
  Future<bool?> init();
  Future<void> showNotification(
    int id,
    String title,
    String body,
    NotificationDetails? notificationDetails, {
    NotificationPayload? payload,
  });
  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    tz.TZDateTime scheduledDate,
    NotificationDetails notificationDetails, {
    NotificationPayload? payload,
  });
  Future<void> cancelNotification(int id);
}

@Injectable(as: NotificationService)
class NotificationServiceImpl implements NotificationService {
  NotificationServiceImpl(this._flutterNotification);

  final FlutterLocalNotificationsPlugin _flutterNotification;

  @override
  Future<bool?> init() async {
    logger.d('NotificationService init');

    if (Platform.isIOS) {
      await _flutterNotification
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }

    if (Platform.isAndroid) {
      _flutterNotification
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIos =
        DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIos,
        );
    return await _flutterNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: _onNotificationBackground,
    );
  }

  void _onReceiveNotification(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    if (payload == null) return;

    final NotificationPayload(:String id, :AsianwikiType type) =
        NotificationPayloadMapper.fromJsonString(payload);

    final StatefulWidget screen = switch (type) {
      AsianwikiType.actress => DetailPersonScreen(person: model.Person(id: id)),
      AsianwikiType.drama ||
      AsianwikiType.movie => DetailShowScreen(drama: Show(id: id)),
      _ => WebviewScreen(url: '${Env.asianwikiUrl}/$id'),
    };

    AppRoute.to(screen);
  }

  @override
  Future<void> showNotification(
    int id,
    String title,
    String body,
    NotificationDetails? notificationDetails, {
    NotificationPayload? payload,
  }) => _flutterNotification.show(
    id,
    title,
    body,
    notificationDetails,
    payload: payload?.toJsonString(),
  );

  @override
  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    tz.TZDateTime scheduledDate,
    NotificationDetails notificationDetails, {
    NotificationPayload? payload,
  }) => _flutterNotification.zonedSchedule(
    id,
    title,
    body,
    scheduledDate,
    notificationDetails,
    payload: payload?.toJsonString(),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );

  @override
  Future<void> cancelNotification(int id) => _flutterNotification.cancel(id);
}

@pragma('vm:entry-point')
void _onNotificationBackground(NotificationResponse notificationResponse) {
  final String? payload = notificationResponse.payload;
  if (payload == null) return;

  final NotificationPayload(:String id, :AsianwikiType type) =
      NotificationPayloadMapper.fromJsonString(payload);

  final StatefulWidget screen = switch (type) {
    AsianwikiType.actress => DetailPersonScreen(person: model.Person(id: id)),
    AsianwikiType.drama ||
    AsianwikiType.movie => DetailShowScreen(drama: Show(id: id)),
    _ => WebviewScreen(url: '${Env.asianwikiUrl}/$id'),
  };

  AppRoute.to(screen);
}
