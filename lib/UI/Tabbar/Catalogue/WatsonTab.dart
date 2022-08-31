import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class WatsonTab extends StatefulWidget {
  const WatsonTab({Key? key}) : super(key: key);

  @override
  State<WatsonTab> createState() => _WatsonTabState();
}

class _WatsonTabState extends State<WatsonTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(title: Text(S.of(context).whatson,style: TextStyle(
            fontSize: 20,

        ),
        ),centerTitle: true,backgroundColor: PoketMaincolo, ),
        backgroundColor:  Colors.white,
      ),

    );
  }
}
