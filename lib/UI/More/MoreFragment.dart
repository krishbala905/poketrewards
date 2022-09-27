import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/UI/More/LanguageActivity.dart';
import 'package:poketrewards/UI/More/ChangePassword.dart';
import 'package:poketrewards/UI/More/History.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:xml2json/xml2json.dart';

import '../../Others/CommonBrowser.dart';
import 'Profile.dart';

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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Profile(),));
                },
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
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
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
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
                      context, MaterialPageRoute(builder: (context) => LanguageActivity(),));
                },
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
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
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
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
                  _launchEmail();
                },
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
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
                  showContactUSPopup(context);
                },
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
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
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CommonBrowser(PRIVACY_URL, privacy),));
                },
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
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

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CommonBrowser(TERMS_AND_CONDITION_URL, terms_cond),));
                },
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
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
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CommonBrowser(SUBSCRIBE_LOG_URL, terms_cond),));
                },
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
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
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
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

  _launchEmail() async {
    final Email email = Email(
      subject: emailContent,
      recipients: [contactEmail],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
  void showContactUSPopup(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,

      actions: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10,right:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Text(contactUs_content,style: TextStyle(fontSize: 15),),
                SizedBox(height: 35,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    // _launchFacebook();
                  },
                  child: Text(facebook,style: TextStyle(fontSize: 15),),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    shareEmailFunction();
                  },
                  child: Text(email,style: TextStyle(fontSize: 15),),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    _launchSMS();
                  },
                  child: Text(sms,style: TextStyle(fontSize: 15),),
                ),
                SizedBox(height: 25,),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:15.0),
          child: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(cancel,style: TextStyle(fontSize: 15),),
            ),
          ),
        )
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
  shareEmailFunction() async{
    final Email email = Email(
      subject: email_subject,
      isHTML: false,
      body: email_body,
    );

    await FlutterEmailSender.send(email);
  }
  _launchSMS() async{
    var smsUri = Uri.parse('sms:''?body= You gotta check out this awesome rewards app - Poket Rewards app. SO COOL! Get yours for FREE at https://poket.com/app');
    try {
      print(smsUri.toString());
      if (await canLaunchUrl(
        smsUri,
      )) {
        await launchUrl(smsUri);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Some error occured'),
        ),
      );
    }
  }
}

