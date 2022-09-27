import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../res/colors.dart';
import '../../res/strings.dart';
import 'package:http/http.dart' as http;



class InboxDetails extends StatefulWidget {
  var cid,merid,mername,msgid,msgtype,msgsubtype,msgsenddate,msgreadstatus,msgtitile,merchlogo;


  InboxDetails(this.cid,this.merid,this.mername,this.msgid,this.msgtype,this.msgsubtype,this.msgsenddate,this.msgreadstatus,this.msgtitile,this.merchlogo,{Key? key , }) : super(key: key);

  @override
  State<InboxDetails> createState() => _InboxDetailsState(cid,merid,mername,msgid,msgtype,msgsubtype,msgsenddate,msgreadstatus,msgtitile,merchlogo);
}

class _InboxDetailsState extends State<InboxDetails> {
  var cid,merid,mername,msgid,msgtype,msgsubtype,msgsenddate,msgreadstatus,msgtitile,merchlogo;
  _InboxDetailsState(this.cid,this.merid,this.mername,this.msgid,this.msgtype,this.msgsubtype,this.msgsenddate,this.msgreadstatus,this.msgtitile,this.merchlogo);

/*bool showdata = false;
bool imgdata = false;
bool statusdata = false;*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(mername,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: corporateColor,
      ),
      body:
      _InboxDetails(context),

    ));

  }
  FutureBuilder<List<dynamic>> _InboxDetails(BuildContext context) {

    return FutureBuilder<List<dynamic>>(

      future: getInboxDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<dynamic>? posts = snapshot.data;
          /*if(posts!=null){
            return _buildPostsHome(context, posts);
          }
          else{
            return Container();
          }*/
          if(posts!=null){
            return SingleChildScrollView(

              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height:MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: WebView(
                        initialUrl: posts[0],
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                    ),
                    posts[1] != "none" ?
                    Container(
                      height: 350.0,
                      child: Column(
                        children: [
                          Image.network(posts[1],),
                          Text(posts[2],style: TextStyle(fontSize: 15.0),),
                        ],
                      ),
                    ): Container(height: 10.0,)
                  ],
                ),
              ),
            );
          }
          else{
            return Container();
          }

        } else {
          return Center(
            child:SpinKitCircle(
              color: corporateColor,
              size: 30.0,
            ),
          );
        }
      },
    );
  }
  Future<List> getInboxDetails() async {


    final http.Response response = await http.post(
      Uri.parse(INBOX_DETTAILS_URL),

      body: {
        "merchant_id": merid,
        "consumer_id": CommonUtils.consumerID.toString(),
        "country_index":cid,
        "message_type" :msgtype,
        "message_sub_type":msgsubtype,
        "message_id": msgid,
        /*"cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),*/
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        "device_TokenID":CommonUtils.deviceTokenID,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
      },
    ).timeout(Duration(seconds: 30));

    debugPrint("check4"+ response.body.toString());
    if(response.statusCode==200 && jsonDecode(response.body)['data']!="")
    {
      Map<String, dynamic> body1 = jsonDecode(response.body)["data"];
      print(body1.toString());
      print(body1["html_file"].toString());
      List mylist = body1.values.toList();
      print(mylist[1]);
      return mylist;

      //  List<dynamic> body1 = jsonDecode(response.body)["data"];
      // List<InboxInitModel> posts1 = body1.map((dynamic item) => InboxInitModel.fromJson(item),).toList();
      // debugPrint("hii"+posts1.toString());
      // return posts1;
    }
    else {

      throw "Unable to retrieve posts.";
    }

  }
/*ListView _buildPostsHome(BuildContext context, List<dynamic> posts) {
    // showData=true;
    print("check2 "+ posts.toString());
    if(posts![0]=="none"){
      showdata = true;
    }
    if(posts![1]=="none"){
      imgdata = true;
    }
    if(posts![2]=="none"){
      statusdata = true;
    }
    return ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        // padding: const EdgeInsets.only(bottom:2.0),
        return Padding(
          padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: showdata,
                  child: Container(height: 1.0,),
                  replacement: WebView(
                    initialUrl: posts[0],
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Visibility(
                  visible: imgdata,
                  child: Container(height: 1.0,),
                  replacement: Center(
                    child:Image.network(posts[1],),
                  ),
                ),
                Visibility(
                    visible: statusdata,
                    child: Container(height: 1.0,),
                    replacement: Text(posts[2],style: TextStyle(fontSize: 15.0),)),
              ],
            )

        );
      },
    );
  }*/
}


