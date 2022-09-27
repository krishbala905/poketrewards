import 'package:flutter/material.dart';
import 'package:poketrewards/UI/Add/Personal/CustomCard.dart';
import 'package:poketrewards/UI/Add/Personal/CustomDocument.dart';

import 'package:poketrewards/res/Colors.dart';

class PersonalSegment extends StatefulWidget {
  const PersonalSegment({Key? key}) : super(key: key);

  @override
  State<PersonalSegment> createState() => _PersonalSegmentState();
}

class _PersonalSegmentState extends State<PersonalSegment> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
SizedBox(
  height: 30,
),
          Image.asset('assets/personal_tab_img.png',height: 150,),

          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35,right: 35),
            child: Text("This is where you convert your physical document into an e-version (eg: physical card to e-card, receipt to r-receipt) and stored in the e-wallet for your retrieval",textAlign: TextAlign.center ,style: TextStyle(
 fontWeight: FontWeight.w500,
              color:grey,
              fontSize: 13

            ),),
          ),
          SizedBox(
            height: 40,
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CustomCard()));

              print("Tapped");

            },
            child: Container(
              height: 60,
              color: PoketNormalGreen,
              width: ScreenWidth * 0.85,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                        "I’ll take a photo of my physical card"
                   ,style: TextStyle(
                      color: Colors.white,

                    ),

                    ),
                  ),
                  Positioned(child:
                  Center(child: Image.asset('assets/Camera_icon.png',color: Colors.white,width: 20,)),
                 left: 10,
                    top: 10,
                    bottom: 10,


                  )
                ],

              )
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Customdocument()));
            },
            child: Container(
                height: 60,
                color: PoketNormalGreen,
                width: ScreenWidth * 0.85,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "I’ll take a photo of other document"
                        ,style: TextStyle(
                          color: Colors.white
                      ), ),
                    ),
                    Positioned(child:
                    Image.asset('assets/Camera_icon.png',color: Colors.white,width: 20,),
                      left: 10,
                      top: 10,
                      bottom: 10,


                    )
                  ],

                )
            ),
          ),
        ],
      ),
    );
  }
}
