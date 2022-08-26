import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';




void showToast(String msg, {int? duration, int? gravity}) {
  Toast.show(msg, duration: duration, gravity: gravity);
}
void hideKeyboard(){
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

getRandomNumberBetweenAndToCharacter() {
  int min = 71;
  int max = 90;
  Random foo = new Random();
  int randomNumber = foo.nextInt(max - min) + min;
  if (randomNumber == min) {
    return (min + 1);
  } else {
    return randomNumber;
  }
}

class CommonUtils{

  static  String KEY_FORCE_UPDATE = "force_update";
  static  String KEY_FORCE_LOG_OUT = "forcelogout_format";
  static  String KEY_WALLET_SYNC = "walletsync";
  static  String KEY_WALLET_SYNC_NEW = "walletsyncnew";
  static  String KEY_CALL_INBOX = "callinbox";
  static  String KEY_CARD = "rm";
  static  String KEY_VOUCHER = "rv";
  static  String KEY_MEMBER_POINT_TRANSACTION = "mpt";
  static  String KEY_FEEDBACK_POINT_TRANSACTION = "event_fb_pt";
  static  String KEY_MEMBERSHIP_POPUP = "show_membership_popup";


  static  String none = "none";
  static  String rewards_popup = "rewardsPopup";
  static  String memberShip_popup = "membershipPopup";
  static  String inboxPage = "inboxPage";
  static  String walletPage = "walletPage";





  static String triggerUrl="triggerurl";
  static String triggerPhone="triggerphone";
  static String triggerCMS="cms";
  static String triggerPDF="triggerPDF";
  static String triggerNormal="normal";
  static String triggerEmail="triggeremail";
  static String triggerOneSubbaner="onesubbanner";
  static String MerchantId="318";
  static  int QRVERSION = 1;
  static  int APPLICATIONID = 1;
  static  int SELECTEDLANGUAGEPACKAGEID = 1;
  static int APPLICATIONLANGUAGEID = 1;

  static String? consumerID="";
  static String? merchantID="318";
  static String? consumerName="";
  static String? consumerGender="";
  static String? consumerProfileImageUrl="";
  static String? consumermobileNumber="";
  static String? consumerIntialScreen="";
  static String? consumerEmail="";
  static String? deviceTokenID="3907";
  static String? COUNTRY_INDEX="65";
  static String? deviceToken="";
  static String? deviceType="";
  static String? deviceModel="";
  static String? osVersion="";
  static String? softwareVersion="1.0";
  static String? timeStamp="";
  static String? timeZone="";
  static String? consumerApplicationType="1";
  static String? consumerLanguageId="1";

  static var PPN_RESPONSE_CONTENT;


}



