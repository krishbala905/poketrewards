

import 'package:flutter/material.dart';
//import 'package:poketrewards/Others/CommonUtils.dart';
//import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/UI/Add/Search/CardsVC.dart';
import 'package:poketrewards/UI/Add/Search/VoucherVc.dart';
import 'package:poketrewards/UI/Wallet/Model/ECardModel.dart';
import 'package:poketrewards/res/Colors.dart';
//import 'package:http/http.dart' as http;
//import 'package:poketrewards/UI/Add/Search/SearchResultModel.dart';



class SearchResultVc extends StatefulWidget {

final String SearchTxt;

 final List<ECardModel> Cards;

  const SearchResultVc({Key? key,required this.Cards,required this.SearchTxt}) : super(key: key);


  @override
  State<SearchResultVc> createState() => _SearchResultVcState(Cards,SearchTxt);

}

class _SearchResultVcState extends State<SearchResultVc> {
var SearchTxt = "";
List<ECardModel>Cards;

  _SearchResultVcState(this.Cards,this.SearchTxt);






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(SearchTxt,style: TextStyle(

      ),),),
      backgroundColor: corporateColor,

      body: new DefaultTabController(
        length: 2,
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
                  Tab(child: Text('CARDS',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13 ),),),
                  Tab(child: Text('VOUCHERS',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),),



                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [

             CardsVc(posts: Cards),
              VoucherVc()



            ],
          ),
        ),
      ),
    );


  }




}


