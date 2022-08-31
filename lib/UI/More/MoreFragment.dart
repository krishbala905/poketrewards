import 'package:flutter/material.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/UI/More/ChangePassword.dart';
import 'package:poketrewards/UI/More/History.dart';
import 'package:poketrewards/UI/More/Language.dart';
import 'package:poketrewards/UI/More/Privacy.dart';
import 'package:poketrewards/UI/More/Profile.dart';
import 'package:poketrewards/UI/More/Signout.dart';
import 'package:poketrewards/UI/More/Subscribe.dart';
import 'package:poketrewards/UI/More/Tellyourfriends.dart';
import 'package:poketrewards/UI/More/TermsandConditions.dart';
import 'package:poketrewards/UI/More/feadback.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';

import '../../../res/Strings.dart';

class MoreFragment extends StatefulWidget {
  const MoreFragment({Key? key}) : super(key: key);

  @override
  State<MoreFragment> createState() => _MoreFragmentState();
}

class _MoreFragmentState extends State<MoreFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

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
                        child: Text(S.of(context).profile, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).history, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).lang_uage, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).change_password, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).feed_back, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).tell_your_friends, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).privacy, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).termsandconditions, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).subscribe, style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
                        child: Text(S.of(context).signout + "  (" + CommonUtils.consumerEmail.toString() +
                            ")", style: TextStyle(
                            color: corporateColor, fontSize: 15),)),
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
