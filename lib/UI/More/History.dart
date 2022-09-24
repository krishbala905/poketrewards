import 'package:flutter/material.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';
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
    getuserhistory();
  }
  Future<void> getuserhistory() async {
    var data = null;

    print("url:" + HISTORY_LOG_URL);

    final http.Response response = await http.post(Uri.parse(HISTORY_LOG_URL),
      body: {
        "consumer_id": CommonUtils.consumerID,
        // "action_event": "1",
      },
    ).timeout(Duration(seconds: 30));
    print(response.body.toString());
    /*if (response.statusCode == 200) {
      setState(() async {
        stringResponse = response.body;
        mapresponse = await jsonDecode(response.body);
        listresponse = mapresponse['data'];
        //listresponse =mapresponse['data'];
      });
    } else {
      showAlertDialog_oneBtn(context, alert, something_went_wrong);
    }*/
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: corporateColor,
            centerTitle: true,
            title: Text(
              history,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          body:
          ListView.builder(itemBuilder: (context,index){
            return Container(
              child: Column(
                children: [
                  // Text(listresponse[index].toString()),
                ],
              ),);

          },
           //  itemCount: listresponse==null? 0: listresponse.length,)
        /* Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: listresponse == null
                    ? Container()
                    :
                    //child: Text(stringResponse.toString()),
                    Text(listresponse[0].toString()),
              ),
            ),
          ),*/
      ),
      ),
    );
  }
}
