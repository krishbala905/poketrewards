import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/UI/Wallet/Model/ECardAboutUsModel.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Others/Urls.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import '../../../Others/CRCCheckCalculation2.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Utils.dart';
import '../Model/ECardDetailsLocationModel.dart';
import '../Model/ECardDetailsModel.dart';
import 'ECardRewardsModel.dart';

class ECardDetailsFragment extends StatefulWidget {
  var prgmTittle ;
  var prgmImgUrl ;
  var tittle ;
  var prgMId ;
  var prgmType;
  var expire_date;
  var balancePoints,merchantId;
  var subType,memberId;
   ECardDetailsFragment(this.tittle,this.prgMId,this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.balancePoints,this.subType,this.memberId,this.merchantId,{Key? key}) : super(key: key);

  @override
  State<ECardDetailsFragment> createState() => _ECardDetailsFragmentState(tittle,prgMId,prgmType,prgmTittle,prgmImgUrl,expire_date,balancePoints,subType,memberId,merchantId);
}

class _ECardDetailsFragmentState extends State<ECardDetailsFragment> {
  var myCardDetailsData;
  var tittle,merchantId ;
  var prgMId ,memberid;
  var prgmType,subType;
  var prgmTittle,prgmImgUrl,expire_date,balancePoints;

  _ECardDetailsFragmentState(this.tittle, this.prgMId, this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.balancePoints,this.subType,this.memberid,this.merchantId);
  bool showRewards=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: Column(

        children: [
          Expanded(flex: 15,child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ECardDetails(context),
                const SizedBox(height: 15,),

              ],
            ),

          )),
          Expanded(flex: 1,child: Row(
            children: [
              Expanded(flex:1,child:
              InkWell(
              onTap: (){
                showCardQRImage();
              },
              child: Container(
                color: corporateColor3,
                child: const Center(
                  child: Text(showCashierCode,style: TextStyle(color: Colors.white),),
                ),
              ),
              )
              ),

            ],
          )),

        ],
      ),
    ),);
  }

  Future<List<ECardDetailsLocationModel>> getEcardLocationData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_DETAILS_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
        "member_id": memberid,
        "program_type": prgmType.toString(),
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
      },
    ).timeout(const Duration(seconds: 30));



    if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True")
    {



      List<dynamic> body = jsonDecode(response.body)["data"]["Locations"];
      List<ECardDetailsLocationModel> posts1 = body.map((dynamic item) => ECardDetailsLocationModel.fromJson(item),).toList();

      return posts1;

    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<ECardDetailsLocationModel>> _ECardLocation(BuildContext context) {

    return FutureBuilder<List<ECardDetailsLocationModel>>(

      future: getEcardLocationData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<ECardDetailsLocationModel>? posts = snapshot.data;
          return _buildPostsHomeLocation(context, posts!);
        } else {
          return Center(
            child: Container(),
          );
        }
      },
    );
  }

  Widget setOperationHours(String data){
    if(data.contains("<br>")){
      return Html(data:data,style: {
        "body":Style(
            color:Colors.black54
        ),
      },);
    }
    else{return  Text(data,style: TextStyle(color:Colors.black54));}

  }
  ListView _buildPostsHomeLocation(BuildContext context, List<ECardDetailsLocationModel> posts) {
    return ListView.builder(

      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){

          },
          child: Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                if(posts[index].shop_name!="")Row(
                  children: [
                    SizedBox(width: 5,),
                    Icon(Icons.location_on_outlined,color:Colors.black54),
                    SizedBox(width: 5,),
                    Text(posts[index].shop_name,style: TextStyle(color:Colors.black54),),

                  ],),
                if(posts[index].address!="")Padding(
                  padding: const EdgeInsets.only(left:25.0),
                  child: Text(utf8.decode(base64.decode(posts[index].address)
                  ),style: TextStyle(color: Colors.black54),
                  ),
                ),

                SizedBox(height:10),
                if(posts[index].tel!="")GestureDetector(
                  onTap:(){
                    Utils().call(posts[index].tel.toString().replaceAll("~", ""));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 5,),
                      Icon(Icons.call,color:Colors.black54),
                      SizedBox(width: 5,),
                      Text(posts[index].tel.toString().replaceAll("~", ""),style: TextStyle(color:Colors.black54)),
                    ],),
                ),

                SizedBox(height:10),
                if(posts[index].openinghrs!="")Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5,),
                    Icon(Icons.access_time,color:Colors.black54),
                    SizedBox(width: 5,),
                    Expanded(child: setOperationHours(posts[index].openinghrs.toString())),
                  ],),





                // if(posts[index].building_name!="")Row(
                //   children: [
                //     SizedBox(width: 5,),
                //     Icon(Icons.location_city),
                //     SizedBox(width: 5,),
                //     Text(posts[index].building_name),
                //   ],),


                SizedBox(height: 5,),
                if(posts[index].city_postal!="")Row(
                  children: [
                    SizedBox(width: 5,),
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 5,),
                    Text(posts[index].city_postal),
                  ],),
                SizedBox(height: 5,),




              ],
            ),
          ),
        );
      },
    );
  }


  Future<List<ECardRewardsModel>> getEcardRewardsData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_DETAILS_URL),

      body: {
        "merchant_id": merchantId,
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
        "program_type": prgmType.toString(),
        "member_id": memberid.toString(),
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
      },
    ).timeout(const Duration(seconds: 30));

    debugPrint("consumer_id:"+ CommonUtils.consumerID.toString());
    debugPrint("program_id:"+ prgMId.toString());
    debugPrint("program_type:"+ prgmType.toString());
    debugPrint("cma_timestamps:"+Utils().getTimeStamp());
    debugPrint("time_zone:"+Utils().getTimeZone());
    debugPrint("software_version:"+CommonUtils.softwareVersion.toString());
    debugPrint("os_version:"+CommonUtils.osVersion.toString());
    debugPrint("phone_model:"+CommonUtils.deviceModel.toString());
    debugPrint("device_type:"+CommonUtils.deviceType.toString());
    debugPrint('consumer_application_type:'+CommonUtils.consumerApplicationType.toString());
    debugPrint('consumer_language_id'+CommonUtils.consumerLanguageId.toString());


    if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True")
    {
      if(jsonDecode(response.body)["data"]["Rewards"].toString()!=""){

        List<dynamic> body = jsonDecode(response.body)["data"]["Rewards"];
        List<ECardRewardsModel> posts1 = body.map((dynamic item) => ECardRewardsModel.fromJson(item),).toList();
        return posts1;
      }
      else{
        throw "Unable to retrieve posts.";
      }


    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<ECardRewardsModel>> _ECardRewards(BuildContext context) {

    return FutureBuilder<List<ECardRewardsModel>>(

      future: getEcardRewardsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
         final List<ECardRewardsModel>? posts = snapshot.data;
          return _buildPostsRewards(context, posts!);
        } else {
          return Center(
            child: Container(),
          );
        }
      },
    );
  }
  ListView _buildPostsRewards(BuildContext context, List<ECardRewardsModel> posts) {

  return ListView.builder(

      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left:10,right:10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:1,
                    child: Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: MediaQuery.of(context).size.width/5,
                      child:setCardUIImagefoRewardVoucher(posts[index].img_url,posts[index].program_title,posts[index].LogoURL,posts[index].MerchantLogoSettings,posts[index].ProgramTitleSettings,posts[index].FontColor,),
                    ),
                  ),

                  Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(posts[index].program_title),
                          SizedBox(height: 7,),
                          Wrap(

                            children: const [
                              Text(details,style: TextStyle(fontSize: 12),),
                              SizedBox(width: 5,),
                               Text(view,style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.black54,
                                decorationThickness: 4,
                                decorationStyle: TextDecorationStyle.dashed,

                              ),softWrap: true),
                            ],
                          ),
                          SizedBox(height: 10,),
                          if(posts[index].amt_to_purchase!=null && posts[index].amt_to_purchase!="" && balancePoints!=null)
                        showRedeemButtonOrLock(balancePoints,posts[index].amt_to_purchase),



                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 3,),
              Container(decoration: BoxDecoration(color: Colors.black12),height: 1,width: double.infinity,),
              SizedBox(height: 3,),
            ],
          ),
        );
      },
    );
  }
  Widget showRedeemButtonOrLock(var totalPoints,var voucherPoints){
    print("topints:"+totalPoints.toString());
    print("vcpints:"+voucherPoints.toString());
    var suffixKey="";
    var suffixKey1="";
    if(totalPoints.toString().contains("Points")){
      suffixKey=" points";
      suffixKey1="Points";
    }
    else if(totalPoints.toString().contains("Punches")){
      suffixKey=" punches";
      suffixKey1="Punches";
    }else if(totalPoints.toString().contains("more spending")){
      suffixKey=" punch";
      suffixKey1="more spending";
    }
    else{
      suffixKey=" none";
    }

    totalPoints=totalPoints.toString().replaceAll(suffixKey1, "");

    var t=0;
    if(totalPoints.toString().contains(",")){
      t=int.parse(totalPoints.toString().split(",")[1]);
    }
    else{
      t= int.parse(totalPoints);
    }

    assert(t is int);

    var v=int.parse(voucherPoints);
    assert(v is int);

    if(t>=v){
    return Container(

      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: corporateColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text(redeem,style: TextStyle(fontSize: 13,color: Colors.white),)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child:  Text(voucherPoints+suffixKey),
          ),
        ],
      ),
    );
  }

  else{
      if(prgmType=="checkincard"){
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/ic_lock.png",width: 25,height: 25,),
              Text(t.toString()+" "+check_in,style:TextStyle(color:corporateColor3)),
            ],
          ),
        );
      }
    else{
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/ic_lock.png",width: 25,height: 25,),
              Text(t.toString() +suffixKey,style:TextStyle(color:corporateColor3)),
            ],
          ),
        );
     }
  }
  }



  Future<ECardDetailsModel> getEcardDetailsData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_DETAILS_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
        "program_type": prgmType.toString(),
        "merchant_id": merchantId,
        "member_id": memberid.toString(),
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
    ).timeout(const Duration(seconds: 30));
    print("------------------");
    print(CommonUtils.consumerID.toString());
    print(prgMId.toString());
    print(prgmType.toString());
    print(Utils().getTimeZone());
    print(Utils().getTimeStamp());
    print(CommonUtils.deviceModel);
    print("------------------");

    if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True")
    {
      debugPrint("CardDetails:"+jsonDecode(response.body)["data"].toString(),wrapWidth: 1024);
      Map<String,dynamic> body = jsonDecode(response.body)["data"]["CardData"];
      ECardDetailsModel posts1=ECardDetailsModel.fromJson(body);

      return posts1;

    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<ECardDetailsModel> _ECardDetails(BuildContext context) {
    return FutureBuilder<ECardDetailsModel>(

      future: getEcardDetailsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final ECardDetailsModel? posts = snapshot.data;
          return _buildPostsHome(context, posts!);
        } else {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Column _buildPostsHome(BuildContext context, ECardDetailsModel posts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Center(child: setCardUIImage(prgmImgUrl,tittle,posts.LogoURL,posts.MerchantLogoSettings,posts.ProgramTitleSettings,posts.FontColor)),
            const SizedBox(height: 5,),
            Center(child: Text(cardExpiry+ expire_date)),
            const SizedBox(height: 20,),
            setUICenterCardWidgetData(prgmType,posts),

            // Rewards
            const SizedBox(height: 20,),
            Visibility(
              visible: showRewards,
              child: const Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Text(rewards,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal)),
              ),
            ),
            SizedBox(height:10),
            _ECardRewards(context),



            // Decription
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(left:10.0,right: 10),
              child: const Text(description,style:const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Html(data:utf8.decode(base64.decode(posts.Description))),
            ),


            //terms
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(left:10.0,right: 10),
              child: const Text(terms_cond,style:const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
            child:Html(data:utf8.decode(base64.decode(posts.Tnc)))),

            const SizedBox(height: 20,),

            setReferOption(posts),

            // location
            const Padding(
              padding: EdgeInsets.only(top:10,left: 10,right: 10),
              child: Text(location,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal)),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10,right: 10),
              child: _ECardLocation(context),
            ),


            // About Us

            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10,right: 10),
              child: _ECardAboutUs(context),
            ),

          ],
        );
      }


  Future<ECardAboutUsModel> getEcardAboutusData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_DETAILS_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
        "program_type": prgmType.toString(),
        "merchant_id": merchantId,
        "member_id": memberid,
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
    ).timeout(const Duration(seconds: 30));
    print("------------------");
    print(CommonUtils.consumerID.toString());
    print(prgMId.toString());
    print(prgmType.toString());
    print(Utils().getTimeZone());
    print(Utils().getTimeStamp());
    print(CommonUtils.deviceModel);
    print("------------------");


    if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True")
    {

      Map<String,dynamic> body = jsonDecode(response.body)["data"]["AboutUs"];
      print("AboutUs: "+jsonDecode(response.body)["data"]["AboutUs"].toString());
      ECardAboutUsModel posts1=ECardAboutUsModel.fromJson(body);

      return posts1;

    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<ECardAboutUsModel> _ECardAboutUs(BuildContext context) {
    return FutureBuilder<ECardAboutUsModel>(

      future: getEcardAboutusData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final ECardAboutUsModel? posts = snapshot.data;
           return _buildPostsAbout(context, posts!);
        } else {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Column _buildPostsAbout(BuildContext context, ECardAboutUsModel posts){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if(posts.brandlogo!=null && posts.brandname!=null
            && posts.branddescription!=null && posts.websiteurl!=null
            && posts.instagramurl!=null && posts.facebookurl!=null && posts.galleryurls!=null
        )Text(about_us,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal)),
        if(posts.brandlogo!="" && posts.brandlogo!=null)Image.network(posts.brandlogo,width: 70,height: 70,),
        SizedBox(height: 5,),
        if(posts.brandname!="" && posts.brandname!=null)Text(posts.brandname),
        SizedBox(height: 5,),
        if(posts.branddescription!="" && posts.branddescription!=null)Html(data:utf8.decode(base64.decode(posts.branddescription))),
        SizedBox(height: 5,),
        if(posts.websiteurl!="" && posts.websiteurl!=null)Row(
          children: [
            Image.asset("assets/web_icon.png",width: 20,height:20),
            SizedBox(width: 5,),
            Text(posts.websiteurl),
          ],
        ),
        SizedBox(height: 8,),
        if(posts.facebookurl!="" && posts.facebookurl!=null)Row(
          children: [
            Image.asset("assets/facebook_icon.png",width: 20,height:20),
            SizedBox(width: 5,),
            Text(posts.facebookurl),
          ],
        ),
        SizedBox(height: 8,),
        if(posts.instagramurl!="" && posts.instagramurl!=null)Row(
          children: [
            Image.asset("assets/instagram_icon.png",width: 20,height:20),
            SizedBox(width: 5,),
            Text(posts.instagramurl),
          ],
        ),
        SizedBox(height: 5,),
        if(posts.galleryurls!="" && posts.galleryurls!=null)loadGalleryUrls(posts.galleryurls),
        SizedBox(height: 5,),
      ],
    );
  }
  Widget loadGalleryUrls(var galleryUrl){
    if(galleryUrl==""){
      return Container();
    }
    else{
      List<String> galleryUrls=galleryUrl.toString().split("~~~");
      return CarouselSlider(
          options: CarouselOptions(

            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 10),
          ),
        items: galleryUrls
            .map((item) => Container(
          child: Center(
              child:
              Image.network(item,fit:BoxFit.cover, width: 300,height: 150,)),
        ))
            .toList(),
      );


    }
  }
  Widget setReferOption(ECardDetailsModel posts){

    if(posts.ReferFriendOption=="no"){
      return Container();
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          //Refer Friend Block

          const Padding(
            padding: EdgeInsets.only(left:10.0,right: 10),
            child:  Text(refer_friend,style:const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
          ),
          // Html(data:utf8.decode(base64.decode(posts.ReferrelDescription))),
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Html(data:utf8.decode(base64.decode(posts.ReferrelDescription))),
          ),



          const SizedBox(height: 5,),
          GestureDetector(
            onTap: (){

              var referFriendContent=utf8.decode(base64.decode(posts.ReferFriendContent));

              showReferAlertDialogForMultipleShare(context,referFriendContent);
            },
            child: Center(
              child: Container(

              width: 180,
                decoration: BoxDecoration(
                    border: Border.all(color: corporateColor),
                    color: Colors.white,borderRadius: BorderRadius.circular(25)),
                child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/refer_friend_icon.png",height: 25,width: 25,),
                      const Text(refer_friend_caps,style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),

        ],
      );
    }
  }

  showReferAlertDialogForMultipleShare(BuildContext context,var content){
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,

      actions: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10,right:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                const Text(contactUs_content,style: TextStyle(fontSize: 15,color:Colors.grey),),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    _launchEmail(content);
                  },
                  child: Text(email,style: TextStyle(fontSize: 15),),
                ),
                SizedBox(height: 20,),


                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    _launchFacebook(content);
                  },
                  child: Text(facebook,style: TextStyle(fontSize: 15),),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    _launchTwitter(content);
                  },
                  child: Text(twitter,style: TextStyle(fontSize: 15),),
                ),

                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    _launchWhatsapp(content,context);
                  },
                  child: Text(whatsapp,style: TextStyle(fontSize: 15),),
                ),
                SizedBox(height: 25,),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:15.0),
          child: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(cancel,style: TextStyle(fontSize: 15,color: corporateColor2),),
            ),
          ),
        )
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: alert);
      },
    );
  }

  Widget setCardUIImagefoRewardVoucher(var imgUrl,var tittle,var logoUrl,var showLogo,var showTittle,var fontColor){
    if(showLogo=="1" && showTittle=="1"){
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          child: Stack(

            children: [
              Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),
                    Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                      width: 30,height: 30,),
                    Text(tittle,style: TextStyle(fontSize:11 ,color: hexStringToColor(fontColor)),maxLines: 3),

                  ],
                ),
              ),
            ],

          ),
        ),
      );
    }
    else if(showLogo=="0" && showTittle=="1"){
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          child: Stack(
            children: [
              Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),
                    Text(tittle,style: TextStyle(fontSize:11,color: hexStringToColor(fontColor)),maxLines: 3),

                  ],
                ),
              ),
            ],

          ),
        ),
      );
    }
    else if(showLogo=="1" && showTittle=="0"){
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          child: Stack(
            children: [
              Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),
                    Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                      width: 30,height: 30,),
                    const SizedBox(width: 20,),


                  ],
                ),
              ),
            ],

          ),
        ),
      );
    }
    else{
      return Center(child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          child: Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,)));
    }
  }
  Widget setCardUIImage(var imgUrl,var tittle,var logoUrl,var showLogo,var showTittle,var fontColor){
    if(showLogo=="1" && showTittle=="1"){
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          child: Stack(

            children: [
              Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),
                    Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                      width: 30,height: 30,),
                    const SizedBox(width: 20,),
                    Text(tittle,style: TextStyle(fontSize:15 ,color: hexStringToColor(fontColor)),maxLines: 3),

                  ],
                ),
              ),
            ],

          ),
        ),
      );
    }
    else if(showLogo=="0" && showTittle=="1"){
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          child: Stack(
            children: [
              Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),

                    const SizedBox(width: 20,),
                    Text(tittle,style: TextStyle(fontSize:15,color: hexStringToColor(fontColor)),maxLines: 3),

                  ],
                ),
              ),
            ],

          ),
        ),
      );
    }
    else if(showLogo=="1" && showTittle=="0"){
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          child: Stack(
            children: [
              Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),
                    Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                      width: 30,height: 30,),
                    const SizedBox(width: 20,),


                  ],
                ),
              ),
            ],

          ),
        ),
      );
    }
    else{
      return Center(child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          child: Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,)));
    }
  }

  Widget setUserThreeTierView(var userTire,var spinnerData){
    if(userTire==spinnerData[0]["CardTitle"]){
      return Column(
        children: [
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              const Expanded(flex:1,child: Center(child: Icon(Icons.check_circle,color: corporateColor,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: black,size: 20,))),
              Expanded(flex:1,child: Container()),
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: corporateColor),
                ),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[1]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10),),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[2]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10),),
              )),
              Expanded(flex:1,child: Container()),
            ],
          ),
        ],
      );

    }
    else if(userTire==spinnerData[1]["CardTitle"]){
      return Column(
        children: [
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              const Expanded(flex:1,child: Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: const Center(child: Icon(Icons.check_circle,color: corporateColor,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: const Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
              Expanded(flex:1,child: Container()),
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: Colors.black),
                ),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[1]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10,color: corporateColor),),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[2]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10,color: Colors.black),),
              )),
              Expanded(flex:1,child: Container()),
            ],
          ),
        ],
      );
    }
    else if(userTire==spinnerData[2]["CardTitle"]){
      return Column(
        children: [
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              const Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: Center(child: const Icon(Icons.check_circle,color: corporateColor,size: 20,))),
              Expanded(flex:1,child: Container()),
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: Colors.black),
                ),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[1]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10,color: Colors.black),),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[2]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10,color: corporateColor),),
              )),
              Expanded(flex:1,child: Container()),
            ],
          ),
        ],
      );
    }
    return const Text("");
 }
  Widget setUserTwoTierView(var userTire,var spinnerData){
    if(userTire==spinnerData[0]["CardTitle"]){
      return Column(
        children: [
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              const Expanded(flex:1,child: Center(child: Icon(Icons.check_circle,color: corporateColor,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
              Expanded(flex:1,child: Container()),
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: corporateColor),
                ),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[1]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10),),
              )),
              Expanded(flex:1,child: Container()),

            ],
          ),
        ],
      );

    }
    else if(userTire==spinnerData[1]["CardTitle"]){
      return Column(
        children: [
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              const Expanded(flex:1,child: Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: const Center(child: Icon(Icons.check_circle,color: corporateColor,size: 20,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              const Expanded(flex:1,child: const Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
              Expanded(flex:1,child: Container()),
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: Colors.black),
                ),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[1]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10,color: corporateColor),),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[2]["CardTitle"]
                  ,style: const TextStyle(fontSize: 10,color: Colors.black),),
              )),
              Expanded(flex:1,child: Container()),
            ],
          ),
        ],
      );
    }

    return const Text("");
  }

  Future<void> showCardQRImage(){
      return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return SingleChildScrollView(
            child: Dialog(
              alignment: Alignment.topCenter,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10.0)),
              child: Container(

                height: 550,
                child: Padding(

                  padding: const EdgeInsets.only(left:15.0,right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
                      const SizedBox(height: 20,),

                      Text(prgmTittle+"x" +"1" ,style: const TextStyle(fontSize: 16,color: Colors.black),),
                      const SizedBox(height: 30,),
                      const Text(" SCAN CARD QR CODE ",style: TextStyle(fontSize: 21,color: Colors.black),),
                      const SizedBox(height: 20,),
                      Center(child:

                      // generateQRCode(fullRunNo,prgmType,qty,giftcardOrderId,prgMId),
                      generateQRCode("",prgmType,"1","0",prgMId),

                      // generateQRCodeForPOS(),

                      ),
                      const SizedBox(height: 20,),
                      MaterialButton(onPressed: (){
                        Navigator.pop(context,true);
                      },
                        color: corporateColor,
                        child: Text(cancel.toUpperCase(),style: const TextStyle(color: Colors.white,fontSize: 13),),),
                      const SizedBox(height: 20,),
                    ],

                  ),
                ),
              ),
            ),
          );
        }
      );
      }
  Widget  generateQRCodeForPOS()  {

    var data1= CommonUtils.consumermobileNumber.toString().replaceAll("65 ", "");

    var data2="+65"+data1.split(":")[0];

    var data3= base64Url.encode(utf8.encode(data2));

      return QrImage(
        data: data3,
        version: QrVersions.auto,
        size: 300,
        gapless: false,

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
  Widget generateQRCode(String FullRunno,String ProgramType,String qty1,String GiftCardOrderId,String prgmId){
      return FutureBuilder(
        future:  getdata1(FullRunno, ProgramType, qty1,GiftCardOrderId, prgmId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final String post = snapshot.data.toString();
            return   QrImage(

              data: post,
              version: QrVersions.auto,
              size: 300,
              gapless: false,

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
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      },
      );

    }
  Future<String> getdata1(String FullRunno,String ProgramType,String qty1,String GiftCardOrderId,String prgmId) async {
      int programId ;

      if(ProgramType.toLowerCase()=="events"){
        programId = int.parse(GiftCardOrderId) ;
      }
      else{
        programId = int.parse(prgmId);
      }

      int countryIndex= int.parse(CommonUtils.COUNTRY_INDEX.toString());

      int programCategoryType;

      if(ProgramType=="events"){
        programCategoryType=18;
      }
      else{
        programCategoryType= int.parse(subType );
      }

      int programType=1;
      if(prgmType=="vouchercard")
      {
        programType=3;
      }
      else if(prgmType=="storecard")
      {
        programType=2;
      }

      else
      {
        programType=1;
      }

      String actionType;
       var consumerName ;
      if (programType == 1) {
        actionType = "ms";
        int memberId =int.parse(memberid);


        CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType, countryIndex,0,0);
        consumerName = await crc2.checkNewCRC(programCategoryType);
      }

      else if (programType == 2) {
        actionType = "sc";
        int memberId = int.parse(memberid) ;

        CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType, countryIndex,0,0);
        consumerName = await crc2.checkNewCRC(programCategoryType);
      } else if (programType == 3) {
        actionType = "rv";
        //String vouche         rNo = program.getSerialNumber();
        int memberId = int.parse(memberid);

        CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId,memberId, actionType, countryIndex,0,0);
        consumerName =await crc2.checkNewCRC(programCategoryType);

      }
      else if (programType == 17) {
        actionType = "rv";
        //String voucherNo = program.getSerialNumber();
        int memberId = int.parse(memberid );
        CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType,
            countryIndex,int.parse(qty1),int.parse(GiftCardOrderId ));
        consumerName =await crc2.checkNewCRC(programCategoryType);

      }

      else if (programType == 18) {
        actionType = "events";



        // CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(
        //     programId, ParseAsInteger(FullRunno),
        //     actionType, countryIndex,0,0);
        // consumerName = crc2.checkNewCRC(programCategoryType);

      }
      return consumerName;
    }

    Widget setUICenterCardWidgetData(var prgmType,ECardDetailsModel posts) {
      if (prgmType == "packagecard") {
        // PackageCard
        return Container(
          width: double.infinity,
          color: lightGrey3,
          child: Column(
            children: [


              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    posts.punch_package_desc.toString(),
                    style: const TextStyle(
                        color: Colors.black, fontSize: 15),),
                ),
              ),
              const SizedBox(height: 10,),

              setCardDetailsView(posts.punch_slot_status),

              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[

                  checkUpgradeData(posts.upgrade_data),

                  const SizedBox(height: 10,),

                  checkPointsExpiryView(posts.PointExpiry),

                ],                    ),

              const SizedBox(height: 20,),

            ],
          ),
        );
      }
      else if (prgmType == "punchcard") {
        // PackageCard
        return Container(
          width: double.infinity,
          color: lightGrey3,
          child: Column(
            children: [


              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    posts.punch_package_desc.toString(),
                    style: const TextStyle(
                        color: Colors.black, fontSize: 15),),
                ),
              ),
              const SizedBox(height: 10,),

              setCardDetailsView(posts.punch_slot_status),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[

                  checkUpgradeData(posts.upgrade_data),

                  const SizedBox(height: 10,),

                  checkPointsExpiryView(posts.PointExpiry),

                ],                    ),

              const SizedBox(height: 20,),

            ],
          ),
        );
      }
      else if (prgmType == "discountcard") {
        // DiscountCard
        return Container();
      }
      else if (prgmType == "checkincard") {
        // DiscountCard
        return Container();
      }
      else if (prgmType == "storecard") {
        return
          Container(
            width: double.infinity,
            color: lightGrey3,
            child: Center(
              child: Column(
                children: [
                  Container(
                      width: 300,
                      height: 300,

                      decoration: const BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/storecard_bg.png'),
                          )
                      ),
                      child:


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            posts.circle_data["point1"], style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),),
                          SizedBox(height: 10,),
                          Text("${posts.circle_data["currency1"]} ${posts
                              .circle_data["desc1"]}", style: const TextStyle(
                              color: Colors.white, fontSize: 14),),

                          SizedBox(height: 15,),

                          if(posts.circle_data["points2"] != null &&
                              posts.circle_data["points2"] != "")
                            Text(
                              posts.circle_data["points2"],
                              style: const TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                          SizedBox(height: 10,),

                          if(posts.circle_data["desc2"] != null &&
                              posts.circle_data["desc2"] != "")
                            Text(posts.circle_data["desc2"],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),),
                        ],
                      )
                  ),
                  const SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      checkUpgradeData(posts.upgrade_data),

                      const SizedBox(height: 10,),

                      checkPointsExpiryView(posts.PointExpiry),

                    ],                    ),

                  const SizedBox(height: 20,),

                ],
              ),
            ),
          );
      }
      else if (prgmType == "cashbackcard") {
        return
          Container(
            width: double.infinity,
            color: lightGrey3,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 300,
                      height: 300,

                      decoration: const BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/cashback_bg.png'),
                          )
                      ),
                      child:


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // posts.circle_data["point1"],style: const TextStyle(color: Colors.white, fontSize: 20),),
                            balancePoints.toString().replaceAll("INR", ""),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),),
                          SizedBox(height: 10,),
                          Text("${posts.circle_data["currency1"]} ${posts
                              .circle_data["desc1"]}", style: const TextStyle(
                              color: Colors.white, fontSize: 14),),

                        ],
                      )
                  ),
                  const SizedBox(height: 10,),
                  checkUpgradeData(posts.upgrade_data),

                  const SizedBox(height: 10,),

                  checkPointsExpiryView(posts.PointExpiry),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          );
      }
      else if (prgmType == "membercard" && posts.spinner_data["spin_array"] != null) {
        var membercardSpinerLength = jsonDecode(jsonEncode(posts.spinner_data["spin_array"])).length;
        //twotier
        if (membercardSpinerLength == 2) {
          print("twotier");
          return
            Container(
              width: double.infinity,
              color: lightGrey3,
              child: Center(
                child: Column(
                  children: [
                    Container(
                        width: 300,
                        height: 300,

                        decoration: const BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/pointcard_bg.png'),
                            )
                        ),
                        child:


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              balancePoints.toString().replaceAll("Points", ""),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),),
                            const Text(points, style: const TextStyle(
                                color: Colors.white, fontSize: 20),),

                          ],
                        )
                    ),
                    const SizedBox(height: 10,),

                    setUserTwoTierView(posts.spinner_data['curent_status'],
                        posts.spinner_data['spin_array']),

                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[

                        checkUpgradeData(posts.upgrade_data),

                        const SizedBox(height: 10,),

                        checkPointsExpiryView(posts.PointExpiry),

                      ],                    ),

                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            );
        }
        // three tier
        else {
          print("threetier");
          return
            Container(
              width: double.infinity,
              color: lightGrey3,
              child: Center(
                child: Column(
                  children: [
                    Container(
                        width: 300,
                        height: 300,

                        decoration: const BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/pointcard_bg.png'),
                            )
                        ),
                        child:


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              balancePoints.toString().replaceAll("Points", ""),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),),
                            const Text(points, style: const TextStyle(
                                color: Colors.white, fontSize: 20),),

                          ],
                        )
                    ),
                    const SizedBox(height: 10,),

                    setUserThreeTierView(posts.spinner_data['curent_status'],
                        posts.spinner_data['spin_array']),

                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[

                        checkUpgradeData(posts.upgrade_data),

                        const SizedBox(height: 10,),

                        checkPointsExpiryView(posts.PointExpiry),

                      ],                    ),

                    const SizedBox(height: 20,),

                  ],
                ),
              ),
            );
        }
      }

      else {
        // Single tier
        print("singletier");
        return
          Container(
            width: double.infinity,
            color: lightGrey3,
            child: Center(
              child: Column(
                children: [
                  Container(
                      width: 300,
                      height: 300,

                      decoration: const BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/pointcard_bg.png'),
                          )
                      ),
                      child:


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            balancePoints.toString().replaceAll("Points", ""),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),),
                          const Text(points, style: const TextStyle(
                              color: Colors.white, fontSize: 20),),

                        ],
                      )
                  ),
                  const SizedBox(height: 10,),
                  //
                  // setUserThreeTierView(posts.spinner_data['curent_status'],
                  //     posts.spinner_data['spin_array']),

                  const SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      checkUpgradeData(posts.upgrade_data),

                      const SizedBox(height: 10,),

                      checkPointsExpiryView(posts.PointExpiry),

                    ],                    ),

                  const SizedBox(height: 20,),

                ],
              ),
            ),
          );
      }
    }

  Widget checkPointsExpiryView(var pointsExpiry){

    if(pointsExpiry.toString()=="These points will expires once the card has expired"){

      return Container();
    }
    else if(pointsExpiry==null && pointsExpiry=="" ){

      return Container();
    }
    else{

      return Row(

        children: [
          setPointsExpiryLabel(),

          GestureDetector( onTap:(){
            if(pointsExpiry.toString().contains("<br>")){
              pointsExpiry=pointsExpiry.toString().replaceAll("<br>","");
            }
            showAlertDialogoneBtn_lc(context, pointsExpiry);

          },
              child: Text(view,style: TextStyle(
                  decoration: TextDecoration.underline,
              ),)),
        ],

      );
    }
  }
  Widget setPointsExpiryLabel(){
    if(prgmType.toString()=="cashbackcard"){ return Text(rebateExpiry);}

    else{return Text(pointsExpiry);}

  }

  Widget checkUpgradeData(var upgradeData){
    print("gokultest");
    if(upgradeData!=null && upgradeData!=""){
      return Text("- " + upgradeData);
    }
    else{

      return Container();
    }
  }
  Widget setCardDetailsView(var punch_slot_status) {
    punch_slot_status=punch_slot_status.toString();
    List<String> data=punch_slot_status.toString().split(",");


    return GridView.count(
      crossAxisCount: 5,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(data.length, (index)  {

        if(data[index]=="empty"){
          return  Center(
            child: Container(

                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(color: Colors.black, ),
                  ),
                  child: Center(child: Text((index+1).toString(),style: const TextStyle(color: corporateColor),)),
                )
            ),
          );
        }
        else if(data[index]=="togift"){
          return  Center(
            child: Container(

                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: Border.all(color: Colors.black, )
                  ),
                  child: Image.asset('assets/yet_to_punched_icon.png',width: 50,height: 50,),
                  ),
                )

          );
        }
        else if(data[index]=="gifted"){
          return  Center(
            child: Container(

                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: Border.all(color: Colors.black, )
                  ),
                  child: Image.asset('assets/punched_icon.png',width: 50,height: 50,),
                  ),
                )

          );
        }
        else{
          return  Center(
                child: Image.asset('assets/star_icon.png',width: 50,height: 50,),
          );
        }


      }),
    );
  }


  _launchWhatsapp(var content,BuildContext context) async {

    var whatsappAndroid = Uri.parse(
        // "whatsapp://send?phone=$whatsapp&text=" + content+" "+link);
        "whatsapp://send?&text=" + content);
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }
  _launchEmail(var content) async {
    final Email email = Email(
      subject: content,
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
  _launchTwitter(var content){}
  _launchFacebook(var content){}





}


