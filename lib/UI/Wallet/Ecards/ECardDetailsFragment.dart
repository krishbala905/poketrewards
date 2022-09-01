import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../Others/Urls.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';

import 'package:http/http.dart' as http;
import '../../../Others/CRCCheckCalculation2.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Utils.dart';
import '../Model/ECardDetailsLocationModel.dart';
import '../Model/ECardDetailsModel.dart';

class ECardDetailsFragment extends StatefulWidget {
  var prgmTittle ;
  var prgmImgUrl ;
  var tittle ;
  var prgMId ;
  var prgmType;
  var expire_date;
  var balancePoints;
  var subType,memberId;
   ECardDetailsFragment(this.tittle,this.prgMId,this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.balancePoints,this.subType,this.memberId,{Key? key}) : super(key: key);

  @override
  State<ECardDetailsFragment> createState() => _ECardDetailsFragmentState(tittle,prgMId,prgmType,prgmTittle,prgmImgUrl,expire_date,balancePoints,subType,memberId);
}

class _ECardDetailsFragmentState extends State<ECardDetailsFragment> {
  var myCardDetailsData;
  var tittle ;
  var prgMId ,memberid;
  var prgmType,subType;
  var prgmTittle,prgmImgUrl,expire_date,balancePoints;

  _ECardDetailsFragmentState(this.tittle, this.prgMId, this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.balancePoints,this.subType,this.memberid);

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
                Padding(
                  padding: const EdgeInsets.only(left:10,right: 10),
                  child: _ECardLocation(context),
                ),
                SizedBox(height: 15,),


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
                color: corporateColor,
                child: Center(
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
  ListView _buildPostsHomeLocation(BuildContext context, List<ECardDetailsLocationModel> posts) {
    return ListView.builder(

      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){

          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(height: 5,),
              if(posts[index].openinghrs!="")Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.access_time),
                  SizedBox(width: 5,),
                  Text(posts[index].openinghrs),
                ],),
              SizedBox(height: 5,),
              if(posts[index].shop_name!="")Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.store),
                  SizedBox(width: 5,),
                  Text(posts[index].shop_name),
                ],),
              SizedBox(height: 5,),
              if(posts[index].building_name!="")Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.location_city),
                  SizedBox(width: 5,),
                  Text(posts[index].building_name),
                ],),
              SizedBox(height: 5,),
              if(posts[index].address!="")Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 5,),
                  Text(utf8.decode(base64.decode(posts[index].address))),
                ],),
              SizedBox(height: 5,),
              if(posts[index].city_postal!="")Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 5,),
                  Text(posts[index].city_postal),
                ],),
              SizedBox(height: 5,),
              if(posts[index].tel!="")GestureDetector(
                onTap: (){
                  Utils().call(posts[index].tel);
                },
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Icon(Icons.call),
                    SizedBox(width: 5,),
                    Text(posts[index].tel),
                  ],),
              ),



            ],
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






  Future<ECardDetailsModel> getEcardDetailsData() async {


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
          return Center(
            child: CircularProgressIndicator(),
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
            SizedBox(height: 20,),
            Center(child: setCardUIImage(prgmImgUrl,tittle,posts.LogoURL,posts.MerchantLogoSettings,posts.ProgramTitleSettings,posts.FontColor)),
            SizedBox(height: 5,),
            Center(child: Text(cardExpiry+ expire_date)),
            SizedBox(height: 20,),
            setUICenterCardWidgetData(prgmType,posts),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Text(description,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
            ),

            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Html(data:utf8.decode(base64.decode(posts.Description))),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Text(terms_cond,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
            ),

            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
            child:Html(data:utf8.decode(base64.decode(posts.Tnc)))),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Text(location,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
            ),

          ],
        );
      }

    Widget setUserTierView(var userTire,var spinnerData){
    if(userTire==spinnerData[0]["CardTitle"]){
      return Column(
        children: [
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(child: Icon(Icons.check_circle,color: corporateColor,size: 15,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 15,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: black,size: 15,))),
              Expanded(flex:1,child: Container()),
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[0]["CardTitle"],style: TextStyle(fontSize: 10,color: corporateColor),
                ),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[1]["CardTitle"]
                  ,style: TextStyle(fontSize: 10),),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[2]["CardTitle"]
                  ,style: TextStyle(fontSize: 10),),
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
              Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 15,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              Expanded(flex:1,child: Center(child: Icon(Icons.check_circle,color: corporateColor,size: 15,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 15,))),
              Expanded(flex:1,child: Container()),
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[0]["CardTitle"],style: TextStyle(fontSize: 10,color: Colors.black),
                ),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[1]["CardTitle"]
                  ,style: TextStyle(fontSize: 10,color: corporateColor),),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[2]["CardTitle"]
                  ,style: TextStyle(fontSize: 10,color: Colors.black),),
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
              Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 15,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 15,))),
              Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
              Expanded(flex:1,child: Center(child: Icon(Icons.check_circle,color: corporateColor,size: 15,))),
              Expanded(flex:1,child: Container()),
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: [

              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[0]["CardTitle"],style: TextStyle(fontSize: 10,color: Colors.black),
                ),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[1]["CardTitle"]
                  ,style: TextStyle(fontSize: 10,color: Colors.black),),
              )),
              Expanded(flex:1,child: Container()),
              Expanded(flex:1,child: Center(
                child: Text(
                  spinnerData[2]["CardTitle"]
                  ,style: TextStyle(fontSize: 10,color: corporateColor),),
              )),
              Expanded(flex:1,child: Container()),
            ],
          ),
        ],
      );
    }

      return Text("");
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
                      // generateQRCode("",prgmType,"1","0",prgMId),

                      generateQRCodeForPOS(),

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
      if(prgmType=="packagecard"){
        // PackageCard
        return Container(
          width: double.infinity,
          color: lightGrey3,
          child: Column(
            children: [


              Padding(
                padding: const EdgeInsets.only(left:20,top:20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    posts.punch_package_desc.toString(),
                    style: TextStyle(
                        color: Colors.black, fontSize: 15),),
                ),
              ),
              SizedBox(height: 10,),

              setCardDetailsView(posts.punch_slot_status),

              SizedBox(height: 20,),

            ],
          ),
        );
        }
      else {
        //three tier card
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

                      decoration: BoxDecoration(
                          image: DecorationImage(
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
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),),
                          Text(points, style: TextStyle(
                              color: Colors.white, fontSize: 20),),

                        ],
                      )
                  ),
                  SizedBox(height: 10,),

                  setUserTierView(posts.spinner_data['curent_status'],
                      posts.spinner_data['spin_array']),

                  SizedBox(height: 20,),

                  Text("- " + posts.upgrade_data),

                  SizedBox(height: 20,),

                ],
              ),
            ),
          );
      }
  }

    Widget setCardDetailsView(var punch_slot_status) {
    punch_slot_status=punch_slot_status.toString();
    List<String> data=punch_slot_status.toString().split(",");


    return GridView.count(
      crossAxisCount: 5,



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

                    border: Border.all(color: Colors.black, )
                  ),
                  child: Center(child: Text((index+1).toString(),style: TextStyle(color: corporateColor),)),
                )
            ),
          );
        }
        else{
          return  Center(
                child: Image.asset('assets/icon_ok.png',width: 50,height: 50,),
          );
        }


      }),

    );
  }

  }


