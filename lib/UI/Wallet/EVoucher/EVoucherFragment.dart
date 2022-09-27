import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:poketrewards/Others/Urls.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import '../Model/ECardModel.dart';
import '../Model/EVoucherModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'EVoucherDetailsFragment.dart';
class EVoucherFragment extends StatefulWidget {
  const EVoucherFragment({Key? key}) : super(key: key);

  @override
  State<EVoucherFragment> createState() => _EVoucherFragmentState ();
}

class _EVoucherFragmentState  extends State<EVoucherFragment> {
  bool showData=false;

  @override
  void initState() {
    // TODO: implement initState
    _EVoucher(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: Visibility(
          visible: showData,
            child: Center(child: Text(no_vchr_found,style: TextStyle(color: corporateColor),),),
            replacement: _EVoucher(context)),
      ),
    ));
  }


  Future<List<EVoucherModel>> getEvoucherData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
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



    if(jsonDecode(response.body)["Status"]=="True")
    {



      List<dynamic> body = jsonDecode(response.body)["data"]["Vouchers"];
      List<EVoucherModel> posts1 = body.map((dynamic item) => EVoucherModel.fromJson(item),).toList();

      return posts1;

    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<EVoucherModel>> _EVoucher(BuildContext context) {

    return FutureBuilder<List<EVoucherModel>>(

      future: getEvoucherData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<EVoucherModel>? posts = snapshot.data;
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
  ListView _buildPostsHome(BuildContext context, List<EVoucherModel> posts) {
    showData=true;
    return ListView.builder(


      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => EVoucherDetailsFragment(
                posts[index].program_title,
                posts[index].program_id, posts[index].program_type,
                posts[index].program_title, posts[index].img_url,
                posts[index].expire_date,posts[index].member_id,
                posts[index].sub_type,"categAction","poketed"
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
                    setVoucherUIImage(
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
                          check30Days(posts[index].expire_date),
                          SizedBox(height: 4,),
                          Text(posts[index].expire_date,style: TextStyle(color: corporateColor,fontSize: 14,),),

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
          // child: Container(),
        );
      },
    );
  }

  Widget check30Days(var date){
    List temp=date.toString().split("-");


    var date1 = DateTime(int.parse(temp[2]), int.parse(temp[1]), int.parse(temp[0]));
    var date2 = DateTime.now();
    var difference = date1.difference(date2).inDays;

    if(difference<=30){
      return Container(
        decoration: BoxDecoration(
          color: corporateColor
        ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(difference.toString()+" "+daysLeft,style: TextStyle(color: Colors.white,fontSize: 14,),),
          ));
    }
    else{
     return Text("");
    }
  }

  Widget setVoucherUIImage(var imgUrl,var tittle,var logoUrl,var showLogo,var showTittle,var fontColor){
    if(showLogo=="1" && showTittle=="1"){
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
                Text(tittle,style: TextStyle(fontSize: 10,color: hexStringToColor(fontColor)),maxLines: 3),

              ],
            ),
          ),
        ],

      );
    }
    else if(showLogo=="0" && showTittle=="1"){
      return Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imgUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          Image.network(imgUrl),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),

                SizedBox(width: 10,),
                Text(tittle,style: TextStyle(fontSize:10,color: hexStringToColor(fontColor)),maxLines: 3),

              ],
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

