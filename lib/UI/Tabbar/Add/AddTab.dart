import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class AddTab extends StatefulWidget {
  const AddTab({Key? key}) : super(key: key);

  @override
  State<AddTab> createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> {

  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
        child:Scaffold(

          appBar: AppBar(title: Text(S.of(context).add,style: TextStyle(
            fontSize: 20


          ),

          ),
          //elevation: 0.0,
            centerTitle: true,
          backgroundColor: PoketMaincolo,),
          backgroundColor:  Colors.white,
        ),

    );
  }
}
