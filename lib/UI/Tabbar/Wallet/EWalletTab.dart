import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class EwalletTab extends StatefulWidget {
  const EwalletTab({Key? key}) : super(key: key);

  @override
  State<EwalletTab> createState() => _EwalletTabState();
}

class _EwalletTabState extends State<EwalletTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(title: Text(S.of(context).e_wallet,style: TextStyle(
            fontSize: 20,

        ),
        ),
          centerTitle: true,backgroundColor: corporateColor, ),
        backgroundColor:  Colors.white,
      ),

    );
  }
}
