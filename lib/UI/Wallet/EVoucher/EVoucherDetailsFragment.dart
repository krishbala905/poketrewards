import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../Others/AlertDialogUtil.dart';
import '../../../Others/CRCCheckCalculation2.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import '../Model/ECardAboutUsModel.dart';
import '../Model/EVoucherDetailsLocationModel.dart';
import '../Model/EVoucherDetailsModel.dart';

class EVoucherDetailsFragment extends StatefulWidget {
  var prgmTittle ;
  var categAction ;
  var prgmImgUrl ;
  var tittle ;
  var prgMId ;
  var prgmType;
  var expire_date,poketed;
  var subType,memberid;

  EVoucherDetailsFragment(this.tittle,this.prgMId,this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.memberid,this.subType,this.categAction,this.poketed,{Key? key}) : super(key: key);

  @override
  State<EVoucherDetailsFragment> createState() => _EVoucherDetailsFragmentState(tittle,prgMId,prgmType,prgmTittle,prgmImgUrl,expire_date,memberid,subType,categAction,poketed);
}

class _EVoucherDetailsFragmentState extends State<EVoucherDetailsFragment> {
  var myCardDetailsData;
  var tittle ;
  var merchantName;
  var categAction ;
  var prgMId ;
  var prgmType,poketed;
  var prgmTittle,prgmImgUrl,expire_date,memberid;
  var subtype;
  var fulrnuno="";

