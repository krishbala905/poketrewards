import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:launch_review/launch_review.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';

void showAlertDialog_oneBtn(BuildContext context,String tittle,String message)
{
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: Text(tittle),
    // content: CircularProgressIndicator(),
    content: Text(message,style: TextStyle(color: Colors.black45)),
    actions: [
      GestureDetector(
        onTap: (){Navigator.pop(context,true);},
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
  );
}

void showLoadingView(BuildContext context){
AlertDialog   alert = AlertDialog(
    backgroundColor: Colors.white,

    // content: CircularProgressIndicator(),
    content: Container(
      height: 50,
      child: Center(
        child: Row(
          children: [
            SpinKitCircle(
            color: corporateColor,
            size: 50.0,
            ),
            Text("  Loading..." ,style: TextStyle(color: Colors.black,fontSize: 18),),
          ],
        ),
      ),
    ),

  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}