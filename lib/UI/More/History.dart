import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:webview_flutter/webview_flutter.dart';


import '../../Others/CommonUtils.dart';
import '../../res/colors.dart';
import 'package:http/http.dart' as http;
import '../../Others/AlertDialogUtil.dart';
import '../../res/strings.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  void initState() {
    // TODO: implement initState
    super.initState();
    hideKeyboard();

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      appBar: AppBar(backgroundColor: corporateColor,
        automaticallyImplyLeading: true,
        title: Text(history),
        centerTitle: true,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child: WebView(

          gestureNavigationEnabled: true,
          initialUrl: HISTORY_LOG_URL+"/"+"1"+"/"+CommonUtils.consumerID.toString(),
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            showLoadingView(context);
          },
          onPageFinished: (String url) {
            Navigator.pop(context,true);
          },

        ),
      ),
    ));
  }
}
