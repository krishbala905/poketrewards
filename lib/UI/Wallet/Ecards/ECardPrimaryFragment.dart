import 'package:flutter/material.dart';
import 'package:poketrewards/UI/More/ChangePassword.dart';

import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import 'ECardDetailsFragment.dart';
import 'WhatsOnCardFragment.dart';

class ECardPrimaryFragment extends StatefulWidget {
  var prgmTittle ;
  var prgmImgUrl ;
  var tittle ;
  var prgMId ;
  var prgmType;
  var expire_date,merchantName;
  var balancePoints,merchantId;
  var subType,memberId;
  ECardPrimaryFragment(this.tittle,this.prgMId,this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.balancePoints,this.subType,this.memberId,this.merchantId,this.merchantName,{Key? key}) : super(key: key);

  @override
  State<ECardPrimaryFragment> createState() => _ECardPrimaryFragmentState(tittle,prgMId,prgmType,prgmTittle,prgmImgUrl,expire_date,balancePoints,subType,memberId,merchantId,merchantName);

}

class _ECardPrimaryFragmentState extends State<ECardPrimaryFragment> {
  var myCardDetailsData;
  var tittle,merchantName ;
  var prgMId ,memberid;
  var prgmType,subType,merchantId;
  var prgmTittle,prgmImgUrl,expire_date,balancePoints;

  _ECardPrimaryFragmentState(this.tittle, this.prgMId, this.prgmType,this.prgmTittle,this.prgmImgUrl,this.expire_date,this.balancePoints,this.subType,this.memberid,this.merchantId,this.merchantName);

  @override
   Widget build(BuildContext context) {

      return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: corporateColor,
          title: Text(merchantName),
          centerTitle: true,
          leading: GestureDetector(
            onTap: (){Navigator.pop(context,true);},
            child: Icon(Icons.arrow_back_ios,color: Colors.white60,),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child:  SafeArea(
            child: Scaffold(
              appBar:  PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  decoration: BoxDecoration(color: lightGrey2),
                  height: 40.0,
                    child: const TabBar(
                      labelColor: corporateColor3,
                      indicatorColor: corporateColor3,
                      unselectedLabelColor: Colors.black54,

                      tabs: [
                        Tab(child: Text(mycards,style: TextStyle(fontSize: 14),),),
                        Tab(child: Text(whatson_caps,style:TextStyle(fontSize: 14),),
                        ),

                      ],
                    ),

                ),
              ),
              body: TabBarView(
                children: [

                  ECardDetailsFragment(
                  prgmTittle,
                  prgMId,
                  prgmType,
                  prgmTittle, prgmImgUrl,
                  expire_date,balancePoints,
                  subType,memberid,merchantId
                  ),


                  WhatsOnCardFragment(merchantId),
                ],
              ),
            ),
          ),
        ),
      );
    }

}
