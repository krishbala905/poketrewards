import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:launch_review/launch_review.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';

import '../UI/TransactionFeedback.dart';
import 'CommonUtils.dart';

void showAlertDialog_oneBtn(BuildContext context,String tittle,String message)
{
  AlertDialog alert = AlertDialog(

    backgroundColor: Colors.white,
    title: Text(tittle),
    // content: CircularProgressIndicator(),
    content: Text(message,style: TextStyle(color: Colors.black45)),
    actions: [
      GestureDetector(
        onTap: (){Navigator.pop(context,true);},
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
      return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6),
        child: alert,
      );
    },
  );
}


void showRewardsDeliveryDialog(BuildContext context,var data){
  data=jsonDecode(data);
  debugPrint("DEDUCT:"+data['DEDUCT']);
  debugPrint("OUTLETID:"+data['OUTLETID']);
  debugPrint("COUNTRYINDEX:"+data['COUNTRYINDEX']);
  debugPrint("PROGRAM_ID:"+data['PROGRAM_ID']);
  debugPrint("CARD_TITLE:"+data['CARD_TITLE']);
  debugPrint("TRANSACTIONVALUE:"+data['TRANSACTIONVALUE']);
  debugPrint("TRANSACTIONTYPE:"+data['TRANSACTIONTYPE']);
  debugPrint("TRANSACTIONID:"+data['TRANSACTIONID']);
  debugPrint("REDEEMED_TITLE:"+data['REDEEMED_TITLE']);
  debugPrint("UPGRADED:"+data['UPGRADED']);
  debugPrint("UPGRADED_TITLE:"+data['UPGRADED_TITLE']);
  debugPrint("CARD_TYPE:"+data['CARD_TYPE']);
  debugPrint("MERCHANT_ID:"+data['MERCHANT_ID']);
  debugPrint("MEMBER_ID:"+data['MEMBER_ID']);
  debugPrint("MERCHANT_NAME:"+data['MERCHANT_NAME']);
  debugPrint("TOPUP:"+data['TOPUP']);
  debugPrint("RECEIVED:"+data['RECEIVED']);
  debugPrint("REDEEMED:"+data['REDEEMED']);
// debugPrint("test0:"+data['ISSUED_POINTS']);
  debugPrint("FEEDBACK_POINTS:"+data['FEEDBACK_POINTS']);
  debugPrint("FB_POINTS:"+data['FB_POINTS']);


  var deduct=data['DEDUCT'];
  var outletId=data['OUTLETID'];
  var COUNTRYINDEX=data['COUNTRYINDEX'];
  var prgmId=data['PROGRAM_ID'];
  var cardTittle=data['CARD_TITLE'];
  var transValue=data['TRANSACTIONVALUE'];
  var transType=data['TRANSACTIONTYPE'];
  var transId=data['TRANSACTIONID'];
  var redeemedTittle=data['REDEEMED_TITLE'];
  var upgraded=data['UPGRADED'];
  var upgradedTittle=data['UPGRADED_TITLE'];
  var cardType=data['CARD_TYPE'];

  var merchantId=data['MERCHANT_ID'];
  var memberId=data['MEMBER_ID'];
  var merchantName=data['MERCHANT_NAME'];
  var topup=data['TOPUP'];
  var recieved=data['RECEIVED'];
  var redeemed=data['REDEEMED'];
  // var issuedPoints=data['ISSUED_POINTS'];
  var fbPoints=data['FB_POINTS'];
  var feebackPoints=data['FEEDBACK_POINTS'];




  showDialog(
      context: context,

      builder: (_) => new AlertDialog(
        content:Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Image.asset('assets/reward_gift_icon.png',width: 100,height: 100,),

              if(transType!="none") Center(child: Text(transValue,style: TextStyle(fontSize: 20),)),
              Text(transType,style: TextStyle(fontSize: 17)),
              SizedBox(height: 10,),
              if(merchantName!="none")  Center(child: Text(merchantName)),
              if(upgradedTittle!="none") Center(child: Text(upgraded.replaceAll("<br>","\r\n")+"\n"+upgradedTittle)),
              if(recieved!="none") Center(child: Text(recieved.replaceAll("<br>","\r\n"+"\n"+recieved))),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if(fbPoints!="0") InkWell(
                    onTap: (){},
                    child:
                    Expanded(flex: 1,child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(color: corporateColor),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text(share,style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    )),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionFeedback(feebackPoints, transId, prgmId),));
                    },
                    child: Expanded(flex: 1,child: Container(

                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(color: corporateColor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),)),
                  ),
                ],
              ),

            ],
          ),
        ),
      ));
}

void showThanksDialog(BuildContext context,String mes)
{
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(10.0)), //this right here
          child: Container(
            height: 240,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/thanks_img.png',height: 100,width: 100,),
                    SizedBox(height: 20,),
                    Text(mes),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){Navigator.pop(context,true);},
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 35,
                          width: 100,
                          color: corporateColor,
                          child:Center(child: Text(ok,style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
        );
      });
}

void showAlertDialog_forAppUpdate(BuildContext context,String tittle,String message)
{
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: Text(tittle),
    // content: CircularProgressIndicator(),
    content: Text(message,style: TextStyle(color: Colors.black45)),
    actions: [
      GestureDetector(
        onTap: (){
          if(CommonUtils.deviceType==1){
            //Apple
            gotoAppstore(context);
          }
          else if(CommonUtils.deviceType==2){
            // android
            gotoPlaystore(context);
          }

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
  );
}

void gotoPlaystore(BuildContext context){
  LaunchReview.launch(
    androidAppId: "com.rising.rewards",

  );
}
void gotoAppstore(BuildContext context){
  LaunchReview.launch(
    iOSAppId: "585027354",
  );
}


void showLoadingView(BuildContext context){
AlertDialog   alert = AlertDialog(
    backgroundColor: Colors.white,

    // content: CircularProgressIndicator(),
    content: Container(
      height: 50,
      child: Center(
        child: Row(
          children: [
            SpinKitCircle(
            color: corporateColor,
            size: 50.0,
            ),
            Text("  Loading..." ,style: TextStyle(color: Colors.black,fontSize: 18),),
          ],
        ),
      ),
    ),

  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}