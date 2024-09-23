import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/entities/chat_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/firebase_options.dart';
import 'package:hyella_telehealth/logic/bloc/chat_contact_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/schedule_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

class NotificationService {
  static final _instance = NotificationService._internal();
  static late BuildContext _context;

  NotificationService._internal();
  static NotificationService get instance {
    return _instance;
  }

  // final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  void init() async {
    // Initialize Flutter local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // You may set the permission requests to "provisional" which allows the user to choose what type
    // of notifications they would like to receive once the user receives a notification.
    final NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    /* // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    final fcmToken = await FirebaseMessaging.instance
        .getToken(vapidKey: "BKagOny0KF_2pCJQ3m....moL0ewzQ8rZu");
    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
    } */
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> setupFlutterNotifications() async {
    // Create the channel on Android devices.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // This will be triggered when app is in background or terminated
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('Handling a background message: ${message.messageId}');
  }

  initForegroundMessaging() {
    FirebaseMessaging.onMessage
        .listen(NotificationService.instance.foreGroundNotification);
  }

  foreGroundNotification(RemoteMessage message) async {
    setupFlutterNotifications();
    print('Received a message while in the foreground!');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    String? key = message.data['key'];

    if (notification != null) {
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, // Channel ID
                channel.name, // Channel name
                importance: Importance.max,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher',
                visibility: NotificationVisibility.public,
                timeoutAfter: 4000,
                fullScreenIntent: true,
                // if the notification is for a video call, set the ongoing to true
                ongoing: key == null
                    ? true
                    : (key == "video_call" || key == "videos_call")),
          ),
        );
      } else {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title ?? "",
          notification.body,
          const NotificationDetails(
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              subtitle: "",
            ),
          ),
        );
      }

      await handleNotificationIntents(message, false);
      // flutterLocalNotificationsPlugin.cancel(notification.hashCode);
    }
  }

  Future<void> handleNotificationIntents(
      RemoteMessage message, bool openingViaNotification) async {
    var data = message.data;
    var key = data['key'];

    if (key == "open_webview") {
      String title = data['title'];
      String url = data['url'];
      Navigator.pushNamed(_context, AppRoute.webView, arguments: {
        'url': url,
        'title': title,
      });

      return;
    }

    if (key == "app_l_upcoming") {
      // get new messages
      _context.read<ScheduleBloc>().add(LoadUpComingScheduleEvent());
      return;
    }

    if (key == "app_ls_upcoming") {
      // get new messages
      _context.read<ScheduleBloc>().add(LoadUpComingScheduleEvent());
      /* Provider.of<DoctorAppointmentProvider>(navigatorKey.currentContext!,
              listen: false)
          .getSchedules(); */
      return;
    }

    if (key == "msg_contact_list" || key == "msgs_contact_list") {
      // new message for patient
      // goto user chat screen
      var decoded = jsonDecode(data['data']);
      String channelId = decoded['channel_name'];
      String receiverName = decoded['sender_name'];
      String receiverId = decoded['sender_id'];
      String key = decoded['key'];

      // // get new list of chat heads
      _context.read<ChatContactBloc>().add(LoadContactListEvent());

      if (openingViaNotification) {
        User? appUser = Global.storageService.getAppUser();
        Navigator.pushNamed(
          _context,
          AppRoute.chat,
          arguments: ChatPageData(
            pid: appUser!.pid,
            picture: null,
            receiverName: receiverName,
            channelId: channelId,
            receiverId: receiverId,
            isDoctor: appUser.isStaff! > 0 ? true : false,
            key: key,
          ),
        );
      }
    }

    /* if (key == "video_call" || key == "videos_call") {
      var decoded = jsonDecode(data['data']);
      String channelId = decoded['chanel_name'];
      String receiverName = decoded['sender_name'];
      String receiverId = decoded['sender_id'];
      // GOTO answer or delcine video call page
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => AnswerDeclineCallPage(
            channelId: channelId,
            receiverName: receiverName,
            isDoctor: key == "videos_call",
            receiverId: receiverId,
          ),
          settings: RouteSettings(name: "answerDecline"),
        ),
      );
    } */

    /* if (key == 'user_mgt_home_info') {
      if (navigatorKey.currentContext != null) {
        Provider.of<AuthProvider>(navigatorKey.currentContext!, listen: false)
            .getUserData(false);
      }
    }

    if (key == 'user_mgts_home_info') {
      if (navigatorKey.currentContext != null) {
        Provider.of<AuthProvider>(navigatorKey.currentContext!, listen: false)
            .getUserData(true);
      }
    }
   */
  }
}
