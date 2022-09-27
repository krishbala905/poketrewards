import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/UI/More/ChangePassword.dart';
import 'package:poketrewards/UI/More/History.dart';
import 'package:poketrewards/UI/More/Language.dart';
import 'package:poketrewards/UI/More/Privacy.dart';
//import 'package:poketrewards/UI/More/Profile.dart';
import 'package:http/http.dart'as http;
import 'package:poketrewards/UI/More/Subscribe.dart';
import 'package:poketrewards/UI/More/Tellyourfriends.dart';
import 'package:poketrewards/UI/More/TermsandConditions.dart';
import 'package:poketrewards/UI/More/feadback.dart';
import 'package:poketrewards/UI/SplashScreen.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

//import '../../../res/Strings.dart';

class MoreFragment extends StatefulWidget {
  const MoreFragment({Key? key}) : super(key: key);

  @override
  State<MoreFragment> createState() => _MoreFragmentState();
}

class _MoreFragmentState extends State<MoreFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => Profile(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).profile, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => History(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).history, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Language(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).lang_uage, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ChangePassword(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).change_password, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Feadback(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).feed_back, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Tellyourfriends(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).tell_your_friends, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Privacy(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).privacy, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => TermsandConditions(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).termsandconditions, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Subscribe(),));
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).subscribe, style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context, true);
                  callSignoutAPi();
                },
                child: Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Text(S.of(context).signout + "  (" + CommonUtils.consumerEmail.toString() +
                              ")", style: TextStyle(
                              color: corporateColor, fontSize: 15),)),
                    )),
              ),
              Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
            ],
          )
        //  backgroundColor:  Colors.white54,
      ),
    );
  }
  Future<void> callSignoutAPi() async {
    print("url:" + LOGOUT_URL);

    final http.Response response = await http.post(
      Uri.parse(LOGOUT_URL),

      body: {
        "consumer_id": CommonUtils.consumerID,

      },
    ).timeout(Duration(seconds: 30));
    print(response.body.toString());
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = json.decode(jsonstring);
    print(data);
    var status="1";
    var msg = "You have signed out successfully";
    if (status == "1") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      print("hii");
      showAlertDialog_oneBtnDismiss(context, alert1, msg);
    }
    else {
      showAlertDialog_oneBtn(context, alert1, msg);
    }

  }
  void showAlertDialog_oneBtnDismiss(BuildContext context, String tittle,
      String message) {
    print("check");
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message, style: TextStyle(color: Colors.black45)),
      actions: <Widget>[
        TextButton(
          child: Text(ok,style: TextStyle(color: corporateColor)),
          onPressed: () {
            Navigator.pop(context, true);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                    SplashScreen()), (Route<dynamic> route) => false);

          },
        ),
        TextButton(
          child: Text(cancel,style: TextStyle(color: corporateColor)),
          onPressed: () {
            Navigator.pop(context,true);
          },
        ),
        /*GestureDetector(
          onTap: () {
            Navigator.pop(context, true);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                    SplashScreen()), (Route<dynamic> route) => false);
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child: Center(
                  child: Text(ok, style: TextStyle(color: corporateColor),)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context, true);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                    MoreFragment()), (Route<dynamic> route) => false);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child: Center(
                  child: Text(cancel, style: TextStyle(color: corporateColor),)),
            ),
          ),
        ),*/
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void dispose() {
    // TODO: implement dispose
    FocusScope.of(context).requestFocus(FocusNode());
    super.dispose();
  }
}

