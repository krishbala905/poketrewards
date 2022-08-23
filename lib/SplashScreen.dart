import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Others/CommonUtils.dart';
import 'Others/Utils.dart';
import 'res/Colors.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils().getDeviceINFO();
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