  _EVoucherDetailsFragmentState(this.tittle, this.prgMId, this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.memberid,this.subtype,this.categAction,this.poketed);


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(tittle,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: corporateColor,
      ),
      body: Column(

        children: [
          Expanded(flex: 15,child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ECardDetails(context),
                SizedBox(height: 5,),

                Padding(
                  padding: const EdgeInsets.only(left:1.0,right: 1),
                  child: _EVoucherLocation(context),
                ),
                SizedBox(height: 15,),

                _ECardAboutUs(context),
                SizedBox(height: 15,),
              ],
            ),

          )),

          showQrforVoucher(categAction),




        ],
      ),
    ),);
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

  Widget showQrforVoucher(var categAction){
    if(categAction!="promotion"){
      return Expanded(flex: 1,child: Row(
        children: [
          Expanded(flex:1,child:
          InkWell(
            onTap: (){

              showCardQRImage();
            },
            child: Container(
              color: corporateColor3,
              child: Center(
                child: Text(showCashierCode,style: TextStyle(color: Colors.white),),
              ),
            ),
          )
          ),
          Expanded(flex:1,child:
          InkWell(
            onTap: (){
              showManualPIN();
            },
            child: Container(
              color: corporateColor,
              child: Center(
                child: Text(cashierEnterStorePin,style: TextStyle(color: Colors.white),),
              ),
            ),
          )
          ),

        ],
      ));
    }
    else if(categAction=="promotion"){
      return Padding(
        padding: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
        child: InkWell(
          onTap:(){
            if(poketed=="no"){showAlertforPoketIt();}

          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: corporateColor,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Center(child: setPoketitbtn(poketed),
            ),
          ),
        ),
      );
    }
    else{
      return Container(

      );
    }
  }


  Future<List<EVoucherDetailsLocationModel>> getEcardLocationData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_DETAILS_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
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
    ).timeout(Duration(seconds: 30));



    if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True")
    {



      List<dynamic> body = jsonDecode(response.body)["data"]["Locations"];
      List<EVoucherDetailsLocationModel> posts1 = body.map((dynamic item) => EVoucherDetailsLocationModel.fromJson(item),).toList();

      return posts1;

    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<EVoucherDetailsLocationModel>> _EVoucherLocation(BuildContext context) {

    return FutureBuilder<List<EVoucherDetailsLocationModel>>(

      future: getEcardLocationData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<EVoucherDetailsLocationModel>? posts = snapshot.data;
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
  ListView _buildPostsHomeLocation(BuildContext context, List<EVoucherDetailsLocationModel> posts) {
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
                    SizedBox(width: 20,),
                    Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                      width: 30,height: 30,),
                    SizedBox(width: 20,),
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
                    SizedBox(width: 20,),

                    SizedBox(width: 20,),
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
                    SizedBox(width: 20,),
                    Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                      width: 30,height: 30,),
                    SizedBox(width: 20,),


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

  Future<EVoucherDetailsModel> getEcardDetailsData() async {


    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_DETAILS_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
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
    ).timeout(Duration(seconds: 30));



    if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True")
    {



      Map<String,dynamic> body = jsonDecode(response.body)["data"]["CardData"];
      EVoucherDetailsModel posts1=EVoucherDetailsModel.fromJson(body);

      return posts1;

    }
    else {

      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<EVoucherDetailsModel> _ECardDetails(BuildContext context) {

    return FutureBuilder<EVoucherDetailsModel>(

      future: getEcardDetailsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final EVoucherDetailsModel? posts = snapshot.data;
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
  Column _buildPostsHome(BuildContext context, EVoucherDetailsModel posts) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Center(child: setCardUIImage(prgmImgUrl,tittle,posts.LogoURL,posts.MerchantLogoSettings,posts.ProgramTitleSettings,posts.FontColor)),
            SizedBox(height: 5,),
            Center(child: Wrap(

              children: [

                Text(expiry+ expire_date,style: TextStyle(fontSize: 12),),
                SizedBox(width: 100,),
                setFullRunNO(no+ posts.circle_data["full_run_no"]+" "+memberid),
              ],
            )),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Text(description,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Html(data:utf8.decode(base64.decode(posts.Description))),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Text(terms_cond,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
            child:Html(data:utf8.decode(base64.decode(posts.Tnc)))),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Text(location,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 20,),


          ],
        );
      }


  Future<void> showManualPIN(){
    TextEditingController storpinController=TextEditingController();
    TextEditingController optionalRemarkController=TextEditingController();
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(5.0)),
            child: Container(

              height: 300,
              child: Padding(

                padding: const EdgeInsets.only(left:15.0,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
                    SizedBox(height: 20,),
                    Text(redeem_voucher,style: TextStyle(fontSize: 21,color: Colors.black),),
                    SizedBox(height: 10,),
                    Text(prgmTittle ,style: TextStyle(fontSize: 16,color: Colors.black),),
                    SizedBox(height: 10,),
                    TextField(
                      controller: storpinController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[

                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly

                      ],
                      decoration: InputDecoration(

                        hintText: enter_store_pin,
                        hintStyle: TextStyle(fontSize: 17,color: corporateColor),

                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: corporateColor, width: 0.0),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: corporateColor, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: corporateColor, width: 0.0),
                        ),

                      ),
                    ),
                    SizedBox(height: 5,),
                    TextField(
                      controller: optionalRemarkController,

                      decoration: InputDecoration(
                        hintText: optional_recipt,
                    enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            )
                    ),

                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (){Navigator.pop(context);},
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              height: 40,
                              width: double.maxFinite,
                                child: Center(child: Text(cancel.toUpperCase(),style: TextStyle(color: Colors.black45,fontSize: 13),)),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(

                          flex: 1,
                          child: MaterialButton(onPressed: (){
                            callRedeemAPIForVoucher(storpinController.text,optionalRemarkController.text);
                          },
                            height: 40,
                            color: corporateColor,
                            child: Text(redeem.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 13),),),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],

                ),
              ),
            ),
          );
        }
    );
  }


  Future<ECardAboutUsModel> getEcardAboutusData() async {
    print("------------------");
    print(CommonUtils.consumerID.toString());
    print(prgMId.toString());
    print(prgmType.toString());
    print(Utils().getTimeZone());
    print(Utils().getTimeStamp());
    print(CommonUtils.deviceModel);
    print("------------------");

    final http.Response response = await http.post(
      Uri.parse(WALLET_CARD_DETAILS_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
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
      print("error1ss:"+jsonDecode(response.body)["data"].toString());
      Map<String,dynamic> body = jsonDecode(response.body)["data"]["AboutUs"];

      ECardAboutUsModel posts1=ECardAboutUsModel.fromJson(body);

      return posts1;

    }
    else {
      print("error1");
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
  Container _buildPostsAbout(BuildContext context, ECardAboutUsModel posts){
    if(posts!=null){return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: Column(
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
          ),
        ),
      ),
    );}
    else{return Container();}

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


  Future<void> callRedeemAPIForVoucher(var redeemCode,var remarks) async {
    showLoadingView(context);

    final http.Response response = await http.post(
      Uri.parse(MANUAL_REDEEMPTION_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
        "program_type": prgmType.toString(),
        "redemption_code":redeemCode.toString(),
        "remarks":remarks.toString(),
        "serial_no":memberid.toString(),
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
    var status=json.decode(response.body)['p1'];
    var message=json.decode(response.body)['p2'];
    Navigator.pop(context);
    if(status=="False"){
      showAlertDialog_oneBtn(context, alert1, message);
    }
    else{
      showAlertDialog_oneBtnWitDismiss(context, alert1, message);
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
                      SizedBox(height: 20,),

                      Text(prgmTittle+"x" +"1" ,style: TextStyle(fontSize: 16,color: Colors.black),),
                      SizedBox(height: 30,),
                      Text(" SCAN CARD QR CODE ",style: TextStyle(fontSize: 21,color: Colors.black),),
                      SizedBox(height: 20,),
                      Center(child:

                      // generateQRCode(fullRunNo,prgmType,qty,giftcardOrderId,prgMId),
                      generateQRCode(fulrnuno,prgmType,"1","0",prgMId),
                      // generateQRCodeForPOS(fulrnuno),
                      ),
                      SizedBox(height: 20,),
                      MaterialButton(onPressed: (){
                        Navigator.pop(context,true);
                      },
                        color: corporateColor,
                        child: Text(cancel.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 13),),),
                      SizedBox(height: 20,),
                    ],

                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  Widget  generateQRCodeForPOS(String FullRunno,)  {

    var data1= CommonUtils.consumermobileNumber.toString().replaceAll("65 ", "");

    String data2="+65${data1.split(":")[0]}";

    var data3=FullRunno.replaceAll("No : ", "")+"*"+tittle+"*0*member*"+data2;
    var data4= base64Url.encode(utf8.encode(data3));


    return QrImage(
      data: data4,
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
          return Center(
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
      programCategoryType= int.parse(subtype );
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

  Widget setFullRunNO(String data){
      fulrnuno=data;
    return Text(data,
    style:  TextStyle(fontSize: 12),
    );
  }


  void showAlertforPoketIt(){
    String message="";
    if (prgmType=="vouchercard") {
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
                getVoucher();
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

  Future<void> getVoucher() async{
    showLoadingView(context);

    final http.Response response = await http.post(
      Uri.parse(PROMOTION_VOUCHER_DOWNLOAD_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
        "program_type": prgmType.toString(),

        "serial_no":memberid.toString(),
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

        sendToDownloadProgram();

      }
    }
    else{
      showAlertDialog_oneBtnWitDismiss(context, alert1, failed_try_again);
    }

  }

  Future<void> sendToDownloadProgram() async{
    showLoadingView(context);

    final http.Response response = await http.post(
      Uri.parse(VOUCHER_DOWNLOAD_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": prgMId.toString(),
        "program_type": prgmType.toString(),
        "outlet_id": prgmType.toString(),
        "serial_no":memberid.toString(),
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
}


