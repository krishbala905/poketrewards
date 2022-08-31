import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class WhatsOnFragment extends StatefulWidget {
  const WhatsOnFragment({Key? key}) : super(key: key);

  @override
  State<WhatsOnFragment> createState() => _WhatsOnFragmentState();
}

class _WhatsOnFragmentState extends State<WhatsOnFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(automaticallyImplyLeading:false,
          title: Text(S.of(context).whatson,style: TextStyle(
            fontSize: 20,

        ),),
          centerTitle: true,backgroundColor: corporateColor, ),
        backgroundColor:  Colors.white,
      ),

    );
  }
}
