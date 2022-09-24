// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:poketrewards/UI/Wallet/Ecards/Model1/ECardAllDetailsModel.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../Others/Urls.dart';
// import '../../../res/Colors.dart';
// import '../../../res/Strings.dart';
//
// import 'package:http/http.dart' as http;
// import '../../../Others/CRCCheckCalculation2.dart';
// import '../../../Others/CommonUtils.dart';
// import '../../../Others/Utils.dart';
// import 'Wallet/Ecards/ECardRewardsModel.dart';
// import 'Wallet/Model/ECardDetailsLocationModel.dart';
// import 'Wallet/Model/ECardDetailsModel.dart';
//
//
// class ECardDetailsFragment extends StatefulWidget {
//   var prgmTittle ;
//   var prgmImgUrl ;
//   var tittle ;
//   var prgMId ;
//   var prgmType;
//   var expire_date;
//   var balancePoints,merchantId;
//   var subType,memberId;
//    ECardDetailsFragment(this.tittle,this.prgMId,this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.balancePoints,this.subType,this.memberId,this.merchantId,{Key? key}) : super(key: key);
//
//   @override
//   State<ECardDetailsFragment> createState() => _ECardDetailsFragmentState(tittle,prgMId,prgmType,prgmTittle,prgmImgUrl,expire_date,balancePoints,subType,memberId,merchantId);
// }
//
// class _ECardDetailsFragmentState extends State<ECardDetailsFragment> {
//   var myCardDetailsData;
//   var tittle, merchantId;
//
//   var prgMId, memberid;
//   var prgmType, subType;
//   var prgmTittle, prgmImgUrl, expire_date, balancePoints;
//
//   _ECardDetailsFragmentState(this.tittle, this.prgMId, this.prgmType,
//       this.prgmTittle, this.prgmImgUrl, this.expire_date, this.balancePoints,
//       this.subType, this.memberid, this.merchantId);
//
//   bool showRewards = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(
//
//       body: Column(
//
//         children: [
//           Expanded(flex: 15, child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _ECardAllDetails(context),
//                 const SizedBox(height: 15,),
//
//               ],
//             ),
//
//           )),
//           Expanded(flex: 1, child: Row(
//             children: [
//               Expanded(flex: 1, child:
//               InkWell(
//                 onTap: () {
//                   showCardQRImage();
//                 },
//                 child: Container(
//                   color: corporateColor3,
//                   child: const Center(
//                     child: Text(showCashierCode,
//                       style: TextStyle(color: Colors.white),),
//                   ),
//                 ),
//               )
//               ),
//
//             ],
//           )),
//
//         ],
//       ),
//     ),);
//   }
//
//   Future<void> showCardQRImage(){
//     return showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context){
//           return SingleChildScrollView(
//             child: Dialog(
//               alignment: Alignment.topCenter,
//               shape: RoundedRectangleBorder(
//                   borderRadius:
//                   BorderRadius.circular(10.0)),
//               child: Container(
//
//                 height: 550,
//                 child: Padding(
//
//                   padding: const EdgeInsets.only(left:15.0,right: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children:[
//                       // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
//                       const SizedBox(height: 20,),
//
//                       Text(prgmTittle+"x" +"1" ,style: const TextStyle(fontSize: 16,color: Colors.black),),
//                       const SizedBox(height: 30,),
//                       const Text(" SCAN CARD QR CODE ",style: TextStyle(fontSize: 21,color: Colors.black),),
//                       const SizedBox(height: 20,),
//                       Center(child:
//
//                       // generateQRCode(fullRunNo,prgmType,qty,giftcardOrderId,prgMId),
//                       generateQRCode("",prgmType,"1","0",prgMId),
//
//                         // generateQRCodeForPOS(),
//
//                       ),
//                       const SizedBox(height: 20,),
//                       MaterialButton(onPressed: (){
//                         Navigator.pop(context,true);
//                       },
//                         color: corporateColor,
//                         child: Text(cancel.toUpperCase(),style: const TextStyle(color: Colors.white,fontSize: 13),),),
//                       const SizedBox(height: 20,),
//                     ],
//
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }
//   Widget  generateQRCodeForPOS()  {
//
//     var data1= CommonUtils.consumermobileNumber.toString().replaceAll("65 ", "");
//
//     var data2="+65"+data1.split(":")[0];
//
//     var data3= base64Url.encode(utf8.encode(data2));
//
//     return QrImage(
//       data: data3,
//       version: QrVersions.auto,
//       size: 300,
//       gapless: false,
//
//       errorStateBuilder: (cxt, err) {
//         return Container(
//           child: Center(
//             child: Text(
//               err.toString(),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//       },
//
//     );
//   }
//   Widget generateQRCode(String FullRunno,String ProgramType,String qty1,String GiftCardOrderId,String prgmId){
//     return FutureBuilder(
//       future:  getdata1(FullRunno, ProgramType, qty1,GiftCardOrderId, prgmId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           final String post = snapshot.data.toString();
//           return   QrImage(
//
//             data: post,
//             version: QrVersions.auto,
//             size: 300,
//             gapless: false,
//
//             errorStateBuilder: (cxt, err) {
//               return Container(
//                 child: Center(
//                   child: Text(
//                     err.toString(),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//         else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//
//   }
//   Future<String> getdata1(String FullRunno,String ProgramType,String qty1,String GiftCardOrderId,String prgmId) async {
//     int programId ;
//
//     if(ProgramType.toLowerCase()=="events"){
//       programId = int.parse(GiftCardOrderId) ;
//     }
//     else{
//       programId = int.parse(prgmId);
//     }
//
//     int countryIndex= int.parse(CommonUtils.COUNTRY_INDEX.toString());
//
//     int programCategoryType;
//
//     if(ProgramType=="events"){
//       programCategoryType=18;
//     }
//     else{
//       programCategoryType= int.parse(subType );
//     }
//
//     int programType=1;
//     if(prgmType=="vouchercard")
//     {
//       programType=3;
//     }
//     else if(prgmType=="storecard")
//     {
//       programType=2;
//     }
//
//     else
//     {
//       programType=1;
//     }
//
//     String actionType;
//     var consumerName ;
//     if (programType == 1) {
//       actionType = "ms";
//       int memberId =int.parse(memberid);
//
//
//       CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType, countryIndex,0,0);
//       consumerName = await crc2.checkNewCRC(programCategoryType);
//     }
//
//     else if (programType == 2) {
//       actionType = "sc";
//       int memberId = int.parse(memberid) ;
//
//       CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType, countryIndex,0,0);
//       consumerName = await crc2.checkNewCRC(programCategoryType);
//     } else if (programType == 3) {
//       actionType = "rv";
//       //String vouche         rNo = program.getSerialNumber();
//       int memberId = int.parse(memberid);
//
//       CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId,memberId, actionType, countryIndex,0,0);
//       consumerName =await crc2.checkNewCRC(programCategoryType);
//
//     }
//     else if (programType == 17) {
//       actionType = "rv";
//       //String voucherNo = program.getSerialNumber();
//       int memberId = int.parse(memberid );
//       CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType,
//           countryIndex,int.parse(qty1),int.parse(GiftCardOrderId ));
//       consumerName =await crc2.checkNewCRC(programCategoryType);
//
//     }
//
//     else if (programType == 18) {
//       actionType = "events";
//
//
//
//       // CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(
//       //     programId, ParseAsInteger(FullRunno),
//       //     actionType, countryIndex,0,0);
//       // consumerName = crc2.checkNewCRC(programCategoryType);
//
//     }
//     return consumerName;
//   }
//
//
//   Future<ECardAllDetailsModel> getEcardDetailsData() async {
//     final http.Response response = await http.post(
//       Uri.parse(WALLET_CARD_DETAILS_URL),
//
//       body: {
//         "consumer_id": CommonUtils.consumerID.toString(),
//         "program_id": prgMId.toString(),
//         "program_type": prgmType.toString(),
//         "merchant_id": merchantId,
//         "action_event": "1",
//         "cma_timestamps": Utils().getTimeStamp(),
//         "time_zone": Utils().getTimeZone(),
//         "software_version": CommonUtils.softwareVersion,
//         "os_version": CommonUtils.osVersion,
//         "phone_model": CommonUtils.deviceModel,
//         "device_type": CommonUtils.deviceType,
//         'consumer_application_type': CommonUtils.consumerApplicationType,
//         'consumer_language_id': CommonUtils.consumerLanguageId,
//       },
//     ).timeout(const Duration(seconds: 30));
//     print("------------------");
//     print(CommonUtils.consumerID.toString());
//     print(prgMId.toString());
//     print(prgmType.toString());
//     print(Utils().getTimeZone());
//     print(Utils().getTimeStamp());
//     print(CommonUtils.deviceModel);
//     print("------------------");
//
//     if (response.statusCode == 200 &&
//         jsonDecode(response.body)["Status"] == "True") {
//       Map<String, dynamic> body = jsonDecode(response.body)["data"];
//
//       ECardAllDetailsModel posts1;
//       try{
//         posts1 = ECardAllDetailsModel.fromJson(body);
//       }catch(e){print("ero1"+e.toString());}
//
//       return ECardAllDetailsModel.fromJson(body);
//     }
//     else {
//       print("gokul1");
//       throw "Unable to retrieve posts.";
//     }
//     //
//   }
//
//
//
//   FutureBuilder<ECardAllDetailsModel> _ECardAllDetails(BuildContext context) {
//     return FutureBuilder<ECardAllDetailsModel>(
//
//       future: getEcardDetailsData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           final ECardAllDetailsModel? posts = snapshot.data;
//           print("Gokul"+posts.toString());
//           return _buildPostsHome(context, posts!);
//         } else {
//           return const Center(
//             child: const CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
//
//   Widget setCardUIImagefoRewardVoucher(var imgUrl,var tittle,var logoUrl,var showLogo,var showTittle,var fontColor){
//     if(showLogo=="1" && showTittle=="1"){
//       return Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width/1.5,
//           child: Stack(
//
//             children: [
//               Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
//               Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(width: 20,),
//                     Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
//                       width: 30,height: 30,),
//                     Text(tittle,style: TextStyle(fontSize:11 ,color: hexStringToColor(fontColor)),maxLines: 3),
//
//                   ],
//                 ),
//               ),
//             ],
//
//           ),
//         ),
//       );
//     }
//     else if(showLogo=="0" && showTittle=="1"){
//       return Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width/1.5,
//           child: Stack(
//             children: [
//               Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
//               Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(width: 20,),
//                     Text(tittle,style: TextStyle(fontSize:11,color: hexStringToColor(fontColor)),maxLines: 3),
//
//                   ],
//                 ),
//               ),
//             ],
//
//           ),
//         ),
//       );
//     }
//     else if(showLogo=="1" && showTittle=="0"){
//       return Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width/1.5,
//           child: Stack(
//             children: [
//               Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
//               Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(width: 20,),
//                     Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
//                       width: 30,height: 30,),
//                     const SizedBox(width: 20,),
//
//
//                   ],
//                 ),
//               ),
//             ],
//
//           ),
//         ),
//       );
//     }
//     else{
//       return Center(child: Container(
//           width: MediaQuery.of(context).size.width/1.5,
//           child: Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,)));
//     }
//   }
//   Widget setCardUIImage(var imgUrl,var tittle,var logoUrl,var showLogo,var showTittle,var fontColor){
//     if(showLogo=="1" && showTittle=="1"){
//       return Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width/1.5,
//           child: Stack(
//
//             children: [
//               Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
//               Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(width: 20,),
//                     Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
//                       width: 30,height: 30,),
//                     const SizedBox(width: 20,),
//                     Text(tittle,style: TextStyle(fontSize:15 ,color: hexStringToColor(fontColor)),maxLines: 3),
//
//                   ],
//                 ),
//               ),
//             ],
//
//           ),
//         ),
//       );
//     }
//     else if(showLogo=="0" && showTittle=="1"){
//       return Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width/1.5,
//           child: Stack(
//             children: [
//               Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
//               Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(width: 20,),
//
//                     const SizedBox(width: 20,),
//                     Text(tittle,style: TextStyle(fontSize:15,color: hexStringToColor(fontColor)),maxLines: 3),
//
//                   ],
//                 ),
//               ),
//             ],
//
//           ),
//         ),
//       );
//     }
//     else if(showLogo=="1" && showTittle=="0"){
//       return Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width/1.5,
//           child: Stack(
//             children: [
//               Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,),
//               Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(width: 20,),
//                     Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
//                       width: 30,height: 30,),
//                     const SizedBox(width: 20,),
//
//
//                   ],
//                 ),
//               ),
//             ],
//
//           ),
//         ),
//       );
//     }
//     else{
//       return Center(child: Container(
//           width: MediaQuery.of(context).size.width/1.5,
//           child: Image.network(imgUrl,width: MediaQuery.of(context).size.width/1.5,)));
//     }
//   }
//   Widget setUserThreeTierView(var userTire,var spinnerData){
//     if(userTire==spinnerData[0]["CardTitle"]){
//       return Column(
//         children: [
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               const Expanded(flex:1,child: Center(child: Icon(Icons.check_circle,color: corporateColor,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: black,size: 20,))),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//           const SizedBox(height: 4,),
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: corporateColor),
//                 ),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[1]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10),),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[2]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10),),
//               )),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//         ],
//       );
//
//     }
//     else if(userTire==spinnerData[1]["CardTitle"]){
//       return Column(
//         children: [
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               const Expanded(flex:1,child: Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: const Center(child: Icon(Icons.check_circle,color: corporateColor,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: const Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//           const SizedBox(height: 4,),
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: Colors.black),
//                 ),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[1]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10,color: corporateColor),),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[2]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10,color: Colors.black),),
//               )),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//         ],
//       );
//     }
//     else if(userTire==spinnerData[2]["CardTitle"]){
//       return Column(
//         children: [
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               const Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: Center(child: const Icon(Icons.check_circle,color: corporateColor,size: 20,))),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//           const SizedBox(height: 4,),
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: Colors.black),
//                 ),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[1]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10,color: Colors.black),),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[2]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10,color: corporateColor),),
//               )),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//         ],
//       );
//     }
//     return const Text("");
//   }
//   Widget setUserTwoTierView(var userTire,var spinnerData){
//     if(userTire==spinnerData[0]["CardTitle"]){
//       return Column(
//         children: [
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               const Expanded(flex:1,child: Center(child: Icon(Icons.check_circle,color: corporateColor,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: Center(child: Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//           const SizedBox(height: 4,),
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: corporateColor),
//                 ),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[1]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10),),
//               )),
//               Expanded(flex:1,child: Container()),
//
//             ],
//           ),
//         ],
//       );
//
//     }
//     else if(userTire==spinnerData[1]["CardTitle"]){
//       return Column(
//         children: [
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               const Expanded(flex:1,child: Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: const Center(child: Icon(Icons.check_circle,color: corporateColor,size: 20,))),
//               Expanded(flex:1,child: Container(height: 1,color: Colors.black,)),
//               const Expanded(flex:1,child: const Center(child: const Icon(Icons.circle_outlined,color: Colors.black,size: 20,))),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//           const SizedBox(height: 4,),
//           Row(
//             children: [
//
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[0]["CardTitle"],style: const TextStyle(fontSize: 10,color: Colors.black),
//                 ),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[1]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10,color: corporateColor),),
//               )),
//               Expanded(flex:1,child: Container()),
//               Expanded(flex:1,child: Center(
//                 child: Text(
//                   spinnerData[2]["CardTitle"]
//                   ,style: const TextStyle(fontSize: 10,color: Colors.black),),
//               )),
//               Expanded(flex:1,child: Container()),
//             ],
//           ),
//         ],
//       );
//     }
//
//     return const Text("");
//   }
//   Widget setUICenterCardWidgetData(var prgmType,ECardDetailsModel posts) {
//     debugPrint(prgmType);
//     if(prgmType=="packagecard"){
//       // PackageCard
//       return Container(
//         width: double.infinity,
//         color: lightGrey3,
//         child: Column(
//           children: [
//
//
//             Padding(
//               padding: const EdgeInsets.only(left:20,top:20),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   posts.punch_package_desc.toString(),
//                   style: const TextStyle(
//                       color: Colors.black, fontSize: 15),),
//               ),
//             ),
//             const SizedBox(height: 10,),
//
//             setCardDetailsView(posts.punch_slot_status),
//
//             const SizedBox(height: 20,),
//
//           ],
//         ),
//       );
//     }
//     else if(prgmType=="punchcard"){
//       // PackageCard
//       return Container(
//         width: double.infinity,
//         color: lightGrey3,
//         child: Column(
//           children: [
//
//
//             Padding(
//               padding: const EdgeInsets.only(left:20,top:20),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   posts.punch_package_desc.toString(),
//                   style: const TextStyle(
//                       color: Colors.black, fontSize: 15),),
//               ),
//             ),
//             const SizedBox(height: 10,),
//
//             setCardDetailsView(posts.punch_slot_status),
//
//             const SizedBox(height: 20,),
//
//           ],
//         ),
//       );
//     }
//     else if(prgmType=="storecard"){
//       return
//         Container(
//           width: double.infinity,
//           color: lightGrey3,
//           child: Center(
//             child: Column(
//               children: [
//                 Container(
//                     width: 300,
//                     height: 300,
//
//                     decoration: const BoxDecoration(
//                         image: const DecorationImage(
//                           image: AssetImage('assets/storecard_bg.png'),
//                         )
//                     ),
//                     child:
//
//
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           posts.circle_data["point1"],style: const TextStyle(color: Colors.white, fontSize: 20),),
//                         SizedBox(height: 10,),
//                         Text("${posts.circle_data["currency1"]} ${posts.circle_data["desc1"]}", style: const TextStyle(color: Colors.white, fontSize: 14),),
//
//                       ],
//                     )
//                 ),
//                 const SizedBox(height: 10,),
//
//
//
//
//               ],
//             ),
//           ),
//         );
//     }
//     else if(prgmType=="cashbackcard"){
//       return
//         Container(
//           width: double.infinity,
//           color: lightGrey3,
//           child: Center(
//             child: Column(
//               children: [
//                 Container(
//                     width: 300,
//                     height: 300,
//
//                     decoration: const BoxDecoration(
//                         image: const DecorationImage(
//                           image: AssetImage('assets/cashback_bg.png'),
//                         )
//                     ),
//                     child:
//
//
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           // posts.circle_data["point1"],style: const TextStyle(color: Colors.white, fontSize: 20),),
//                           balancePoints.toString().replaceAll("INR", ""),style: const TextStyle(color: Colors.white, fontSize: 20),),
//                         SizedBox(height: 10,),
//                         Text("${posts.circle_data["currency1"]} ${posts.circle_data["desc1"]}", style: const TextStyle(color: Colors.white, fontSize: 14),),
//
//                       ],
//                     )
//                 ),
//                 const SizedBox(height: 10,),
//
//
//
//
//               ],
//             ),
//           ),
//         );
//     }
//
//     else {
//
//       var membercardSpinerLength=jsonDecode(jsonEncode(posts.spinner_data["spin_array"])).length;
//
//       //twotier
//       if(membercardSpinerLength==2){
//         return
//           Container(
//             width: double.infinity,
//             color: lightGrey3,
//             child: Center(
//               child: Column(
//                 children: [
//                   Container(
//                       width: 300,
//                       height: 300,
//
//                       decoration: const BoxDecoration(
//                           image: const DecorationImage(
//                             image: AssetImage('assets/pointcard_bg.png'),
//                           )
//                       ),
//                       child:
//
//
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             balancePoints.toString().replaceAll("Points", ""),
//                             style: const TextStyle(
//                                 color: Colors.white, fontSize: 20),),
//                           const Text(points, style: const TextStyle(
//                               color: Colors.white, fontSize: 20),),
//
//                         ],
//                       )
//                   ),
//                   const SizedBox(height: 10,),
//
//                   setUserTwoTierView(posts.spinner_data['curent_status'],
//                       posts.spinner_data['spin_array']),
//
//                   const SizedBox(height: 20,),
//
//                   Text("- " + posts.upgrade_data),
//
//                   const SizedBox(height: 20,),
//
//                 ],
//               ),
//             ),
//           );
//       }
//
//       // three tier
//       else{
//         return
//           Container(
//             width: double.infinity,
//             color: lightGrey3,
//             child: Center(
//               child: Column(
//                 children: [
//                   Container(
//                       width: 300,
//                       height: 300,
//
//                       decoration: const BoxDecoration(
//                           image: const DecorationImage(
//                             image: AssetImage('assets/pointcard_bg.png'),
//                           )
//                       ),
//                       child:
//
//
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             balancePoints.toString().replaceAll("Points", ""),
//                             style: const TextStyle(
//                                 color: Colors.white, fontSize: 20),),
//                           const Text(points, style: const TextStyle(
//                               color: Colors.white, fontSize: 20),),
//
//                         ],
//                       )
//                   ),
//                   const SizedBox(height: 10,),
//
//                   setUserThreeTierView(posts.spinner_data['curent_status'],
//                       posts.spinner_data['spin_array']),
//
//                   const SizedBox(height: 20,),
//
//                   Text("- " + posts.upgrade_data),
//
//                   const SizedBox(height: 20,),
//
//                 ],
//               ),
//             ),
//           );
//       }
//
//     }
//   }
//   Widget setCardDetailsView(var punch_slot_status) {
//     punch_slot_status=punch_slot_status.toString();
//     List<String> data=punch_slot_status.toString().split(",");
//
//
//     return GridView.count(
//       crossAxisCount: 5,
//       physics: const ScrollPhysics(),
//       shrinkWrap: true,
//       children: List.generate(data.length, (index)  {
//
//         if(data[index]=="empty"){
//           return  Center(
//             child: Container(
//
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//
//                       border: Border.all(color: Colors.black, )
//                   ),
//                   child: Center(child: Text((index+1).toString(),style: const TextStyle(color: corporateColor),)),
//                 )
//             ),
//           );
//         }
//         else if(data[index]=="togift"){
//           return  Center(
//               child: Container(
//
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//
//                       border: Border.all(color: Colors.black, )
//                   ),
//                   child: Image.asset('assets/yet_to_punch_icon.png',width: 50,height: 50,),
//                 ),
//               )
//
//           );
//         }
//         else{
//           return  Center(
//             child: Image.asset('assets/icon_ok.png',width: 50,height: 50,),
//           );
//         }
//
//
//       }),
//     );
//   }
//
//
//   _launchWhatsapp(var content) async {
//
//     var whatsappAndroid = Uri.parse(
//       // "whatsapp://send?phone=$whatsapp&text=" + content+" "+link);
//         "whatsapp://send?&text=" + content);
//     if (await canLaunchUrl(whatsappAndroid)) {
//       await launchUrl(whatsappAndroid);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("WhatsApp is not installed on the device"),
//         ),
//       );
//     }
//   }
//   _launchEmail(var content) async {
//     final Email email = Email(
//       subject: content,
//       isHTML: false,
//     );
//
//     await FlutterEmailSender.send(email);
//   }
//   _launchTwitter(var content){}
//   _launchFacebook(var content){}
//
//   ListView _buildPostsRewards(BuildContext context, List<ECardRewardsModel> posts) {
//
//     return ListView.builder(
//
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: posts.length,
//
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex:1,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width/3,
//                     height: MediaQuery.of(context).size.width/5,
//                     child:setCardUIImagefoRewardVoucher(posts[index].img_url,posts[index].program_title,posts[index].LogoURL,posts[index].MerchantLogoSettings,posts[index].ProgramTitleSettings,posts[index].FontColor,),
//                   ),
//                 ),
//
//                 Expanded(
//                   flex:2,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(posts[index].program_title),
//                       SizedBox(height: 7,),
//                       Wrap(
//
//                         children: const [
//                           Text(details,style: TextStyle(fontSize: 12),),
//                           SizedBox(width: 5,),
//                           Text(view,style: TextStyle(
//                             fontSize: 12,
//                             decoration: TextDecoration.underline,
//                             decorationColor: Colors.black54,
//                             decorationThickness: 4,
//                             decorationStyle: TextDecorationStyle.dashed,
//
//                           ),softWrap: true),
//                         ],
//                       ),
//                       SizedBox(height: 10,),
//                       showRedeemButtonOrLock(balancePoints,posts[index].amt_to_purchase),
//
//
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//             SizedBox(height: 3,),
//             Container(decoration: BoxDecoration(color: Colors.black12),height: 1,width: double.infinity,),
//             SizedBox(height: 3,),
//           ],
//         );
//       },
//     );
//   }
//   Widget showRedeemButtonOrLock(var totalPoints,var voucherPoints){
//     print("topints:"+totalPoints.toString());
//     var suffixKey="";
//     var suffixKey1="";
//     if(totalPoints.toString().contains("Points")){
//       suffixKey=" points";
//       suffixKey1="Points";
//     }
//     else if(totalPoints.toString().contains("Punches")){
//       suffixKey=" punches";
//       suffixKey1="Punches";
//     }else if(totalPoints.toString().contains("more spending")){
//       suffixKey=" punch";
//       suffixKey1="more spending";
//     }
//     else{
//       suffixKey=" none";
//     }
//
//     totalPoints=totalPoints.toString().replaceAll(suffixKey1, "");
//     var t= int.parse(totalPoints);
//     assert(t is int);
//
//     var v=int.parse(voucherPoints);
//     assert(v is int);
//
//     if(t>=v){
//       return Container(
//
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: corporateColor
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Center(child: Text(redeem,style: TextStyle(fontSize: 13,color: Colors.white),)),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(right: 20.0),
//               child: Text(voucherPoints+suffixKey),
//             ),
//           ],
//         ),
//       );
//     }
//     else{
//       return Container(
//         child: Image.asset("assets/ic_lock.png",width: 10,height: 10,),
//       );
//     }
//   }
//   showReferAlertDialogForMultipleShare(BuildContext context,var content){
//     AlertDialog alert = AlertDialog(
//       backgroundColor: Colors.white,
//
//       actions: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.only(left:10,right:10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 15,),
//                 const Text(contactUs_content,style: TextStyle(fontSize: 15,color:Colors.grey),),
//                 SizedBox(height: 15,),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context, true);
//                     _launchEmail(content);
//                   },
//                   child: Text(email,style: TextStyle(fontSize: 15),),
//                 ),
//                 SizedBox(height: 20,),
//
//
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context, true);
//                     _launchFacebook(content);
//                   },
//                   child: Text(facebook,style: TextStyle(fontSize: 15),),
//                 ),
//                 SizedBox(height: 20,),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context, true);
//                     _launchTwitter(content);
//                   },
//                   child: Text(twitter,style: TextStyle(fontSize: 15),),
//                 ),
//
//                 SizedBox(height: 20,),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context, true);
//                     _launchWhatsapp(content);
//                   },
//                   child: Text(whatsapp,style: TextStyle(fontSize: 15),),
//                 ),
//                 SizedBox(height: 25,),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right:15.0),
//           child: GestureDetector(
//             onTap: (){Navigator.pop(context);},
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: Text(cancel,style: TextStyle(fontSize: 15,color: corporateColor2),),
//             ),
//           ),
//         )
//       ],
//     );
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return new BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: alert);
//       },
//     );
//   }
//   Widget setReferOption(ECardDetailsModel posts){
//
//     if(posts.ReferFriendOption=="yes"){
//       return Container();
//     }
//     else{
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//
//         children: [
//
//           //Refer Friend Block
//
//           const Padding(
//             padding: EdgeInsets.only(left:10.0,right: 10),
//             child:  Text(refer_friend,style:const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
//           ),
//           // Html(data:utf8.decode(base64.decode(posts.ReferrelDescription))),
//           Padding(
//             padding: const EdgeInsets.only(left:10.0),
//             child: Html(data:utf8.decode(base64.decode(posts.ReferrelDescription))),
//           ),
//
//
//
//           const SizedBox(height: 5,),
//           GestureDetector(
//             onTap: (){
//
//               var referFriendContent=utf8.decode(base64.decode(posts.ReferFriendContent));
//
//               showReferAlertDialogForMultipleShare(context,referFriendContent);
//             },
//             child: Center(
//               child: Container(
//
//                 width: 180,
//                 decoration: BoxDecoration(
//                     border: Border.all(color: corporateColor),
//                     color: Colors.white,borderRadius: BorderRadius.circular(25)),
//                 child:Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Image.asset("assets/refer_friend_icon.png",height: 25,width: 25,),
//                       const Text(refer_friend_caps,style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20,),
//
//         ],
//       );
//     }
//   }
//   ListView _buildPostsHomeLocation(BuildContext context, List<ECardDetailsLocationModel> posts) {
//     return ListView.builder(
//
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: posts.length,
//
//       itemBuilder: (context, index) {
//         return InkWell(
//           onTap: (){
//
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//
//               const SizedBox(height: 5,),
//               if(posts[index].openinghrs!="")Row(
//                 children: [
//                   const SizedBox(width: 5,),
//                   const Icon(Icons.access_time),
//                   const SizedBox(width: 5,),
//                   Text(posts[index].openinghrs),
//                 ],),
//               const SizedBox(height: 5,),
//               if(posts[index].shop_name!="")Row(
//                 children: [
//                   const SizedBox(width: 5,),
//                   const Icon(Icons.location_on_outlined),
//                   const SizedBox(width: 5,),
//                   Text(posts[index].shop_name),
//                 ],),
//               const SizedBox(height: 5,),
//               if(posts[index].building_name!="")Row(
//                 children: [
//                   const SizedBox(width: 5,),
//                   const Icon(Icons.location_city),
//                   const SizedBox(width: 5,),
//                   Text(posts[index].building_name),
//                 ],),
//               const SizedBox(height: 5,),
//               if(posts[index].address!="")Row(
//                 children: [
//                   const SizedBox(width: 5,),
//                   const Icon(Icons.location_on_outlined),
//                   const SizedBox(width: 5,),
//                   Text(utf8.decode(base64.decode(posts[index].address))),
//                 ],),
//               const SizedBox(height: 5,),
//               if(posts[index].city_postal!="")Row(
//                 children: [
//                   const SizedBox(width: 5,),
//                   const Icon(Icons.location_on_outlined),
//                   const SizedBox(width: 5,),
//                   Text(posts[index].city_postal),
//                 ],),
//               const SizedBox(height: 5,),
//               if(posts[index].tel!="")GestureDetector(
//                 onTap: (){
//                   Utils().call(posts[index].tel);
//                 },
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5,),
//                     const Icon(Icons.call),
//                     const SizedBox(width: 5,),
//                     Text(posts[index].tel),
//                   ],),
//               ),
//
//
//
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Column _buildPostsHome(BuildContext context, ECardAllDetailsModel posts1) {
//     debugPrint("rew:"+posts1.Rewards.toString());
//     debugPrint("loacta:"+posts1.Locations.toString());
//     debugPrint("card:"+posts1.CardData.toString());
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const SizedBox(height: 20,),
//         // Center(child: setCardUIImage(
//         //     prgmImgUrl, tittle, posts.LogoURL, posts.MerchantLogoSettings,
//         //     posts.ProgramTitleSettings, posts.FontColor)),
//         const SizedBox(height: 5,),
//         // Center(child: Text(cardExpiry + expire_date)),
//         // const SizedBox(height: 20,),
//         // setUICenterCardWidgetData(prgmType, posts),
//         //
//         // // Rewards
//         // const SizedBox(height: 20,),
//         // Visibility(
//         //   visible: showRewards,
//         //   child: const Padding(
//         //     padding: EdgeInsets.only(left: 10, right: 10),
//         //     child: Text(rewards, style: TextStyle(color: Colors.black,
//         //         fontSize: 16,
//         //         fontWeight: FontWeight.normal)),
//         //   ),
//         // ),
//         // SizedBox(height: 10),
//
//         _buildPostsRewards(context,posts1.Rewards),
//         //
//         //
//         // Decription
//         // const SizedBox(height: 20,),
//         // const Padding(
//         //   padding: EdgeInsets.only(left: 10.0, right: 10),
//         //   child: const Text(description, style: const TextStyle(
//         //       color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
//         // ),
//         // Padding(
//         //   padding: const EdgeInsets.only(left: 10.0, right: 10),
//         //   child: Html(data: utf8.decode(base64.decode(posts1.CardData.Description))),
//         // ),
//         //
//         //
//         //// terms
//         // const SizedBox(height: 20,),
//         // const Padding(
//         //   padding: EdgeInsets.only(left: 10.0, right: 10),
//         //   child: const Text(terms_cond, style: const TextStyle(
//         //       color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
//         // ),
//         // Padding(
//         //     padding: const EdgeInsets.only(left: 10.0, right: 10),
//         //     child: Html(data: utf8.decode(base64.decode(posts1.CardData.Tnc)))),
//         //
//         // const SizedBox(height: 20,),
//         //
//         // setReferOption(posts1.CardData),
//         //
//       // //  location
//         // const Padding(
//         //   padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//         //   child: Text(location, style: TextStyle(color: Colors.black,
//         //       fontSize: 16,
//         //       fontWeight: FontWeight.normal)),
//         // ),
//         // SizedBox(height: 10,),
//         // Padding(
//         //   padding: const EdgeInsets.only(left: 10, right: 10),
//         //   child: _buildPostsHomeLocation(context,posts1.Locations),
//         // ),
//
//
//         // // About Us
//         // const Padding(
//         //   padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//         //   child: Text(about_us, style: TextStyle(color: Colors.black,
//         //       fontSize: 16,
//         //       fontWeight: FontWeight.normal)),
//         // ),
//         // SizedBox(height: 10,),
//         // Padding(
//         //   padding: const EdgeInsets.only(left: 10, right: 10),
//         //   child: _ECardLocation(context),
//         // ),
//
//       ],
//     );
//   }
// }