import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/LanguageChangeProvider.dart';
import 'package:poketrewards/UI/SplashScreen.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';



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
          onPressed: () async {
            await  Navigator.push(context, MaterialPageRoute(builder: (_)=> SplashScreen()));

          },
        ),
        elevation: 0.0,
        backgroundColor: corporateColor2,
        centerTitle: true,
        title:  Text(
         S.of(context,).lang_uage,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          SizedBox(
            height: 80,
          ),
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          Ink(
            color: _site == language.english? corporateColor : Colors.transparent,
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
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          Ink(
            color: _site == language.japanese? corporateColor : Colors.transparent,
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
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          Ink(
            color: _site == language.Czech? corporateColor : Colors.transparent,
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
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          Ink(
            color: _site == language.Spanish? corporateColor : Colors.transparent,
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
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,)  ,
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () async {
              var selectedlanguage = _site.toString();
              debugPrint(selectedlanguage);
              if(selectedlanguage == "language.japanese"){
                CommonUtils.APPLICATIONLANGUAGEID ="2";
                context.read<LanguageChangeProvider>().changeLocale("ja");

              }
              else if(selectedlanguage == "language.english"){
                CommonUtils.APPLICATIONLANGUAGEID = "1";
                context.read<LanguageChangeProvider>().changeLocale("en");

              }
              else if(selectedlanguage == "language.Czech"){
                CommonUtils.APPLICATIONLANGUAGEID = "3";
                context.read<LanguageChangeProvider>().changeLocale("cs");
              }
              else if(selectedlanguage == "language.Spanish"){
                CommonUtils.APPLICATIONLANGUAGEID = "4";
                context.read<LanguageChangeProvider>().changeLocale("es");
              }
              else{
                debugPrint("anything Pressed");
              }
              SharedPreferences pre=await SharedPreferences.getInstance();
              pre.setString("ApplicationLanguageId", CommonUtils.APPLICATIONLANGUAGEID.toString());
              print("langId2:"+CommonUtils.APPLICATIONLANGUAGEID.toString());
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SplashScreen(),));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: corporateColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: textColor),
                ),
                child: Center(
                    child: Text(
                      update,
                      style: TextStyle(color: textColor, fontSize: 15,fontWeight: FontWeight.bold),
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


