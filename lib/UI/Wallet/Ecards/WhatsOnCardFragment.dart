import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:poketrewards/UI/Wallet/Ecards/WhatsOnInitModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import '../../CommonBrowser.dart';
import 'MultipleBanners.dart';

class WhatsOnCardFragment extends StatefulWidget {
  var merchantId;
  WhatsOnCardFragment(this.merchantId,{Key? key}) : super(key: key);

  @override
  State<WhatsOnCardFragment> createState() => _WhatsOnCardFragmentState(merchantId);
}

class _WhatsOnCardFragmentState extends State<WhatsOnCardFragment> {
  var merchantId;
  _WhatsOnCardFragmentState(this.merchantId);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body:ListView(
          scrollDirection: Axis.vertical,
          children: [
            // _slidingBanner(context),
            _homeBanner(context),
          ],
        )
    ));
  }


  Future<List<WhatsOnInitModel>> getHomeBannerData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_BANNER_URL),

      body: {
        "merchant_id": merchantId.toString(),
        "consumer_id": CommonUtils.consumerID.toString(),
        "action_event": "1",
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




    if(response.statusCode==200 && jsonDecode(response.body)['MainBanners']!="")
    {

      List<dynamic> body = jsonDecode(response.body)["MainBanners"];
      List<WhatsOnInitModel> posts1 = body.map((dynamic item) => WhatsOnInitModel.fromJson(item),).toList();

      return posts1;

    }
    else {

      throw "Unable to retrieve posts.";
    }

  }
  FutureBuilder<List<WhatsOnInitModel>> _homeBanner(BuildContext context) {

    return FutureBuilder<List<WhatsOnInitModel>>(

      future: getHomeBannerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<WhatsOnInitModel>? posts = snapshot.data;
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
  // GridView _buildPostsHome(BuildContext context, List<HomeInitModel> posts) {
  //   return GridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 16,
  //         mainAxisSpacing: 16),
  //     physics: NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: posts.length,
  //     padding: EdgeInsets.all(8),
  //     itemBuilder: (context, index) {
  //       return InkWell(
  //         onTap: (){
  //           print("action"+posts[index].bannerType);
  //           var actionType=posts[index].bannerType;
  //
  //
  //           if(actionType==CommonUtils.triggerUrl){
  //             var url=posts[index].details;
  //             var tittle=posts[index].categoryName;
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
  //           }
  //           else if(actionType==CommonUtils.triggerPhone){
  //             var phone=posts[index].details;
  //             _launchCaller(phone);
  //           }
  //           else if(actionType==CommonUtils.triggerCMS){
  //             var url=posts[index].details;
  //             var tittle=posts[index].categoryName;
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
  //           }
  //           else if(actionType==CommonUtils.triggerNormal){
  //             var categId=posts[index].categoryId;
  //             var tittle=posts[index].categoryName;
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleBanners(categId,tittle),));
  //           }
  //
  //         },
  //         child: Image.network(
  //             posts[index].categoryImage,
  //         ),
  //       );
  //     },
  //   );
  // }
  ListView _buildPostsHome(BuildContext context, List<WhatsOnInitModel> posts) {
    return ListView.builder(

      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom:2.0),
          child: InkWell(
            onTap: (){
              print("action"+posts[index].bannerType);
              var actionType=posts[index].bannerType;


              if(actionType==CommonUtils.triggerUrl){
                var url=posts[index].details;
                var tittle=posts[index].categoryName;
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
              }
              else if(actionType==CommonUtils.triggerPhone){
                var phone=posts[index].details;
                _launchCaller(phone);
              }
              else if(actionType==CommonUtils.triggerCMS || actionType==CommonUtils.triggerOneSubbaner ){
                var url=posts[index].details;
                var tittle=posts[index].categoryName;
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
              }
              else if(actionType==CommonUtils.triggerNormal){
                var categId=posts[index].categoryId;
                var tittle=posts[index].categoryName;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleBanners(categId,tittle,merchantId),));
              }
              else if(actionType==CommonUtils.triggerEmail){
                var categId=posts[index].categoryId;
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
}
