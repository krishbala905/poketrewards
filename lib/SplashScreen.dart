import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Others/CommonUtils.dart';
import 'Others/Utils.dart';
import 'res/Colors.dart';
import 'dart:async';
import 'package:poketrewards/UI/MainLoginSignUpScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);





  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
   // getToken();
    Utils().getDeviceINFO();
    hideKeyboard();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _setloadingPage();
    });

  }

  // getToken() async {
  //   if (Platform.isAndroid) {
  //     CommonUtils.deviceToken = await FirebaseMessaging.instance.getToken();
  //
  //   }
  //   else if (Platform.isIOS) {
  //
  //     CommonUtils.deviceToken=await FirebaseMessaging.instance.getAPNSToken();
  //     if (CommonUtils.deviceToken == null) {
  //       CommonUtils.deviceToken = "NO PNS";
  //     }
  //
  //   }
  //   debugPrint("DeviceToken:"+CommonUtils.deviceToken.toString());
  // }

  _setloadingPage() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    //
    var alreadyLoggedIn=prefs.getString('alreadyLoggedIn');

    CommonUtils.consumerID =prefs.getString('consumerId');
    CommonUtils.consumerName=prefs.getString('consumerName');
    CommonUtils.consumerEmail=prefs.getString('consumerEmail');
    CommonUtils.deviceTokenID=prefs.getString('consumerDeviceTokenId');


    Timer(Duration(seconds: 3), () {
      if(alreadyLoggedIn==null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainLoginUi()));
      }
      else{
      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ConsumerTab()));
      }

    });
  }






  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                width: 600,
                //height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/splash.png',),
              ),
              SpinKitCircle(
                color: corporateColor,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
