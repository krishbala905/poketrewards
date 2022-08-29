import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class NotificationTab extends StatefulWidget {
  const NotificationTab({Key? key}) : super(key: key);

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(title: Text(S.of(context).notify,style: TextStyle(
            fontSize: 20,
          color: Colors.white
        ),
        ), backgroundColor: PoketMaincolo,),
        backgroundColor:  PoketMaincolo,
      ),

    );
  }
}
