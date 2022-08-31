import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class InboxTab extends StatefulWidget {
  const InboxTab({Key? key}) : super(key: key);

  @override
  State<InboxTab> createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(title: Text(S.of(context).notify,style: TextStyle(
            fontSize: 20,
          color: Colors.white
        ),
        ), centerTitle: true,backgroundColor: corporateColor,),
        backgroundColor:  Colors.white,
      ),

    );
  }
}
