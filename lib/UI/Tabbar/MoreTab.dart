import 'package:flutter/material.dart';
import 'package:poketrewards/res/Colors.dart';

class MoreTab extends StatefulWidget {
  const MoreTab({Key? key}) : super(key: key);

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(title: Text('Add',style: TextStyle(
            fontSize: 20,
          color: Colors.white,
        ),
        ),backgroundColor: PoketMaincolo, ),
        backgroundColor:  Colors.white54,
      ),

    );
  }
}
