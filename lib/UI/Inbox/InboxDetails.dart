import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../res/colors.dart';
import '../../res/strings.dart';



class InboxDetails extends StatefulWidget {
  var id,tittle;

  InboxDetails(this.id, this.tittle,{Key? key , }) : super(key: key);

  @override
  State<InboxDetails> createState() => _InboxDetailsState(id,tittle);
}

class _InboxDetailsState extends State<InboxDetails> {
  var tittle="";
  var id="";
  var url="";
  _InboxDetailsState(this.id, this.tittle);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    url=INBOX_DETAILS_URL+CommonUtils.consumerID.toString()+"/"+id;
    print("InboxDetailUrl:"+url);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: (){Navigator.pop(context,true);},
              child: Icon(Icons.arrow_back_ios,color: Colors.white,),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: corporateColor,
            centerTitle: true,
            title: const Text(appName,style: TextStyle(color: Colors.white,fontSize:20 ),),
          ),
          body: WebView(
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
        ));
  }

}
