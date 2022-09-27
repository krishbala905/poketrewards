import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/CommonBrowser.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/UI/Catalogue/WhatsonInitModel.dart';
import 'package:poketrewards/UI/Catalogue/MultipleBanners.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;
import 'package:poketrewards/res/Strings.dart';

class WhatsonDetailsFragment extends StatefulWidget {
  var merchant_name,merchant_id,merchant_logo;
  WhatsonDetailsFragment(this.merchant_name,this.merchant_id,this.merchant_logo);
  @override
  State<WhatsonDetailsFragment> createState() => _WhatsonDetailsFragmentState(merchant_name,merchant_id,merchant_logo);
}

class _WhatsonDetailsFragmentState extends State<WhatsonDetailsFragment> {
  var merchant_name=" ";
      var merchant_id,merchant_logo;
_WhatsonDetailsFragmentState(this.merchant_name,merchant_id,merchant_logo);

  void initState() {
    // TODO: implement initState

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(merchant_name,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: corporateColor,
      ),
        body:ListView(
          scrollDirection: Axis.vertical,
          children: [
            // _slidingBanner(context),
            _homeBanner(context),
          ],
        )
    ));
  }
  FutureBuilder<List<WhatsonInitModel>> _homeBanner(BuildContext context) {

    return FutureBuilder<List<WhatsonInitModel>>(

      future: getHomeBannerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<WhatsonInitModel>? posts = snapshot.data;
          return _buildPostsHome(context, posts!);
        } else {
          return Center(
            child:SpinKitCircle(
              color: corporateColor,
              size: 30.0,
            ),
          );
        }
      },
    );
  }
  Future<List<WhatsonInitModel>> getHomeBannerData() async {


    final http.Response response = await http.post(
      Uri.parse(CATALOGUE_BANNER_URL),

      body: {
        "merchant_id": widget.merchant_id,
        "consumer_id": CommonUtils.consumerID.toString(),
        "action_event": "1",
        /*"cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),*/
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        "device_TokenID":CommonUtils.deviceTokenID,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
      },
    ).timeout(Duration(seconds: 30));

    debugPrint("check4"+ response.body.toString());


    if(response.statusCode==200 && jsonDecode(response.body)['MainBanners']!="")
    {

      List<dynamic> body = jsonDecode(response.body)["MainBanners"];

      List<WhatsonInitModel> posts1 = body.map((dynamic item) => WhatsonInitModel.fromJson(item),).toList();

      return posts1;

    }
    else {

      throw "Unable to retrieve posts.";
    }

  }
  ListView _buildPostsHome(BuildContext context, List<WhatsonInitModel> posts) {
    return ListView.builder(

      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom:2.0),
          child: InkWell(
            onTap: (){
              print("action2"+posts[index].bannerType);
              var actionType=posts[index].bannerType;


              if(actionType==CommonUtils.triggerUrl){
                var url=posts[index].details;
                var tittle=posts[index].categoryName;
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
              }

              else if(actionType==CommonUtils.triggerPhone || actionType==CommonUtils.ROAD_ASSIST_WITH_CALL){
                var phone=posts[index].details;
                _launchCaller(phone);
              } else if( actionType==CommonUtils.ROAD_ASSIST_WITHOUT_CALL){
                var message=posts[index].errorMessage;
                showThanksDialog(context,message);
              }
              else if(actionType==CommonUtils.triggerCMS || actionType==CommonUtils.triggerOneSubbaner ){
                var url=posts[index].details;
                var tittle=posts[index].categoryName;
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
              }
              else if(actionType==CommonUtils.triggerNormal){
                var categId=posts[index].categoryId;
                var tittle=posts[index].categoryName;
                var merch_id = widget.merchant_id;
                print("Check6"+ categId.toString()+tittle.toString()+merch_id.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleBanners(categId,tittle,merch_id),));
              }
              else if(actionType==CommonUtils.triggerEmail){
                //  var categId=posts[index].categoryId;
                var tittle=posts[index].details;
                _launchEmail(tittle);
              }

            },

            // child: Image.network(posts[index].categoryImage,),
            child:  Image.network(posts[index].categoryImage),
          ),
        );
      },
    );
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
}
