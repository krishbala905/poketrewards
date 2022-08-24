import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poketrewards/SplashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:poketrewards/UI/Tabbar/ConsumerTab.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print('Handling a background message ${message.messageId}');
  if(message.contentAvailable){
    print('BackMessageRecieved');
  }

}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('-- WidgetsFlutterBinding.ensureInitialized');
  await Firebase.initializeApp();
  print('-- main: Firebase.initializeApp');
  if (Platform.isAndroid) {
    print("android");
    // Android-specific code
  } else if (Platform.isIOS) {
    print("ios");
    var iosToken=await FirebaseMessaging.instance.getAPNSToken();
    if (iosToken == null) {
      iosToken = "NO PNS";
    }
    print(iosToken);
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}



