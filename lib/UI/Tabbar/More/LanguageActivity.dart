import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';

enum language{english,japanese,Czech,Spanish}
class LanguageActivity extends StatefulWidget {
  const LanguageActivity({Key? key}) : super(key: key);
  @override
  State<LanguageActivity> createState() => _LanguageActivityState();
}

class _LanguageActivityState extends State<LanguageActivity> {
language _site = language.english;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context, true);
            // _goBack(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: PoketNormalGreen,
        centerTitle: true,
        title:  Text(
          lang_uage,
          style: TextStyle(color: textcolor, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          SizedBox(
            height: 80,
          ),
          Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
          Ink(
            color: _site == language.english? PoketMaincolo : Colors.transparent,
            child: ListTile(
              title:  Text(eng_lish,style: TextStyle(
                  fontSize: 18
              ),),
              trailing:  Radio(
                value: language.english,
                groupValue: _site,
                activeColor: Colors.white,
                onChanged: (language? value) {

                  setState(() {
                    _site = value!;

                   // fillColor: MaterialStateColor.resolveWith((states) => Colors.white);
                  });
                },
              ),
            ),
          ),
          Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
          Ink(
            color: _site == language.japanese? PoketMaincolo : Colors.transparent,
            child: ListTile(
              title:  Text(jap_anese,style: TextStyle(
                  fontSize: 18
              ),),
              trailing:  Radio(
                activeColor: Colors.white,
                value: language.japanese,
                groupValue: _site,
                onChanged: (language? value) {
                  setState(() {
                    _site = value!;
                  });
                },
              ),
            ),
          ),
          Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
          Ink(
            color: _site == language.Czech? PoketMaincolo : Colors.transparent,
            child: ListTile(
              title:  Text(cze_ch,style: TextStyle(
                  fontSize: 18
              ),),
              trailing:  Radio(
                activeColor: Colors.white,
                value: language.Czech,
                groupValue: _site,
                onChanged: (language? value) {
                  setState(() {
                    _site = value!;
                  });
                },
              ),
            ),
          ),
          Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
          Ink(
            color: _site == language.Spanish? PoketMaincolo : Colors.transparent,
            child: ListTile(
              title:  Text(spa_nish,style: TextStyle(
                  fontSize: 18
              ),),
              trailing:  Radio(
                activeColor: Colors.white,
                value: language.Spanish,
                groupValue: _site,
                onChanged: (language? value) {
                  setState(() {
                    _site = value!;
                  });
                },
              ),
            ),
          ),
          Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              var selectedlanguage = _site.toString();
              debugPrint(selectedlanguage);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: PoketMaincolo,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: textcolor),
                ),
                child: Center(
                    child: Text(
                      update,
                      style: TextStyle(color: textcolor, fontSize: 15,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
          ),
        ],

      ),
    ));
  }
}
