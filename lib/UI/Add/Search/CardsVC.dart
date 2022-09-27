import 'package:flutter/material.dart';
import 'package:poketrewards/UI/Wallet/Ecards/ECardPrimaryFragment.dart';
import 'package:poketrewards/UI/Wallet/Model/ECardModel.dart';
import 'package:poketrewards/res/Colors.dart';
class CardsVc extends StatefulWidget {
  final List<ECardModel> posts;

  const CardsVc({Key? key,required this.posts }) : super(key: key);


  @override
  State<CardsVc> createState() => _CardsVcState(posts);
}

class _CardsVcState extends State<CardsVc> {
  List<ECardModel> posts;

  _CardsVcState(this.posts);
  bool showData=false;


  @override
  Widget build(BuildContext context) {

    double ScreenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(

        shrinkWrap: true,
        itemCount: posts.length,

        itemBuilder: (context,index ) {
      return InkWell(
        onTap: (){
          var dataa = posts[index];
          print(dataa.toString());
Navigator.push(context, MaterialPageRoute(builder: (context) => ECardPrimaryFragment(dataa.program_title, dataa.program_id, dataa.program_type, dataa.program_title, dataa.img_url, dataa.expire_date, dataa.balance, dataa.sub_type, "28", dataa.merchant_id, dataa.merchant_name)));
         // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultVc(Cards: Cards, SearchTxt: SearchTxt.text.toString(), Vocuher: Vouchers,)));
          print(posts[index].program_title);
        },



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
                             
                             child: GestureDetector(
                               onTap: (){
                                 print("Button");
                               },
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
}
