import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poketrewards/Others/LanguageChangeProvider.dart';
import 'package:poketrewards/UI/ConsumerTab.dart';
import 'package:provider/provider.dart';


import '../Others/CommonUtils.dart';
import '../Others/Utils.dart';
import '../res/Colors.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:poketrewards/UI/Onboarding.dart';

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
    getToken();
    Utils().getDeviceINFO();
    hideKeyboard();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _setloadingPage();
    });

  }

  getToken() async {
    if (Platform.isAndroid) {
      CommonUtils.deviceToken = await FirebaseMessaging.instance.getToken();

    }
    else if (Platform.isIOS) {

      CommonUtils.deviceToken=await FirebaseMessaging.instance.getAPNSToken();
      if (CommonUtils.deviceToken == null) {
        CommonUtils.deviceToken = "NO PNS";
      }

    }
    debugPrint("DeviceToken:"+CommonUtils.deviceToken.toString());
  }

  _setloadingPage() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    //
    var alreadyLoggedIn=prefs.getString('alreadyLoggedIn');

    CommonUtils.consumerID =prefs.getString('consumerId');
    CommonUtils.consumerName=prefs.getString('consumerName');
    CommonUtils.consumerEmail=prefs.getString('consumerEmail');
    CommonUtils.deviceTokenID=prefs.getString('consumerDeviceTokenId');
    CommonUtils.APPLICATIONLANGUAGEID=prefs.getString('ApplicationLanguageId');
    print("langId:"+CommonUtils.APPLICATIONLANGUAGEID.toString());
    if(CommonUtils.APPLICATIONLANGUAGEID=="1"){
      CommonUtils.APPLICATIONLANGUAGECOUNTRY="en";
      context.read<LanguageChangeProvider>().changeLocale("en");
    }
    else if(CommonUtils.APPLICATIONLANGUAGEID=="2"){
      CommonUtils.APPLICATIONLANGUAGECOUNTRY="ja";
      context.read<LanguageChangeProvider>().changeLocale("ja");
    }

    else if(CommonUtils.APPLICATIONLANGUAGEID=="3"){
      CommonUtils.APPLICATIONLANGUAGECOUNTRY="cs";
      context.read<LanguageChangeProvider>().changeLocale("cs");
    }
    else if(CommonUtils.APPLICATIONLANGUAGEID=="4"){
      CommonUtils.APPLICATIONLANGUAGECOUNTRY="es";
      context.read<LanguageChangeProvider>().changeLocale("es");
    }
    else{
      CommonUtils.APPLICATIONLANGUAGECOUNTRY="en";
      context.read<LanguageChangeProvider>().changeLocale("en");
    }


    Timer(Duration(seconds: 3), () {
      if(alreadyLoggedIn==null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Onboarding()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ConsumerTab()));
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
                width: 800,
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
