import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/UI/Catalogue/Headerdata.dart';
import 'package:poketrewards/UI/Catalogue/MerchantDataModel.dart';
import 'package:poketrewards/UI/Catalogue/WhatsonDetailsFragment.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:http/http.dart' as http;

class WhatsOnFragment extends StatefulWidget {
  const WhatsOnFragment({Key? key}) : super(key: key);

  @override
  State<WhatsOnFragment> createState() => _WhatsOnFragmentState();
}

class _WhatsOnFragmentState extends State<WhatsOnFragment> {
  late Future<List<MerchantDataModel>> myfuture;
  /*void initState() {
    // TODO: implement initState
     myfuture = _Whatson();
    super.initState();
  }*/
  void didChangeDependencies() {
    myfuture = _Whatson();
    super.didChangeDependencies();
  }

  TextEditingController wlcmsg = TextEditingController();
  String? wlcmimg;
  bool showData = false;
  var hii = " set";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            TextField(
              enabled: false,
              keyboardType: TextInputType.text,
              controller: wlcmsg,
              decoration: InputDecoration(
                labelText: "",
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: wlcmimg != null
                          ? NetworkImage(wlcmimg!)
                          : AssetImage("assets/img_placeholder_merchantlogo.png") as ImageProvider,
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  memberexclusive,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                )),
            SizedBox(
              height: 15,
            ),
                Expanded(
                  child: Visibility(
                    visible: showData,
                    child: Text(no_content_catalogue,style: TextStyle(color: Colors.black,fontSize: 15.0),
                    ),
                    replacement: FutureBuilder(
                  future: myfuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print("check3 "+ hii);
                  final List<MerchantDataModel>? posts = snapshot.data as List<MerchantDataModel>?;
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
          ),
                    // Merchantdata((context)),
                  ),
                ),
          ],
        ),
      )),
    );
  }

  Future<List<MerchantDataModel>> _Whatson() async {
    final http.Response response = await http.post(
      Uri.parse(CATALOGUE_URL),
      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        //"cma_timestamps":Utils().getTimeStamp(),
        // "time_zone":Utils().getTimeZone(),
        "software_version": CommonUtils.softwareVersion,
        "os_version": CommonUtils.osVersion,
        "phone_model": CommonUtils.deviceModel,
        "device_type": CommonUtils.deviceType,
        'consumer_application_type': CommonUtils.consumerApplicationType,
        'consumer_language_id': CommonUtils.consumerLanguageId,
        'device_token_id': CommonUtils.deviceTokenID,
      },
    ).timeout(Duration(seconds: 30));
    debugPrint("Check1" + response.body.toString());
    if (response.statusCode == 200 &&
        jsonDecode(response.body)["Status"] == "True") {
      var ShowMerchant = jsonDecode(response.body)['MerchantsPresent'];
      final Map<String, dynamic> data = json.decode(response.body)['data']['HeaderData'];
      Headerdata headerinf = Headerdata.fromJson(data);
      print(headerinf.HeaderText.toString());
      if (headerinf != null) {
        setState(() {
          wlcmsg.text = headerinf.HeaderText;
          wlcmimg = headerinf.HeaderImage;
          print(wlcmimg);
        });
      }
      if (ShowMerchant == "true") {
        final List<dynamic> data1 = json.decode(response.body)['data']['MerchantData'];
        print(data1);
        List<MerchantDataModel> posts1 = data1.map((dynamic item) => MerchantDataModel.fromJson(item),).toList();
        print("Check1 "+ posts1.length.toString());
        if (posts1.length == 0) {
          setState(() {
            showData = true;
          });
        }
        return posts1;

      }
    }
    else{
      throw "Unable to retrieve Merchant Details";
    }
    throw "Unable to retrieve Merchant Details";
  }
  /*FutureBuilder<List<MerchantDataModel>> Merchantdata(BuildContext context) {

    return FutureBuilder<List<MerchantDataModel>>(

      future: _Whatson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<MerchantDataModel>? posts = snapshot.data;
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
  }*/
  ListView _buildPostsHome(BuildContext context, List<MerchantDataModel> posts) {
    // showData=true;
    print("check2 "+ posts.toString());
    return ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        /*return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  InkWell(
                    onTap: (){

                    },

                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 10.0,
                      backgroundImage: NetworkImage(posts[index].merchant_logo),
                    ),
                    title: Text(posts[index].merchant_name),
                  ),
                ],
              )

            ],
          ),
        );*/
         // padding: const EdgeInsets.only(bottom:2.0),
         return InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => WhatsonDetailsFragment(

                  posts[index].merchant_name,
                  posts[index].merchant_id, posts[index].merchant_logo,
              ),

              ));
            },
           //  child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage(posts[index].merchant_logo),
                ),
                title: Text(posts[index].merchant_name,style: TextStyle(fontSize: 15.0),),
              ),
           // ),
          );
      },
    );
  }
}
