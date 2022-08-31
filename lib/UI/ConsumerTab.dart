import 'package:flutter/material.dart';
import 'package:poketrewards/UI/SplashScreen.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:poketrewards/UI/Tabbar/Add/AddFragment.dart';
import 'package:poketrewards/UI/Tabbar/Wallet/WalletFragment.dart';
import 'package:poketrewards/UI/Tabbar/More/MoreFragment.dart';
import 'package:poketrewards/UI/Tabbar/Inbox/InboxFragment.dart';
import 'package:poketrewards/UI/Tabbar/Catalogue/WhatsonFragment.dart';
import '../Others/LocalNotificationService.dart';
import '../Others/CommonUtils.dart';
import 'package:poketrewards/generated/l10n.dart';

class ConsumerTab extends StatefulWidget {

  ConsumerTab({Key? key}) : super(key: key);

  @override
  State<ConsumerTab> createState() => _ConsumerTabState();
}

class _ConsumerTabState extends State<ConsumerTab>{
  String navigatePage="none";

  var tittle="Home";
  int _selectedIndex = 0;


  var homeActive=1;
  var rewardsActive=0;
  var walletActive=0;
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

          dynamic result=await callPPNAPI(context);
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
          debugPrint("FrgndExcep" + e.toString());
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
                    tittle=home;
                    homeActive=1;
                    walletActive=0;
                    rewardsActive=0;
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
                      setActive(homeActive, "assets/home_filled.png", "assets/home_outlined.png"),
                      setActiveTittle(homeActive, home),
                    ],
                  ),
                ),
              )),
              Visibility(
                visible: false,
                child: Expanded(flex:1,child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedIndex=1;
                      tittle=rewards;
                      rewardsActive=1;
                      homeActive=0;
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
                        setActive(rewardsActive, "assets/reward_filled.png", "assets/reward_outline.png"),
                        setActiveTittle(rewardsActive, rewards),
                      ],
                    ),
                  ),
                )),
              ),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=2;
                    tittle=wallet;
                    homeActive=0;
                    walletActive=1;
                    rewardsActive=0;
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
                      setActive(walletActive, "assets/wallet_filled.png", "assets/wallet_outlined.png"),
                      setActiveTittle(walletActive, wallet),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=3;
                    tittle=inbox;
                    homeActive=0;
                    walletActive=0;
                    rewardsActive=0;
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
                          setActive(inboxActive, "assets/inbox_filled.png", "assets/inbox_outlined.png"),
                          setActiveTittle(inboxActive, inbox),
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
                    homeActive=0;
                    walletActive=0;
                    rewardsActive=0;
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
                      setActive(moreActive, "assets/more_filled.png", "assets/more_outlined.png"),
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
    CommonUtils.PPN_RESPONSE_CONTENT="{\"STATUS\":\"True\",\"OUTLETID\":\"1977\",\"COUNTRYINDEX\":\"191\",\"TRANSACTIONVALUE\":\"10\",\"TRANSACTIONTYPE\":\"PointsEarned\",\"RECEIVED\":\"none\",\"RECEIVED_TITLE\":\"none\",\"TOPUP\":\"none\",\"TOPUP_TITLE\":\"none\",\"DEDUCT\":\"none\",\"DEDUCT_TITLE\":\"none\",\"REDEEMED\":\"none\",\"REDEEMED_TITLE\":\"none\",\"CASHREBATE\":\"none\",\"CASHREBATE_TITLE\":\"none\",\"PUNCHREWARD\":\"none\",\"PUNCHREWARD_TITLE\":\"none\",\"PACKAGEDEDUCTED\":\"none\",\"PACKAGEDEDUCTED_TITLE\":\"none\",\"CARD_BALANCE_AFTER_DEDUCT\":\"none\",\"CARD_BALANCE_AFTER_DEDUCT_TITLE\":\"none\",\"UPGRADED\":\"none\",\"UPGRADED_TITLE\":\"none\",\"IS_SPENDING\":\"yes\",\"TRANSACTIONID\":\"149796\",\"PROGRAM_ID\":\"10965\",\"CARD_TITLE\":\"1\",\"CARD_URL\":\"https:\\/\\/brands.poket.com\\/main\\/.\\/merchant_images\\/1574\\/merchant_card\\/card_image\\/10965\\/1574_10965_01.png->image\",\"ACTION\":\"mpt\",\"FB_POINTS\":\"0\",\"FEEDBACK_POINTS\":\"0\",\"MERCHANT_NAME\":\"LETSCHANGE\",\"MERCHANT_ID\":\"1574\",\"CARD_TYPE\":\"points\",\"MEMBER_ID\":\"232757\",\"show_screen\":\"CARDS\"}";
    if(navigatePath==CommonUtils.walletPage){
      setState(() {
        _selectedIndex=2;
        tittle=wallet;
        homeActive=0;
        walletActive=1;
        rewardsActive=0;
        inboxActive=0;
        moreActive=0;
      });
    }
    else if(navigatePath==CommonUtils.inboxPage){
      print(navigatePath+":Yes");
      setState(() {
        _selectedIndex=3;
        tittle=inbox;
        homeActive=0;
        walletActive=0;
        rewardsActive=0;
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
      Uri.parse(INBOX_Url),

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
          return _buildPostsInbox(context, posts!);
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



