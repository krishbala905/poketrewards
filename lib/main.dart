import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/LanguageChangeProvider.dart';
import 'package:poketrewards/UI/SplashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:poketrewards/UI/LanguageActivity.dart';
import 'package:poketrewards/UI/Onboarding.dart';
import 'package:poketrewards/UI/Tabbar/ConsumerTab.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp( {Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context)=> LanguageChangeProvider(),
       child: Builder(
         builder: (context)=>
          MaterialApp(
    locale: Provider.of<LanguageChangeProvider>(context,listen: true).currentLocale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,

           title: 'Flutter Demo',
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
            home: const SplashScreen(),
      ),
       ),
    );
  }
}



