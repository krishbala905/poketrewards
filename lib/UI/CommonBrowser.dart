import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Others/AlertDialogUtil.dart';
import '../res/Colors.dart';

class CommonBrowser extends StatefulWidget {
  var url,tittle;

  CommonBrowser(this.url, this.tittle,{Key? key , }) : super(key: key);
  @override
  State<CommonBrowser> createState() => _CommonBrowserState(url,tittle);

}

class _CommonBrowserState extends State<CommonBrowser> {
  var tittle="";
  var url="";
  _CommonBrowserState(this.url, this.tittle);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      appBar: AppBar(backgroundColor: corporateColor,
      automaticallyImplyLeading: true,
      title: Text(tittle),
      centerTitle: true,),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child: WebView(
            gestureNavigationEnabled: true,
            initialUrl: url,
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
