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

          backgroundColor:  Colors.white,
        ),

    );
  }
}
