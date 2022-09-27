import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/UI/Catalogue/ServiceInitModel.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
class StartActivity extends StatefulWidget {
  var id,title;
   StartActivity(this.id,this.title,{Key? key}) : super(key: key);

  @override
  State<StartActivity> createState() => _StartActivityState(id,title);
}

class _StartActivityState extends State<StartActivity> {
  var title = " ";
  var id = " ";

  _StartActivityState(this.id,this.title);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: corporateColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children:<Widget> [
          Container(
            height: 600.0,
          width: double.infinity,
          child:  _ServiceActivity(context),
          ),
          ],
          ),
      ),
    ));
  }
  FutureBuilder<List<ServiceInitModel>> _ServiceActivity(BuildContext context) {

    return FutureBuilder<List<ServiceInitModel>>(

      future: ServiceDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<ServiceInitModel>? posts = snapshot.data;
          if(posts!=null){
            return _buildPostsHome(context, posts);
          }
          else{
            return Container();
          }
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
  Future<List<ServiceInitModel>> ServiceDetails() async {


    final http.Response response = await http.post(
      Uri.parse(SERVICE_BANNER_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        /*"cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),*/
        "action_event":"1",
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        "device_TokenID":CommonUtils.deviceTokenID,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        'item_id':id,
      },
    ).timeout(Duration(seconds: 30));

    debugPrint("check6"+ response.body.toString());


    if(response.statusCode==200 && jsonDecode(response.body)['SubBannersData']!="")
    {
     /*Map<String, dynamic> body1 = jsonDecode(response.body);
      print("check8"+body1['SubBannersData'][0]['category_name'].toString());*/
      List<dynamic> body = jsonDecode(response.body)["SubBannersData"];
      debugPrint("check9"+body.toString());
      List<ServiceInitModel> posts1 = body.map((dynamic item) => ServiceInitModel.fromJson(item),).toList();
      return posts1;


    }
    else {

      throw "Unable to retrieve posts.";
    }

  }
  ListView _buildPostsHome(BuildContext context, List<ServiceInitModel> posts) {
    // showData=true;
    print("check2 "+ posts.toString());
    return ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        // padding: const EdgeInsets.only(bottom:2.0),
        return Card(
          child: Column(
             children: <Widget>[
               Image.network(posts[index].categoryImage),
               SizedBox(
                 height: 5.0,
               ),
               Container(
                 height: 500.0,
                   child: WebView(
                     initialUrl: posts[index].categoryfile,
                     javascriptMode: JavascriptMode.unrestricted,
                   ),
               ),

                    ],
          )

          );
      },
    );
  }
}
