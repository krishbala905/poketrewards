import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poketrewards/UI/Add/Personal/PersonalSegment.dart';
//import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/UI/Add/MyQrSegment.dart';
import 'package:poketrewards/UI/Add/SearchSegment.dart';



class AddFragment extends StatefulWidget {
  const AddFragment({Key? key}) : super(key: key);

  @override
  State<AddFragment> createState() => _AddFragmentState();
}

class _AddFragmentState extends State<AddFragment> {

  
  
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 4,
      child: new Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new Container(
            decoration: BoxDecoration(color:lightGrey2),
            height: 40.0,
            child: new TabBar(
              indicatorColor: corporateColor,
              unselectedLabelColor: Colors.black,
              labelColor:corporateColor,


              tabs: [
                Tab(child: Text('My QR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10 ),),),
                Tab(child: Text('SCAN',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),),
                Tab(child: Text('SEARCH',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10 ),),),
                Tab(child: Text('PERSONAL',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),),


              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            MyQrSegment(),
            MyQrSegment(),
          SearchSegment(),
            PersonalSegment()


          ],
        ),
      ),
    );
  }



}
