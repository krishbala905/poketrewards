import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class AddFragment extends StatefulWidget {
  const AddFragment({Key? key}) : super(key: key);

  @override
  State<AddFragment> createState() => _AddFragmentState();
}

class _AddFragmentState extends State<AddFragment> {

  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
        child:Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading:false,
            title: Text(S.of(context).add,style: TextStyle(
            fontSize: 20),

          ),
          //elevation: 0.0,
            centerTitle: true,
          backgroundColor: corporateColor,),
          backgroundColor:  Colors.white,
        ),

    );
  }
}
