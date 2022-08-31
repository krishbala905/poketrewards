import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/colors.dart';
import 'package:http/http.dart' as http;

import '../Others/AlertDialogUtil.dart';
import '../Others/CommonUtils.dart';
import '../res/Strings.dart';
class TransactionFeedback extends StatefulWidget {
  var rewardPoints, transID, prgmId;
  TransactionFeedback(this.rewardPoints,this.transID,this.prgmId,{Key? key}) : super(key: key);

  @override
  State<TransactionFeedback> createState() => _TransactionFeedbackState(rewardPoints,transID,prgmId);
}

class _TransactionFeedbackState extends State<TransactionFeedback> {
  var rewardPoints, transID, prgmId;


  _TransactionFeedbackState(this.rewardPoints, this.transID, this.prgmId);

  var ratingValue="-1";
  TextEditingController commentCntrller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title:  Text(appName),
            backgroundColor: corporateColor
        ),
        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.only(left:20,right: 20,top: 30),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: lightgrey
                  )
              ),
              width: double.infinity,
              child:Column(
                children: [
                  SizedBox(height: 30,),
                  Text(please_rate_our_service,style: TextStyle(fontSize: 18,color: poketPurple),),
                  SizedBox(height: 5,),
                  Text(tap_smile_button_msg,style: TextStyle(color: poketPurple),),
                  SizedBox(height: 30,),
                  Container(

                    height: 100,
                    color: lightgrey2,
                    child: Center(
                      child: RatingBar.builder(
                        itemSize: 50,
                        initialRating: 0,
                        itemCount: 4,
                        unratedColor: lightgrey,
                        updateOnDrag: false,
                        tapOnlyMode: true,
                        wrapAlignment: WrapAlignment.center,
                        itemPadding: EdgeInsets.only(left:10,right: 10),
                        onRatingUpdate: (rating){
                          ratingValue=rating.toString();
                          print(rating.toString());
                        },
                        itemBuilder: (context,index){
                          switch(index){

                            case 0:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:const [
                                  Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: corporateColor,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(poor,style: TextStyle(fontSize: 10),),
                                ],
                              );

                            case 1:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.sentiment_neutral,
                                    color: corporateColor,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(average,style: TextStyle(fontSize: 10),),
                                ],
                              );
                            case 2:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.sentiment_satisfied,
                                    color: corporateColor,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(good,style: TextStyle(fontSize: 10),),
                                ],
                              );
                            case 3:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: corporateColor,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(excellent,style: TextStyle(fontSize: 10),),
                                ],
                              );

                            default:
                              return Container();

                          }
                        },

                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(feedback,style: TextStyle(color: corporateColor,),),
                        SizedBox(height:10,),
                        TextField(
                          controller: commentCntrller,
                          maxLines: 8, //or null
                          style: TextStyle(fontSize: 15),

                          decoration: InputDecoration(

                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: lightgrey, width: 1.0),
                                borderRadius: BorderRadius. circular(5.0),
                              ),
                              enabledBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: lightgrey, width: 1.0),
                                borderRadius: BorderRadius. circular(5.0),
                              ),
                              disabledBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: lightgrey, width: 1.0),
                                borderRadius: BorderRadius. circular(5.0),
                              ),

                              hintText: key_in_your_message

                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: (){Navigator.pop(context,true);},
                          child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              color: lightgrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: Text(skip,style: TextStyle(color: Colors.white),)),
                          )),
                      SizedBox(width: 40,),
                      InkWell(
                          onTap: (){
                            // Call API
                            if(ratingValue!="-1"){
                              updateFeedbackData(rewardPoints, transID,
                                  prgmId,ratingValue, commentCntrller.text);
                            }
                            else{
                              showAlertDialog_oneBtn(context, alert1,please_choose_rating );
                            }

                          },
                          child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              color: corporateColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: Text(submit,style: TextStyle(color: Colors.white,),)),
                          ))
                    ],
                  ),
                  SizedBox(height: 15,),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateFeedbackData(var rewardPoints, var transID,
      var prgmId,var rating, var comments) async {
    showLoadingView(context);
    final http.Response response = await http.post(
      Uri.parse(FEEDBACK_URL),

      body: {
        "consumer_id": CommonUtils.consumerID,
        "program_id": prgmId,
        "comments": comments,
        "rating": rating,
        "reward_points": rewardPoints,
        "transaction_id": transID,
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

    Navigator.pop(context,true);
    print(response.body.toString());
    var data=jsonDecode(response.body);
    var status=data['Status'];
    var msg=data['Message'];
    if(status=='true'|| status=='1'){
      Navigator.pop(context);
      showThanksDialog(context,msg);
    }
    else{
      showAlertDialog_oneBtn(context, alert1, msg);
    }

  }
}
