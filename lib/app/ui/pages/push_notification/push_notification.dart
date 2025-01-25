// import 'package:final_tpc_app/app/services/notification_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// // import 'dart:convert';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   @override
//   void initState() {
//     super.initState();
//     _initializeFirebaseMessaging();
//   }

//   Future<void> _initializeFirebaseMessaging() async {
//     // Request permissions for iOS
//     await _firebaseMessaging.requestPermission();

//     // Get the token (for sending notifications from backend)
//     String? token = await _firebaseMessaging.getToken();
//     print("Firebase Messaging Token: $token");

//     // Handle foreground notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         print('Notification Title: ${message.notification!.title}');
//         print('Notification Body: ${message.notification!.body}');
//       }
//     });

//     // Handle background and terminated notifications
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Notification clicked!');
//       // You can handle navigation when the notification is clicked
//     });

//     // Get initial message when the app is terminated
//     RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
//     if (initialMessage != null) {
//       print('Initial notification: ${initialMessage.notification!.title}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Notifications'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // Get the device token and tripId
//             String? deviceToken = await _firebaseMessaging.getToken();
//             String tripId = '12345'; // Example tripId

//             // Call sendNotifications
//             if (deviceToken != null) {
//               NotificationService.sendNotifications(deviceToken, context, tripId);
//             } else {
//               print("Failed to get device token");
//             }
//           },
//           child: Text('Send Notification'),
//         ),
//       ),
//     );
//   }
// }
