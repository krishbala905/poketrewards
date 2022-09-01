import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poketrewards/UI/Login.dart';
import 'package:poketrewards/UI/SignupScreen.dart';
import 'package:poketrewards/UI/LanguageActivity.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/Strings.dart';

class Onboarding extends StatefulWidget {
  const Onboarding( {Key? key,}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/Bacgroundimg.png'),
            fit: BoxFit.fill,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: textColor),
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                    Expanded(
                    child: Image.asset("assets/email_corporate_color.png",height: 25, width: 25,),
                    flex: 1,
                  ),
                  SizedBox( width: 15,),
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.of(context).
                      signupwithemail,
                      style: TextStyle(
                        color: corporateColor2,
                        fontSize: 15,
                      ),
                    ),
                    //child: Image.asset("assets/email_corporate_color.png"),
                  ),
                  ],
                ),
              ),
      ),
    ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {

                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: textColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Image.asset("assets/fb_icon_corporate_color.png",height: 25, width: 25,),
                          flex: 1,
                        ),
                        SizedBox( width: 15,),
                        Expanded(
                          flex: 3,
                          child: Text( S.of(context).
                            connectwithfb,
                            style: TextStyle(
                              color: corporateColor2,
                              fontSize: 15,
                            ),
                          ),
                          //child: Image.asset("assets/email_corporate_color.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: textColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Image.asset("assets/login_icon_corporate_color.png",height: 25, width: 25,),
                          flex: 1,
                        ),
                        SizedBox( width: 15,),
                        Expanded(
                          flex: 3,
                          child: Text(S.of(context).
                            loginby,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          //child: Image.asset("assets/email_corporate_color.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
               height: 40,
             ),
              Container(
                height: 80,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   SizedBox(width: 10),
                     Container(
                      width: 390,
                      // height: 40,
                      child: Padding(
                       padding: const EdgeInsets.only(left: 50, right: 50),
                        child: new RichText(
                          textAlign: TextAlign.center,
                            text: new TextSpan(children: [
                              new TextSpan(
                                text: S.of(context).Bysigningyoutoagreethe,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: corporateColor2,
                                ),
                              ),
                              new TextSpan(
                                  text: S.of(context).termsofservice,
                                  style: new TextStyle(color: corporateColor2,
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,decorationThickness: 2),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      final url = ' ';
                                      if (await canLaunch(url)) launch(url);
                                    }),
                              new TextSpan(
                                text: S.of(context).and,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: corporateColor2,
                                ),
                              ),
                              new TextSpan(
                                  text: S.of(context).privacypolicy,
                                  style: new TextStyle(color: corporateColor2,fontSize: 12,
                                      decoration: TextDecoration.underline,decorationThickness: 2),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      const url = ' ';
                                      if (await canLaunch(url)) launch(url);
                                    }),
                            ])
                        ),
                        /* child: Text("I have read and agree to the Terms of Services and Privacy Details",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),*/
                     // ),
                      // flex: 1,
                    ),
                     ),
                    SizedBox( width: 10,)
                  ],

                ),
              ),
              SizedBox(height: 2,),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LanguageActivity()));
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                        ),
                        Expanded(
                          child: Image.asset("assets/language_icon_corporate_color.png",height: 20, width: 20,),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text( S.of(context).
                            english,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: corporateColor2,
                              fontSize: 14,
                            ),
                          ),
                          //child: Image.asset("assets/email_corporate_color.png"),
                        ),
                        SizedBox(
                          width: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
