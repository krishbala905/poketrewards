import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class WalletFragment extends StatefulWidget {
  const WalletFragment({Key? key}) : super(key: key);

  @override
  State<WalletFragment> createState() => _WalletFragmentState();
}

class _WalletFragmentState extends State<WalletFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(automaticallyImplyLeading:false,title: Text(S.of(context).e_wallet,style: TextStyle(
            fontSize: 20,

        ),
        ),
          centerTitle: true,backgroundColor: corporateColor, ),
        backgroundColor:  Colors.white,
      ),

    );
  }
}
