import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/Others/Utils.dart';
import 'package:poketrewards/UI/ForgotPassword.dart';
import 'package:poketrewards/UI/LanguageActivity.dart';
import 'package:poketrewards/UI/Onboarding.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';

import '../Others/CommonUtils.dart';
import '../res/Colors.dart';
import 'package:poketrewards/UI/ConsumerTab.dart';
import 'package:http/http.dart' as http;

import '../res/Strings.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailId_cntrl = TextEditingController();
  TextEditingController pwdId_cntrl = TextEditingController();
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscured = true;
    hideKeyboard();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: corporateColor2,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Onboarding()));
            // _goBack(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: corporateColor2,
        centerTitle: true,
        title: Text(
          S.of(context).login,
          style: TextStyle(color: textcolor, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(color: textcolor),
            height: 0.5,
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            decoration: BoxDecoration(color: textcolor),
            height: 0.5,
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 25),
                Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(S.of(context).email,
                          style: TextStyle(
                            color: textcolor,
                            fontSize: 15,
                          )),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: TextField(
                      cursorColor: textcolor,
                      controller: emailId_cntrl,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: textcolor, fontSize: 15),
                      decoration: InputDecoration(
                        labelText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                SizedBox(width: 25),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: textcolor),
            height: 0.5,
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 25),
                Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(S.of(context).password,
                          style: TextStyle(
                            color: textcolor,
                            fontSize: 15,
                          )),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: TextField(
                      cursorColor: textcolor,
                      controller: pwdId_cntrl,
                      obscureText: _obscured,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: textcolor, fontSize: 15),
                      decoration: InputDecoration(
                        labelText: "",
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 24,
                            color: textcolor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                SizedBox(width: 25),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: textcolor),
            height: 0.5,
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              //  Navigator.push(context, MaterialPageRoute(builder: (_) => ConsumerTab()));
              //  Validation
              var email = emailId_cntrl.text.toString().trim();
              var paswd = pwdId_cntrl.text.toString();

              loginTask(email, paswd);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: textcolor),
                ),
                child: Center(
                    child: Text(
                  S.of(context).loginwith,
                  style: TextStyle(
                      color: textcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: () {
              // Validation
               Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
              child: Center(
                  child: Text(
                S.of(context).forgot_password,
                style: TextStyle(color: textcolor, fontSize: 15),
                textAlign: TextAlign.center,
              )),
            ),
          ),
        ],
      ),
    ));
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return '0';
    } else {
      return "1";
    }
  }

  Future<void> loginTask(var email, var paswd) async {
    if (email.length == 0) {
      showAlertDialog_oneBtn(context, alert, enter_empty_email);
    } else if (validateEmail(email) != "1") {
      showAlertDialog_oneBtn(context, alert, enter_valid_email);
    } else if (paswd.length == 0) {
      showAlertDialog_oneBtn(context, alert, enter_empty_pwd);
    } else if (validatePassword(paswd) != "1") {
      showAlertDialog_oneBtn(context, alert, enter_valid_pwd);
    } else {
      callApi(email, paswd);
    }
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return "0";
    } else {
      return "1";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FocusScope.of(context).requestFocus(FocusNode());
    emailId_cntrl.dispose();
    pwdId_cntrl.dispose();
    super.dispose();
  }

  Future<void> callApi(var email, var pwd) async {
    var data = null;
    print("url:" + LoginUrl);
    final http.Response response = await http.post(
      Uri.parse(LoginUrl),
      body: {
        "consumer_email": email,
        "consumer_password": pwd,
        "login_mode": "1",
        "device_type": CommonUtils.deviceType,
        "device_token": CommonUtils.deviceToken,
        "cma_timestamps": Utils().getTimeStamp(),
        "time_zone": Utils().getTimeZone(),
        "software_version": CommonUtils.softwareVersion,
        "os_version": CommonUtils.osVersion,
        "phone_model": CommonUtils.deviceModel,
        'consumer_application_type': CommonUtils.consumerApplicationType,
        'consumer_language_id': CommonUtils.consumerLanguageId,
      },
    ).timeout(Duration(seconds: 30));
    print(response.body.toString());
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var status="1";
      var messg="1";

      if (status == "1") {

        // var consId = stringSplit(data2['p2']);
        // var name = stringSplit(data2['p3']);
        // var devTokenId = stringSplit(data2['p4']);
        //
        // var p6 = stringSplit(data2['p6']);
        // var p7 = stringSplit(data2['p7']);
        // var gender = stringSplit(data2['p8']);
        // var profileImg = stringSplit(data2['p9']);
        //
        // var mobNmbr = stringSplit(data2['p10']);
        // var firstPag = stringSplit(data2['p11']);
        print(status);
        CommonUtils.consumerID = "219732";
        // CommonUtils.consumerID = consId;
        CommonUtils.consumerName = "Gokul";
        CommonUtils.consumerGender = "Male";
        CommonUtils.consumerProfileImageUrl = "";
        CommonUtils.consumermobileNumber = "87654321";
        CommonUtils.consumerIntialScreen = "Wallet";
        CommonUtils.consumerEmail = email;
        CommonUtils.deviceTokenID ="280469";

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('alreadyLoggedIn', "1");
        prefs.setString('consumerId', CommonUtils.consumerID.toString());
        prefs.setString('consumerName', CommonUtils.consumerName.toString());
        prefs.setString('consumerEmail', CommonUtils.consumerEmail.toString());
        prefs.setString('consumerMobile', CommonUtils.consumermobileNumber.toString());
        prefs.setString('consumerDeviceTokenId', CommonUtils.deviceTokenID.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConsumerTab(),
            ));
      } else {
        showAlertDialog_oneBtn(context, alert, messg);
      }
    } else {
      showAlertDialog_oneBtn(context, alert, something_went_wrong);
    }
  }

  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
}
