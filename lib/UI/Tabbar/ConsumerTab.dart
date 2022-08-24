import 'package:flutter/material.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:poketrewards/UI/Tabbar/AddTab.dart';
import 'package:poketrewards/UI/Tabbar/EWalletTab.dart';
import 'package:poketrewards/UI/Tabbar/MoreTab.dart';
import 'package:poketrewards/UI/Tabbar/NotificationTab.dart';
import 'package:poketrewards/UI/Tabbar/WatsonTab.dart';
import '../../Others/LocalNotificationService.dart';
import '../../Others/CommonUtils.dart';
import '../MainLoginSignUpScreen.dart';

class ConsumerTab extends StatefulWidget {
  const ConsumerTab({Key? key}) : super(key: key);

  @override
  State<ConsumerTab> createState() => _ConsumerTabState();
  getData(){
    showToast("Notification Recieved");
  }
}

class _ConsumerTabState extends State<ConsumerTab> {
  int CurrentIndex  = 0;
  final Screens = [
    AddTab(),
    EwalletTab(),
    WatsonTab(),
    NotificationTab(),
    MoreTab(),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // String navigatePath=callPPNAPI(context).toString();
    // changeToPage(navigatePath);
    // terminated state;
    LocalNotificationService.initialize(context);


    // Foreground
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification!=null){
        print("Frgnd"+message.notification!.title.toString());
        try{
          Navigator.pushReplacement( context, MaterialPageRoute(builder:  (_) => MainLoginUi()));
          /*String navigatePath=callPPNAPI(context).toString();
          changeToPage(navigatePath);
        */}
        catch(e){
          debugPrint("FrgndExcep"+e.toString());
        }
      }
      LocalNotificationService.display(message);    });


    // BackGround
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        print("Bckgnd" + message.notification!.title.toString());
        try {
          Navigator.pushReplacement( context, MaterialPageRoute(builder:  (_) => MainLoginUi()));
          /*String navigatePath=callPPNAPI(context).toString();
          changeToPage(navigatePath);
        */}
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
        selectedFontSize: 10,
        unselectedFontSize: 08,
        showUnselectedLabels: true,
        selectedItemColor: PoketMaincolo,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white70,

        unselectedLabelStyle: TextStyle(

          color: Colors.grey,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add_rounded),
            label: 'Add',


          ),
          BottomNavigationBarItem(icon: Icon(Icons.wallet),
            label: 'E-Wallet',


          ),
          BottomNavigationBarItem(icon: Icon(Icons.category_rounded),
            label: 'Whats On',


          ),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),
            label: 'Notifiction',


          ),
          BottomNavigationBarItem(icon: Icon(Icons.more),
            label: 'More',


          ),
        ],
      ),
    ),
    );
  }
}
