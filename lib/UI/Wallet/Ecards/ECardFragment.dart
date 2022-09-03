import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:poketrewards/Others/Urls.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../Model/ECardModel.dart';
import 'ECardDetailsFragment.dart';
import 'ECardPrimaryFragment.dart';

class ECardFragment extends StatefulWidget {
  const ECardFragment({Key? key}) : super(key: key);

  @override
  State<ECardFragment> createState() => _ECardFragmentState();
}

class _ECardFragmentState extends State<ECardFragment> {
  bool showData=false;
  @override
  void initState() {
    // TODO: implement initState
    _ECard(context);
    // ConsumerTab().getInboxUnreadMessageCount();

    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: _ECard(context),
      ),
    ));
  }


  Future<List<ECardModel>> getEcardData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "order_data": "newest",
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



    if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True")
    {


      List<dynamic> body = jsonDecode(response.body)["data"]["Cards"];
      List<ECardModel> posts1 = body.map((dynamic item) => ECardModel.fromJson(item),).toList();

      return posts1;

    }
    else {
      throw "Unable to retrieve posts.";
    }
  //
  }
  FutureBuilder<List<ECardModel>> _ECard(BuildContext context) {

    return FutureBuilder<List<ECardModel>>(

      future: getEcardData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<ECardModel>? posts = snapshot.data;
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
  ListView _buildPostsHome(BuildContext context, List<ECardModel> posts) {
    showData=true;
    return ListView.builder(


      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => ECardPrimaryFragment(

            posts[index].program_title,
            posts[index].program_id, posts[index].program_type,
            posts[index].program_title, posts[index].img_url,posts[index].expire_date,
            posts[index].balance,posts[index].sub_type,posts[index].member_id,
            posts[index].merchant_id,posts[index].merchant_name,
            ),

            ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex:4,child:
                    setCardUIImage(
                        posts[index].img_url,
                        posts[index].program_title,
                        posts[index].LogoURL,
                        posts[index].MerchantLogoSettings,
                        posts[index].ProgramTitleSettings,
                        posts[index].FontColor,
                      ),
                    ),
                    Expanded(flex:6,child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            SizedBox(height: 8,),
                            Text(posts[index].program_title,style: TextStyle(color: corporateColor,fontSize: 17,fontWeight: FontWeight.bold),),
                            SizedBox(height: 4,),
                            Text(posts[index].merchant_name,style: TextStyle(color: Colors.black,fontSize: 14,),),
                            SizedBox(height: 4,),
                            Text(posts[index].expire_date+" | "+posts[index].balance ,style: TextStyle(color: corporateColor,fontSize: 14,),),
                            SizedBox(height: 8,),
                        ],
                      ),
                    )),

                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(height: 1,color: Colors.black12,),
            ],
          ),
        );
      },
    );
  }



  Widget setCardUIImage(var imgUrl,var tittle,var logoUrl,var showLogo,var showTittle,var fontColor){
    if(showLogo=="1" && showTittle=="1"){
      return Stack(
        children: [
          Image.network(imgUrl),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Row (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                  width: 20,height: 20,),
                SizedBox(width: 10,),
                Text(tittle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize:10 ,color: hexStringToColor(fontColor)),

                ),

              ],
            ),
          ),
        ],

      );
    }
    else if(showLogo=="0" && showTittle=="1"){
      return Stack(
        children: [
          Image.network(imgUrl),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Center(
              child: Text(tittle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize:10,color: hexStringToColor(fontColor))),
            ),
          ),
        ],

      );
    }
    else if(showLogo=="1" && showTittle=="0"){
      return Stack(
        children: [
          Image.network(imgUrl),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                  width: 20,height: 20,),
                SizedBox(width: 10,),


              ],
            ),
          ),
        ],

      );
    }
    else{
      return Image.network(imgUrl);
    }
  }


}
