import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Strings.dart';
import 'InboxDetails.dart';

class InboxFragment extends StatefulWidget {
  const InboxFragment({Key? key}) : super(key: key);

  @override
  State<InboxFragment> createState() => _InboxFragmentState();
}

class _InboxFragmentState extends State<InboxFragment> {
  var pageNumber=1;
  bool showNoMsg=true;
  bool showContent=false;

  late ScrollController _controller;
  int _page = 0;
  final int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _posts = [];
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1; // Increase _page by 1
      try {
        final res =
        await http.post(Uri.parse(INBOX_URL),
            body:
            {
              "consumer_id": CommonUtils.consumerID.toString(),
              "country_index": "+65",
              "page_number": _page.toString(),
              "cma_timestamps":Utils().getTimeStamp(),
              "time_zone":Utils().getTimeZone(),
              "software_version":CommonUtils.softwareVersion,
              "os_version":CommonUtils.osVersion,
              "phone_model":CommonUtils.deviceModel,
              "device_type":CommonUtils.deviceType,
              'consumer_application_type':CommonUtils.consumerApplicationType,
              'consumer_language_id':CommonUtils.consumerLanguageId,
            }

        );

        final List fetchedPosts = json.decode(res.body)['Data']['Messages'];
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print("Excep4512:"+err.toString());
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
      await http.post(Uri.parse(INBOX_URL),
          body: {
            "consumer_id": CommonUtils.consumerID.toString(),
            "country_index": "+65",
            "page_number": _page.toString(),
            "cma_timestamps":Utils().getTimeStamp(),
            "time_zone":Utils().getTimeZone(),
            "software_version":CommonUtils.softwareVersion,
            "os_version":CommonUtils.osVersion,
            "phone_model":CommonUtils.deviceModel,
            "device_type":CommonUtils.deviceType,
            'consumer_application_type':CommonUtils.consumerApplicationType,
            'consumer_language_id':CommonUtils.consumerLanguageId,
          });
      print("InboxList"+res.body);
      if(json.decode(res.body)['Status']=="False"){
        showNoMsg=true;
        showContent=false;
      }
      else{
        setState(() {
          showNoMsg=false;
          showContent=true;
          _posts = json.decode(res.body)['Data']['Messages'];
        });
      }

    } catch (err) {
      print("Excep12:"+err.toString());
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);

  }
  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child:Scaffold(
          body:_isFirstLoadRunning
              ? const Center(
            child: const CircularProgressIndicator(),
          )
              :
          Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Visibility(
              //     visible: showNoMsg,
              //     child: Center(
              //
              //     )),
              Visibility(
                visible: showNoMsg,
                child: Center(child: Text(noMessage)),
                replacement: Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) =>
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                             InboxDetails(_posts[index]['message_id'], _posts[index]['merchant_name']),
                           ));
                       },
                       child: Container(
                         width: double.infinity,
                         color: Colors.white,
                         child: Column(
                           children: [
                             SizedBox(height: 5,),
                             Row(
                                    children:[
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: messageReadORNot(
                                                _posts[index]['message_read_status'],
                                                _posts[index]['merchant_name'],
                                                _posts[index]['message_title'],
                                                _posts[index]['message_send_date'],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(flex:2,child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black26,size: 25,)),
                                    ]


                                ),
                             SizedBox(height: 5,),
                             Container(height: 1,width: double.infinity,decoration: BoxDecoration(color: Colors.black26),)
                           ],
                         ),
                       ),
                     ),
                  ),
                ),
              ),

              // when the _loadMore function is running
              if (_isLoadMoreRunning == true)
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 40),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

              // When nothing else to load
              if (_hasNextPage == false)
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  color: Colors.amber,
                  child: const Center(
                    child: Text('You have fetched all of the content'),
                  ),
                ),


            ],
          ),
        ),
      );

  }




  Widget messageReadORNot(var active,var merchantName,var tittle,var date) {

    if(active=="1"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          Text(merchantName,style: TextStyle(color: Colors.grey),),
          SizedBox(height: 5,),
          Text(tittle,style: TextStyle(color: Colors.grey),),
          SizedBox(height: 15,),
          Text(date,style: TextStyle(color: Colors.grey),),
          SizedBox(height: 8,),
        ],
      );
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          Text(merchantName,style: TextStyle(color: Colors.black),),
          SizedBox(height: 5,),
          Text(tittle,style: TextStyle(color: Colors.black),),
          SizedBox(height: 15,),
          Text(date,style: TextStyle(color: Colors.black),),
          SizedBox(height: 8,),
        ],
      );
    }

  }

}
