import 'package:flutter/material.dart';
import 'package:poketrewards/UI/Tabbar/More/ChangePassword.dart';
import 'package:poketrewards/UI/Tabbar/More/Language.dart';
import 'package:poketrewards/UI/Tabbar/More/Privacy.dart';
import 'package:poketrewards/UI/Tabbar/More/Signout.dart';
import 'package:poketrewards/UI/Tabbar/More/Subscribe.dart';
import 'package:poketrewards/UI/Tabbar/More/Tellyourfriends.dart';
import 'package:poketrewards/UI/Tabbar/More/TermsandConditions.dart';
import 'package:poketrewards/res/Colors.dart';

import '../../../res/Strings.dart';
import 'History.dart';
import 'Profile.dart';
import 'feadback.dart';

class MoreTab extends StatefulWidget {
  const MoreTab({Key? key}) : super(key: key);

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            more_appbar,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: PoketMaincolo,
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Profile(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(profile, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => History(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(history, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Language(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(language, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ChangePassword(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(change_password, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Feadback(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(feed_back, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Tellyourfriends(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(tell_your_friends, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Privacy(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(privacy, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => TermsandConditions(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(termsandconditions, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Subscribe(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(subscribe, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Signout(),));
              },
              child: Container(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text(signout, style: TextStyle(
                            color: PoketMaincolo, fontSize: 15),)),
                  )),
            ),
            Container(decoration: BoxDecoration(color: lightgrey), height: 0.5,),
          ],
        )
        //  backgroundColor:  Colors.white54,
      ),
    );
  }
}
