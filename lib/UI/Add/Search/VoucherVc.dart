import 'package:flutter/material.dart';
import 'package:poketrewards/UI/Wallet/Model/ECardModel.dart';

import '../../../res/Colors.dart';
class VoucherVc extends StatefulWidget {
  final List<ECardModel> posts;

  const VoucherVc({Key? key,required this.posts}) : super(key: key);

  @override
  State<VoucherVc> createState() => _VoucherVcState(posts);
}

class _VoucherVcState extends State<VoucherVc> {
  bool showData = true;
  List<ECardModel> posts;
  _VoucherVcState(this.posts);

  @override
  void initState() {
    // TODO: implement initState
    if (posts.length != 0) {
      print(posts.length);

      setState(() {
        showData = false;
      });
    }


    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Visibility(
        visible: showData,
        child: Center(child: Text("No Voucher Found",style: TextStyle(color: corporateColor),),),
        replacement: _Showvocuher(context, posts));
  }
}
Widget _Showvocuher(BuildContext context, List<ECardModel> posts ) {
  double ScreenWidth = MediaQuery.of(context).size.width;

   return ListView.builder(


      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context,index ) {
        return InkWell(


          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(

                    bottom: BorderSide(
                        color: Colors.grey,
                        width: 1
                    ),
                    left: BorderSide(
                        color: Colors.grey,
                        width: 1
                    ),
                    right: BorderSide(
                        color: Colors.grey,
                        width: 1
                    ),

                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Image.network(posts[index].img_url),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(padding: EdgeInsets.only(left: 20),
                    child: Text(posts[index].program_title
                    ),

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 1.0,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  color: Colors.grey,
                                  width:1
                              ),
                            )
                        ),
                        width: ScreenWidth * 0.5,
                        height: 40,


                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            Expanded(

                              flex: 1,
                              child:
                              Center(
                                child: Text('Free',style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: corporateColor2
                                ),),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child:
                              Container(


                                child: Padding(
                                  padding: EdgeInsets.only(right: 10,left: 10),

                                  child: Container(


                                    decoration: BoxDecoration(
                                        color:corporateColor2,
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    padding: EdgeInsets.all(10),

                                    child: Center(
                                      child: Text("POKET IT",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  )


                ],
              ),
            ),
          ),

        );
      });
}