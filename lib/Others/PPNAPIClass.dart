import 'dart:convert';
import 'package:poketrewards/UI/SplashScreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/Strings.dart';
import 'AlertDialogUtil.dart';
import 'CommonUtils.dart';
import 'Urls.dart';
import 'Utils.dart';



Future<String> callPPNAPI(BuildContext context)async {
   var navigatePath="null";
  var data=null;
  print("url:"+PPN_URL);

  final http.Response response = await http.post(
    Uri.parse(PPN_URL),

    body: {
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


  print(response.body.toString());

  if (response.statusCode == 200) {

    data=await jsonDecode(response.body);
    var status=data["STATUS"].toString();
    var message=data["MESSAGE"].toString();
    //



    if(status=="True"){

      // var actionType=data["ACTION"].toString();
      var actionType=CommonUtils.KEY_CALL_INBOX;



      if(actionType==CommonUtils.KEY_FORCE_LOG_OUT) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('alreadyLoggedIn', "");
        prefs.setString('consumerId', "");
        prefs.setString('consumerName',"" );
        prefs.setString('consumerEmail',"" );

        CommonUtils.consumerID="";
        CommonUtils.consumerName="";
        CommonUtils.consumerEmail="";
        navigatePath=CommonUtils.none;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen(),));
        showToast(logout_message, gravity: Toast.bottom);
        // Need to call Api
      }
      else if(actionType==CommonUtils.KEY_FORCE_UPDATE){
        navigatePath=CommonUtils.none;
        showAlertDialog_forAppUpdate(context,alert1,message);
      }

      else if(actionType==CommonUtils.KEY_MEMBER_POINT_TRANSACTION) {
        navigatePath=CommonUtils.rewards_popup;
        CommonUtils.PPN_RESPONSE_CONTENT=response.body;
        showRewardsDeliveryDialog(context, response.body.toString());
      }

      else if(actionType==CommonUtils.KEY_FEEDBACK_POINT_TRANSACTION) {
        navigatePath=CommonUtils.none;
        CommonUtils.PPN_RESPONSE_CONTENT=response.body;
      }

      else if(actionType==CommonUtils.KEY_CALL_INBOX) {
        navigatePath=CommonUtils.inboxPage;
        CommonUtils.PPN_RESPONSE_CONTENT=response.body;
      }
      else if(actionType==CommonUtils.KEY_WALLET_SYNC || actionType==CommonUtils.KEY_WALLET_SYNC_NEW) {
        navigatePath=CommonUtils.walletPage;
        CommonUtils.PPN_RESPONSE_CONTENT=response.body;
      }

      else if(actionType==CommonUtils.KEY_MEMBERSHIP_POPUP){
        navigatePath=CommonUtils.memberShip_popup;
        CommonUtils.PPN_RESPONSE_CONTENT=response.body;
        showRewardsDeliveryDialog(context, response.body.toString());
      }
      else{
        navigatePath=CommonUtils.none;
      }

    }
    else{
      navigatePath=CommonUtils.none;
    }


  } else {
    showAlertDialog_oneBtn(context, alert1, something_went_wrong1);
    throw something_went_wrong1;
  }

  return navigatePath;

}






