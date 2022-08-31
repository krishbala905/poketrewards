import 'package:flutter/material.dart';
import 'package:poketrewards/UI/SplashScreen.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:poketrewards/UI/Tabbar/Add/AddTab.dart';
import 'package:poketrewards/UI/Tabbar/Wallet/EWalletTab.dart';
import 'package:poketrewards/UI/Tabbar/More/MoreTab.dart';
import 'package:poketrewards/UI/Tabbar/Inbox/InboxTab.dart';
import 'package:poketrewards/UI/Tabbar/Catalogue/WhatsonTab.dart';
import '../../Others/LocalNotificationService.dart';
import '../../Others/CommonUtils.dart';
import '../Onboarding.dart';

class ConsumerTab extends StatefulWidget {
  const ConsumerTab({Key? key}) : super(key: key);

  @override
  State<ConsumerTab> createState() => _ConsumerTabState();

}

class _ConsumerTabState extends State<ConsumerTab> {
  int CurrentIndex  = 0;
  final Screens = [
    AddTab(),
    EwalletTab(),
    WhatsonTab(),
    InboxTab(),
    MoreTab(),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LocalNotificationService.initialize(context);

    //Foreground
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification!=null){

        try{
          Navigator.pushReplacement( context, MaterialPageRoute(builder:  (_) => SplashScreen()));
          }
        catch(e){
          debugPrint("FrgndExcep"+e.toString());
        }
      }
      LocalNotificationService.display(message);    });


    // BackGround
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {

        try {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SplashScreen()));
        }
        catch (e) {
          debugPrint("FrgndExcep" + e.toString());
        }
      }
    });


    WidgetsBinding.instance.addPostFrameCallback((_){
      // getInboxUnreadMessageCount();
    });
    hideKeyboard();

  }
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(


      body:Screens[CurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,

        type: BottomNavigationBarType.fixed,
        onTap: (index ) => setState(() =>
        CurrentIndex = index),

        currentIndex: CurrentIndex,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        selectedItemColor: corporateColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white70,

        unselectedLabelStyle: TextStyle(

          color: Colors.grey,
        ),
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/ic_add_normal.png',height: 25,width: 25,),
            label: 'Add',
            activeIcon:new Image.asset('assets/ic_add_over.png',height: 25,width: 25,),

          ),
          BottomNavigationBarItem(icon: Image.asset('assets/ic_wallet_normal.png',height: 25,width: 25,),
            label: 'E-Wallet',
            activeIcon:new Image.asset('assets/ic_wallet_over.png',height: 25,width: 25,),

          ),
          BottomNavigationBarItem(icon: Image.asset('assets/ic_catlogue_normal.png',height: 25,width: 25,),
            label: 'Whats On',
            activeIcon:new Image.asset('assets/ic_catlogue_over.png',height: 25,width: 25,),

          ),
          BottomNavigationBarItem(icon: Image.asset('assets/Notification.png',height: 25,width: 25,color: Colors.black54,),

            label: 'Notification',
            activeIcon:new Image.asset('assets/ic_inbox_over.png',height: 25,width: 25,),

          ),
          BottomNavigationBarItem(icon: Image.asset('assets/ic_more_normal.png',height: 25,width: 25,),
            label: 'More',
            activeIcon:new Image.asset('assets/ic_more_over.png',height: 25,width: 25,),
          ),
        ],
      ),
    ),
    );
  }
}
