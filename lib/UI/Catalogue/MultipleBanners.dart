import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:poketrewards/Others/CommonBrowser.dart';
import 'package:poketrewards/UI/Catalogue/StartActivity.dart';
import 'package:poketrewards/UI/Wallet/Ecards/WhatsOnMultipleInitModel.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../Others/AlertDialogUtil.dart';
import '../Wallet/EVoucher/EVoucherDetailsFragment.dart';

class MultipleBanners extends StatefulWidget {
  var id,tittle,merchantId;
   MultipleBanners(this.id, this.tittle,this.merchantId,{Key? key}) : super(key: key);

  @override
  State<MultipleBanners> createState() => _MultipleBannersState(id,tittle,merchantId);
}

class _MultipleBannersState extends State<MultipleBanners> {
  var tittle="";
  var id="";
  var merchantId;
  _MultipleBannersState(this.id, this.tittle,merchantId);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: corporateColor,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(tittle,style: TextStyle(color: Colors.white),),
        ),
        body: _homeMultipleBanner(context),
      ),

    );
  }


  Future<List<WhatsOnMultipleInitModel>> getHomeBannerData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_BANNER_DETAILS_URL),

      body: {
        "main_category_id":widget.id,
        "merchant_id": widget.merchantId,
        "consumer_id": CommonUtils.consumerID.toString(),
        "action_event": "1",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        "device_type":CommonUtils.deviceType,
      },
    ).timeout(Duration(seconds: 30));


  debugPrint("check5${response.body}");

    if(response.statusCode==200)
    {
      List<dynamic> body = jsonDecode(response.body)["SubBanners"];
      List<WhatsOnMultipleInitModel> posts1 = body.map((dynamic item) => WhatsOnMultipleInitModel.fromJson(item),).toList();
      print("check8$posts1");
      return posts1;

    }
    else {
      throw "Unable to retrieve posts.";
    }

  }
  FutureBuilder<List<WhatsOnMultipleInitModel>> _homeMultipleBanner(BuildContext context) {

    return FutureBuilder<List<WhatsOnMultipleInitModel>>(

      future: getHomeBannerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("check7"+widget.id);
          final List<WhatsOnMultipleInitModel>? posts = snapshot.data;
          return _buildPostsHome(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  ListView _buildPostsHome(BuildContext context, List<WhatsOnMultipleInitModel> posts) {
    return ListView.builder(

     //  physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
             print("action"+posts[index].bannerType);
            var actionType=posts[index].bannerType;


            if(actionType==CommonUtils.triggerUrl){
              var url=posts[index].details;
              var tittle=posts[index].categoryName;
              Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
            }
            else if(actionType==CommonUtils.triggerVoucher){
              var prgmid = posts[index].programid;
              var categId=posts[index].categoryId;
              var prgrmtype = posts[index].programtype;
              var categname = posts[index].categoryName;
              // var categaction = posts[index].details;
              // var categgaction = stringSplit(categaction);
              var exp = posts[index].expiry;
              var cardimg=posts[index].cardimage;
              Navigator.push(context, MaterialPageRoute(builder: (context) => EVoucherDetailsFragment(
                  categname,prgmid,prgrmtype,categname,cardimg,exp," ","","promotion", posts[index].poketed),));
            }
            else if(actionType==CommonUtils.triggerPhone){
              var phone=posts[index].details;
              _launchCaller(phone);
            }
            // not used
            /*else if(actionType==CommonUtils.triggerCMS){
              var url=posts[index].details;
              var tittle=posts[index].categoryName;
              Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
            }*/
            else if(actionType==CommonUtils.triggerCMS){
              var temp=posts[index].details;
              var tittle=posts[index].categoryName;
              Navigator.push(context, MaterialPageRoute(builder: (context) => StartActivity(temp,tittle),));
            }
            else if(actionType==CommonUtils.triggerNormal){
              // var categId=posts[itemIndex].categoryId;
              // var tittle=posts[itemIndex].categoryName;
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MultiplBanners(categId,tittle),));
            }
            else if(actionType==CommonUtils.triggerVoucher){
              // var categId=posts[itemIndex].categoryId;
              // var tittle=posts[itemIndex].categoryName;
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MultiplBanners(categId,tittle),));
            }
            else if(actionType==CommonUtils.triggerEmail){
              //  var categId=posts[index].categoryId;
              var tittle=posts[index].details;
              _launchEmail(tittle);
            }

          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
              border: Border.all(color: lightGrey,),
                  borderRadius: BorderRadius.circular(1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    posts[index].categoryImage,
                  ),
                  SizedBox(height: 10,),
                  if(posts[index].bannerType=="voucher")Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [

                        Container(width: 1,height: 30,color: lightGrey,),
                        SizedBox(width: 10,),
                        Center(
                          child: Text('Free',style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: corporateColor2
                          ),),
                        ),
                        SizedBox(width: 40,),
                        GestureDetector(
                          onTap: (){
                            if( posts[index].poketed=="no"){
                              showAlertforPoketIt(posts[index]);
                            }

                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.only(right: 10,left: 10),

                              child: Container(


                                decoration: BoxDecoration(
                                    color:corporateColor2,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                padding: EdgeInsets.all(10),

                                child: Center(
                                  child: setPoketitbtn(posts[index].poketed),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget setPoketitbtn(var data){
    if(data=="yes"){
      return Text("POKETED",style: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),);
    }
    else{
      return Text("POKET IT",style: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),);
    }
  }

  _launchEmail(var emailId) async {
    final Email email = Email(
      subject: emailContent,
      recipients: [emailId],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
  _launchCaller(mobile) async {

    final Uri launchUri=Uri(
      scheme: 'tel',
      path: mobile,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $mobile';
    }
  }
  String stringSplit(String data) {
    return data.split("~")[3];
  }

  void showAlertforPoketIt(WhatsOnMultipleInitModel posts){
    String message="";
    if (posts.bannerType=="vouchercard") {
      message=accept_message_voucher;
    }
    else {
      message=accept_message_voucher;
    }
    AlertDialog alert = AlertDialog(

      backgroundColor: Colors.white,
      title: Text(message,style: TextStyle(color:Colors.grey,fontSize: 14)),
      // content: CircularProgressIndicator(),

      content: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: (){Navigator.pop(context,true);},
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 100,
                  color: Colors.white,
                  child:Center(child: Text(cancel_caps,style: TextStyle(color: corporateColor),)),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){Navigator.pop(context,true);
              getVoucher(posts);
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 100,
                  color: Colors.white,
                  child:Center(child: Text(accept,style: TextStyle(color: corporateColor),)),
                ),
              ),
            ),
          ],
        ),
      ),

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

  Future<void> getVoucher(WhatsOnMultipleInitModel posts) async{
    showLoadingView(context);

    final http.Response response = await http.post(
      Uri.parse(PROMOTION_VOUCHER_DOWNLOAD_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": posts.programid.toString(),
        "program_type": posts.programtype.toString(),

        "serial_no":"",
        "merchant_id":CommonUtils.MerchantId.toString(),
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


    String res=response.body;
    print(res);
    var status=json.decode(response.body)['Status'];


    Navigator.pop(context);
    if(status=="True"){
      var otpStatus=json.decode(response.body)['p1_val'].toString();
      var downloadStatus=json.decode(response.body)['p2_val'].toString();
      var message=json.decode(response.body)['p3_val'];


      if (otpStatus=="1") {

        if (downloadStatus=="1") {

          showAlertDialogoneBtn_lc(context,message);
        } else {
          var OtpVerificationCode=json.decode(response.body)['p4_val'];
          var transactionId=json.decode(response.body)['p5_val'];
          var consumerMblNo=json.decode(response.body)['p8_val'];

          // getOtp();
        }

      } else {

        sendToDownloadProgram(posts);

      }
    }
    else{
      showAlertDialog_oneBtnWitDismiss(context, alert1, failed_try_again);
    }

  }

  Future<void> sendToDownloadProgram(WhatsOnMultipleInitModel posts) async{
    showLoadingView(context);

    final http.Response response = await http.post(
      Uri.parse(VOUCHER_DOWNLOAD_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": posts.programid.toString(),
        "program_type": posts.programtype.toString(),
        "outlet_id":"",
        "serial_no":"",
        "merchant_id":CommonUtils.MerchantId.toString(),
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


    String res=response.body;
    print(res);
    var status=json.decode(response.body)['Status'];
    var message=json.decode(response.body)['message'];


    Navigator.pop(context);
    if(status=="True"){


      showAlertDialog_oneBtn(context, thank_you,message);

    } else {

      showAlertDialogoneBtn_lc(context, message);

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
