import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:poketrewards/UI/Add/AddFragment.dart';
import 'package:poketrewards/UI/Wallet/WalletFragment.dart';
import 'package:poketrewards/UI/More/MoreFragment.dart';
import 'package:poketrewards/UI/Inbox/InboxFragment.dart';
import 'package:poketrewards/UI/Catalogue/WhatsonFragment.dart';
import '../Others/AlertDialogUtil.dart';
import '../Others/LocalNotificationService.dart';
import '../Others/CommonUtils.dart';
import 'package:http/http.dart' as http;
import '../Others/PPNAPIClass.dart';
import '../Others/Utils.dart';
import '../res/Strings.dart';

class ConsumerTab extends StatefulWidget {

  ConsumerTab({Key? key}) : super(key: key);

  @override
  State<ConsumerTab> createState() => _ConsumerTabState();
}

class _ConsumerTabState extends State<ConsumerTab>{
  String navigatePage="none";

  var tittle=add;
  int _selectedIndex = 0;

  var addActive=1;
  var walletActive=0;
  var whatsOnActive=0;
  var inboxActive=0;
  var moreActive=0;



  static const List<Widget> _widgetOptions = <Widget>[
    AddFragment(),
    WalletFragment(),
    WhatsOnFragment(),
    InboxFragment(),
    MoreFragment(),
  ];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // terminated state;
    LocalNotificationService.initialize(context);

    // Foreground
    FirebaseMessaging.onMessage.listen((message) async {
      if(message.notification!=null){

        try{

           dynamic result= await callPPNAPI(context);
          changeToPage(result);

        }
        catch(e){
          debugPrint("FrgndExcep"+e.toString());
        }
      }
      LocalNotificationService.display(
          message);    });


    // BackGround
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (message.notification != null) {

        try {
          // String navigatePath=callPPNAPI(context).toString();
          dynamic result=await callPPNAPI(context);
          changeToPage(result);

        }
        catch (e) {
          debugPrint("BrgndExcep" + e.toString());
        }
      }
    });


    hideKeyboard();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        dynamic result=await callPPNAPI(context);
        changeToPage(result);
      }
      catch (e) {
        debugPrint("InitExcep" + e.toString());
      }
    });


  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text(tittle),
          backgroundColor: corporateColor
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(flex:1,child: GestureDetector(
                onTap: (){

                  setState(() {
                    _selectedIndex=0;
                    tittle=add;
                    addActive=1;
                    walletActive=0;
                    whatsOnActive=0;
                    inboxActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(addActive, "assets/ic_add_over.png", "assets/ic_add_normal.png"),
                      setActiveTittle(addActive, add),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=1;
                    tittle=e_wallet;
                    addActive=0;
                    walletActive=1;
                    whatsOnActive=0;
                    inboxActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(walletActive, "assets/ic_wallet_over.png", "assets/ic_wallet_normal.png"),
                      setActiveTittle(walletActive, e_wallet),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=2;
                    tittle=whatson;
                    whatsOnActive=1;
                    addActive=0;
                    walletActive=0;
                    inboxActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(whatsOnActive, "assets/ic_catlogue_over.png", "assets/ic_catlogue_normal.png"),
                      setActiveTittle(whatsOnActive, whatson),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=3;
                    tittle=notify;
                    addActive=0;
                    walletActive=0;
                    whatsOnActive=0;
                    inboxActive=1;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          setActive(inboxActive, "assets/ic_inbox_over.png", "assets/ic_inbox_normal.png"),
                          setActiveTittle(inboxActive, notify),
                        ],
                      ),
                      _InboxCount(context),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=4;
                    tittle=more;
                    addActive=0;
                    walletActive=0;
                    whatsOnActive=0;
                    inboxActive=0;
                    moreActive=1;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(moreActive, "assets/ic_more_over.png", "assets/ic_more_normal.png"),
                      setActiveTittle(moreActive, more),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget setActive(var active ,var activeIcon,var inactiveIcon){

    if (active==1){
      return Image.asset(activeIcon,height: 25,width: 25,);
    }
    else{
      return Image.asset(inactiveIcon,height: 25,width: 25,);
    }
  }
  Widget setActiveTittle(var active ,var tittle){

    if (active==1){


      return Text(tittle,style: TextStyle(fontSize: 13,color: corporateColor),);
    }
    else{
      return Text(tittle,style: TextStyle(fontSize: 13,color: grey),);
    }
  }
  void changeToPage(String navigatePath){

    if(navigatePath==CommonUtils.walletPage){
      setState(() {
        _selectedIndex=1;
        tittle=e_wallet;
        addActive=0;
        walletActive=1;
        whatsOnActive=0;
        inboxActive=0;
        moreActive=0;
      });
    }
    else if(navigatePath==CommonUtils.inboxPage){
      print(navigatePath+":Yes");
      setState(() {
        _selectedIndex=3;
        tittle=notify;
        addActive=0;
        walletActive=0;
        whatsOnActive=0;
        inboxActive=1;
        moreActive=0;
      });
    }
    else if(navigatePath==CommonUtils.KEY_FEEDBACK_POINT_TRANSACTION){
      showRewardsDeliveryDialog(context,CommonUtils.PPN_RESPONSE_CONTENT);
    }
    else if(navigatePath==CommonUtils.KEY_MEMBER_POINT_TRANSACTION){
      showRewardsDeliveryDialog(context,CommonUtils.PPN_RESPONSE_CONTENT);
    }
    else if(navigatePath==CommonUtils.none){

    }

  }
  Widget showInboxCount(var _counter){
    if(_counter=="0"){
      return Container();
    }
    else{
      return  Positioned(

        right: 20,
        top: 5,
        child: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(9),
          ),
          constraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: Text(
            '$_counter',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
  Future<String> getInboxCount() async {

    final http.Response response = await http.post(
      Uri.parse(INBOX_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "country_index": "+65",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,

      },
    ).timeout(Duration(seconds: 30));

    if(jsonDecode(response.body)["Status"]=="True")
    {


      var posts1=json.decode(response.body)['Data']['message overall'].toString();
    print("InboxCount:"+posts1);
      return posts1;

    }
    else {

      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<String> _InboxCount(BuildContext context) {

    return FutureBuilder<String>(

      future: getInboxCount(),
      builder: (context, snapshot) {


        if (snapshot.connectionState == ConnectionState.done) {

          final String ? posts = snapshot.data;
          if(posts!=null){
            return _buildPostsInbox(context, posts);
          }
          else{
            return Container();
          }

        } else {
          return Center(
            child:SpinKitCircle(
              color: corporateColor,
              size: 10.0,
            ),
          );
        }
      },
    );
  }
  Widget _buildPostsInbox(BuildContext context, String posts) {
    return showInboxCount(posts);
  }


}



