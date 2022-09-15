
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poketrewards/Others/CommonUtils.dart';

import 'package:poketrewards/UI/Add/Search/SearchResultVc.dart';
import 'package:poketrewards/UI/Wallet/Model/ECardModel.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:http/http.dart' as http;
import 'package:poketrewards/Others/Urls.dart';

 class SearchSegment extends StatefulWidget {
   const SearchSegment({Key? key}) : super(key: key);

   @override
   State<SearchSegment> createState() => _SearchSegmentState();
 }

 class _SearchSegmentState extends State<SearchSegment> {
   TextEditingController SearchTxt = TextEditingController();
   @override
   Widget build(BuildContext context) {
     double ScreenWidth = MediaQuery.of(context).size.width;
     return Scaffold(
       body: Column(
         children: [
           SizedBox(
             height: 30,
           ),
           Center(
             child: Text('Please enter merchant name',style: TextStyle(
               fontWeight: FontWeight.w500,
               fontSize: 16,
               color:corporateColor,
             ),),
           ),
           SizedBox(
             height: 35,
           ),
           Container(

               padding: EdgeInsets.only(left: 20.0,right: 20),
               child: TextField(
                 controller: SearchTxt,
                 style: TextStyle(
                   letterSpacing: 1,
                   color: Colors.black,
                 ),
                 decoration: InputDecoration(


                 ),
               )
           ),
           SizedBox(
             height: 40,
           ),
           GestureDetector(
             onTap: (){
               print("Tappe");
               SearchApinew(SearchTxt.text.toString());


             },
             child: Container(
               width:  ScreenWidth * 0.9,
               height: 50,

               decoration: BoxDecoration(
                   color: corporateColor,
                   border: Border.all(color:corporateColor),
                   borderRadius: BorderRadius.all(Radius.circular(25))
               ),
               child: Center(
                 child: Text('SEARCH',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     letterSpacing: 1,
                     color: background,
                     fontSize: 18,
                   ),
                 ),
               ),




             ),
           ),

         ],
       ),
     );
   }
   Future<void>SearchApinew(var Txt ) async{

     final http.Response response = await http.post(
         Uri.parse(SEARCH_URL),
         body: {
           'consumer_id' : CommonUtils.consumerID,
           'keyword' : Txt
         }
     ).timeout(Duration(seconds: 30));


     if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True") {
       print("Search:"+response.body.toString());
       List<dynamic> body = jsonDecode(response.body)["data"]["Cards"];
       List<ECardModel> posts1 = body.map((dynamic item) => ECardModel.fromJson(item),).toList();



 Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultVc(Cards: posts1, SearchTxt: SearchTxt.text.toString())));


     }
     else {

     }

   }


 }
