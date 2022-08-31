import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class WhatsonTab extends StatefulWidget {
  const WhatsonTab({Key? key}) : super(key: key);

  @override
  State<WhatsonTab> createState() => _WhatsonTabState();
}

class _WhatsonTabState extends State<WhatsonTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(title: Text(S.of(context).whatson,style: TextStyle(
            fontSize: 20,

        ),
        ),centerTitle: true,backgroundColor: corporateColor, ),
        backgroundColor:  Colors.white,
      ),

    );
  }
}
