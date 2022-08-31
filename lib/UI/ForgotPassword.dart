import 'package:flutter/material.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/Others/Utils.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgotpasswd_cntrl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(backgroundColor: corporateColor,centerTitle: true,title: Text(forgott_password,style: TextStyle(color: Colors.white,fontSize:20 ),),),

      body: Container(
        color: corporateColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Container(
              width: 170,
              child: Text(please_enter_your_email_address_to_reset_your_passworrd,textAlign: TextAlign.center,style:TextStyle(color: Colors.white,fontSize: 15,)),
            ),
            SizedBox(height: 40,),
            Container(decoration: BoxDecoration(color: Colors.white),height: 0.5,),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width:25),
                  Container(width:100,child: Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Text(email,style:TextStyle(color: Colors.white,fontSize: 15,)),
                  )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left:25),
                    child: TextField(
                      cursorColor:  Colors.white,
                      controller: forgotpasswd_cntrl,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: textcolor, fontSize: 15),
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
            Container(decoration: BoxDecoration(color: textcolor),height: 0.5,),


            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                // Validation
                var email=forgotpasswd_cntrl.text.toString();
                if(email.length==0){
                  showAlertDialog_oneBtn(context, alert1,enter_empty_email);
                }
                else if(validateEmail(email)!="1"){
                  showAlertDialog_oneBtn(context, alert1,enter_valid_email);
                }
                else{
                   callApi(email);
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                child: Container(
                  height: 40,

                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: textcolor),
                  ),

                  child: Center(child: Text(reset_password,style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.center,)),
                ),
              ),
            ),

          ],

        ),
      ),

    ));
  }

  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return '0';
    } else {
      return "1";
    }
  }
  Future<void> callApi(var email) async {
    var data=null;
    print("url:"+FORGOTPASSWORD_URL);

    final http.Response response = await http.post(
      Uri.parse(FORGOTPASSWORD_URL),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: {
        "email": email,
        "action_event": "30",
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
    if (response.statusCode == 200) {
      print(response.body.toString());

      /*data=await jsonDecode(response.body);
      var status=data["status"].toString();
      var message=data["data"].toString();*/

     /* if(status=="True"){
        showAlertDialog_oneBtnWitDismiss(context, alert, message);
      }
      else{
        showAlertDialog_oneBtn(context, alert, message);
      }*/

    } else {
      showAlertDialog_oneBtn(context, alert1, something_went_wrong1);
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
}
