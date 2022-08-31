import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/Others/Utils.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../res/Strings.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscured=false;
  bool _obscured1=false;
  bool _obscured2=false;
  final textFieldFocusNode = FocusNode();
  TextEditingController oldpwd_cntrl=TextEditingController();
  TextEditingController newpwd_cntrl=TextEditingController();
  TextEditingController confirmpwd_cntrl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(changePassword,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: corporateColor,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              height: 55,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width:25),
                  Container(width: 150,child: Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Text(oldpassword,style:TextStyle(color: corporateColor,fontSize: 15,)),
                  )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left:25),
                    child: TextField(

                      controller: oldpwd_cntrl,

                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "",
                        border: InputBorder.none,

                      ),

                    ),
                  ),flex: 1,),

                  SizedBox(width:25),
                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: corporateColor),height: 1,),
            Container(
              height: 55,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width:25),
                  Container(width: 150,child: Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Text(newpassword,style:TextStyle(color: corporateColor,fontSize: 15,)),
                  )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left:25),
                    child: TextField(

                      controller: newpwd_cntrl,

                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "",
                        border: InputBorder.none,

                      ),

                    ),
                  ),flex: 1,),

                  SizedBox(width:25),
                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: corporateColor),height: 1,),
            Container(
              height: 55,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width:25),
                  Container(width: 150,child: Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Text(confirmpassword,style:TextStyle(color: corporateColor,fontSize: 15,)),
                  )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left:25),
                    child: TextField(

                      controller: confirmpwd_cntrl,

                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "",
                        border: InputBorder.none,

                      ),

                    ),
                  ),flex: 1,),

                  SizedBox(width:25),
                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: corporateColor),height: 1,),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 28.0,right: 28),
              child: GestureDetector(
                onTap: (){
                  callApi();
                },
                child: Center(
                  child: Container(width:double.infinity,height:45,
                      decoration: BoxDecoration(color:corporateColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white),
                      ),

                      child: Center(child: Text(update,style: TextStyle(color: Colors.white,fontSize: 17,),))),
                ),),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> callApi() async {
    var oldPwd=oldpwd_cntrl.text;
    var newPwd=newpwd_cntrl.text;
    var confirmPwd=confirmpwd_cntrl.text;

    if(oldPwd.isEmpty){
      showAlertDialog_oneBtn(context, alert1, please_enter_old_pwd);
    }
    else if(newPwd.isEmpty){
      showAlertDialog_oneBtn(context, alert1, please_enter_new_pwd);
    }
    else if(confirmPwd.isEmpty){
      showAlertDialog_oneBtn(context, alert1, please_enter_confrim_pwd);
    }
    else if(newPwd!=confirmPwd){
      showAlertDialog_oneBtn(context, alert1, new_confirm_pwd_mismatch);
    }
    else{

      var data=null;
      print("url:"+CHANGEPASSWORD_URL);

      final http.Response response = await http.post(
        Uri.parse(CHANGEPASSWORD_URL),

        body: {
          "consumer_old_password": oldPwd,
          "consumer_new_password": newPwd,
          "consumer_id": CommonUtils.consumerID,
          "cma_timestamps":Utils().getTimeStamp(),
          "time_zone":Utils().getTimeZone(),
          "software_version":CommonUtils.softwareVersion,
          "os_version":CommonUtils.osVersion,
          "phone_model":CommonUtils.deviceModel,
          "device_type":CommonUtils.deviceType,
          'consumer_application_type':CommonUtils.consumerApplicationType,
          'consumer_language_id':CommonUtils.consumerLanguageId,

        },
      ).timeout(Duration(seconds: 30));
      print(response.statusCode.toString());
      print(response.body.toString());
      if (response.statusCode == 200) {
        final Xml2Json xml2json = new Xml2Json();
        xml2json.parse(response.body);
        var jsonstring = xml2json.toParker();
        print("1:" + jsonstring);
        Map<String, dynamic> data = await jsonDecode(jsonstring)["info"];
        var status = stringSplit(data['p1']);
        var message = stringSplit(data['p2']);
        if(status.toLowerCase()=="true"){

          showAlertDialog_oneBtnWitDismiss(context, alert1, message);
          print("Success");

        }
        else{
          showAlertDialog_oneBtn(context, alert1, message);
        }

      } else {
        showAlertDialog_oneBtn(context, alert1, something_went_wrong1);
      }


    }

  }
  void showAlertDialog_oneBtnWitDismiss(BuildContext context,String tittle,String message)
  {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message,style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: (){Navigator.pop(context,true);

          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child:Center(child: Text(ok,style: TextStyle(color: corporateColor),)),
            ),
          ),
        ),
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((exit){
      if (exit == null) return;

      if (exit) {
        // back to previous screen

        Navigator.pop(context);
      } else {
        // user pressed No button
      }
    });

  }
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  void _toggleObscured1() {
    setState(() {
      _obscured1 = !_obscured1;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
  }

