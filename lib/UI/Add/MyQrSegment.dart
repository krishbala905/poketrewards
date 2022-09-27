import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../res/Colors.dart';
class MyQrSegment extends StatefulWidget {
  const MyQrSegment({Key? key}) : super(key: key);


  @override
  State<MyQrSegment> createState() => _MyQrSegmentState();
}

class _MyQrSegmentState extends State<MyQrSegment> {
  Widget  generateQRCodeForPOS()  {

   // var data1= CommonUtils.consumermobileNumber.toString().replaceAll("65 ", "");
    var consumerid = CommonUtils.consumerID;
  //  var devicetoken = CommonUtils.deviceTokenID;
//    var languageID = CommonUtils.consumerLanguageId;

   // var data2="+65"+data1.split(":")[0];
    var  data2 = consumerid;
    var data3= base64Url.encode(utf8.encode(data2!));

    return QrImage(
      data: data3,
      version: QrVersions.auto,
      size: 250,
      gapless: false,
foregroundColor: corporateColor,
      errorStateBuilder: (cxt, err) {
        return Container(
          child: Center(
            child: Text(
              err.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
               height: 20,
            ),
            Center(
              child: ClipOval(
                child: CommonUtils.consumerProfileImageUrl != "" ? Image.network(CommonUtils.consumerProfileImageUrl.toString(),width: 100,height: 100,fit: BoxFit.cover,):

                Image.asset('assets/ic_profile.png',width: 100,height: 100,color: corporateColor2,),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(CommonUtils.consumerName.toString(),style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: corporateColor2,
              ),),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(CommonUtils.consumerEmail.toString(),style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color:lightGrey,
              ),),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(CommonUtils.consumermobileNumber.toString(),style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color:lightGrey,
              ),),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child:generateQRCodeForPOS()
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text('Let merchant scan my QR Code',style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color:corporateColor,
              ),),
            ),


          ],
        ),

      ),
    );
  }
}
