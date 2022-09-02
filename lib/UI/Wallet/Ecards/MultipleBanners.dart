import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../CommonBrowser.dart';
import 'WhatsOnMultipleInitModel.dart';

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
        "main_category_id":id,
        "merchant_id": merchantId,
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




    if(response.statusCode==200)
    {
      List<dynamic> body = jsonDecode(response.body)["SubBanners"];
      List<WhatsOnMultipleInitModel> posts1 = body.map((dynamic item) => WhatsOnMultipleInitModel.fromJson(item),).toList();

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

      physics: NeverScrollableScrollPhysics(),
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
            else if(actionType==CommonUtils.triggerPhone){
              var phone=posts[index].details;
              _launchCaller(phone);
            }
            else if(actionType==CommonUtils.triggerCMS){
              var url=posts[index].details;
              var tittle=posts[index].categoryName;
              Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
            }
            else if(actionType==CommonUtils.triggerNormal){
              // var categId=posts[itemIndex].categoryId;
              // var tittle=posts[itemIndex].categoryName;
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MultiplBanners(categId,tittle),));
            }

          },
          child: Image.network(
            posts[index].categoryImage,
          ),
        );
      },
    );
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
